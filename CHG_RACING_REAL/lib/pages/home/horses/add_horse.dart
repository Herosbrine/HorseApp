import 'package:chg_racing/constants/globals.dart';
import 'package:chg_racing/services/authentication.dart';
import 'package:chg_racing/services/convert_date.dart';
import 'package:chg_racing/services/new_horse_service.dart';
import 'package:chg_racing/utilities/custom_appbar.dart';
import 'package:chg_racing/utilities/custom_button.dart';
import 'package:chg_racing/utilities/custom_textfield.dart';
import 'package:chg_racing/utilities/styling.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddNewHorse extends StatefulWidget {
  const AddNewHorse(
      {Key? key, this.horseId, this.dateTime, this.name, this.status})
      : super(key: key);
  final String? horseId, name, status;
  final DateTime? dateTime;

  @override
  _AddNewHorseState createState() => _AddNewHorseState();
}

class _AddNewHorseState extends State<AddNewHorse> {
  NewHorseService newHorseService = NewHorseService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
  String? initialStatus, initialName;
  DateTime dateTime = DateTime.now();
  DateTime? initialDateTime;

 // List<String> statusList = ['Absent', 'Vacances', 'Course'];

  @override
  void initState() {
    super.initState();
    _updateInitials(widget.name, widget.status, widget.dateTime);

    _statusController.text = widget.status??'';
    _nameController.text = widget.name ?? '';
    if (widget.dateTime != null) dateTime = widget.dateTime!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title:
        widget.horseId != null ? "Modifier l'cheval" : "Ajout d'un cheval",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _showNewHorseFormFields(),
                SizedBox(height: AppGlobals.screenHeight * 0.06),
                CustomFlatButton(
                  title: "Sauvegarder l'cheval",
                  onTap: () {
                    _submitNewHorse();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _showNewHorseFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            'Nom Complet',
            style: Styling.setTextStyle(size: 18, fontWeight: FontWeight.w600),
          ),
        ),
        CustomTextField(
          hintText: 'Nom Complet',
          controller: _nameController,
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value.isEmpty) {
              return "Veuillez entrer le nom de l'cheval";
            }
            return null;
          },
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            'Statut',
            style: Styling.setTextStyle(size: 18, fontWeight: FontWeight.w600),
          ),
        ),
        CustomTextField(
          hintText: 'Statut',
          controller: _statusController,
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value.isEmpty) {
              return "Veuillez entrer le statut";
            }
            return null;
          },
        ),

        SizedBox(height: 8),

        showDate(),
      ],
    );
  }
  //
  // Widget _NewHorseStatus() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(
  //           'Statut',
  //           style: Styling.setTextStyle(size: 18, fontWeight: FontWeight.w600),
  //         ),
  //         Container(
  //           width: 120,
  //           margin: EdgeInsets.only(right: 10),
  //           child: DropdownButton<String>(
  //             hint: Text('Section'),
  //             value: status,
  //             isExpanded: true,
  //             // icon: const Icon(Icons.arrow_circle_down),
  //             iconSize: 30,
  //             elevation: 16,
  //             // underline: Container(),
  //             onChanged: (String? newValue) {
  //               setState(() {
  //                 status = newValue;
  //               });
  //             },
  //             items: statusList.map(
  //                   (String value) {
  //                 return DropdownMenuItem<String>(
  //                   value: value,
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(4.0),
  //                     child: Text(value),
  //                   ),
  //                 );
  //               },
  //             ).toList(),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget showDate() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Date',
              style:
              Styling.setTextStyle(size: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        InkWell(
          child: Container(
            width: 140,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: Colors.amber[100],
            child: Text(
              ConvertDate.formatDate(dateTime, format: 'dd-MM-yyyy') ?? '',
              textAlign: TextAlign.center,
              style:
              Styling.setTextStyle(size: 16, fontWeight: FontWeight.w600),
            ),
          ),
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: dateTime,
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            ).then((value) {
              if (value != null) {
                setState(() {
                  dateTime = value;
                  // date = DateFormat('yyyy-MM-dd').format(value);
                });
              }
            });
          },
        ),
      ],
    );
  }

  void _submitNewHorse() async {
    if (_formKey.currentState!.validate()) {
      // if (status != null) {
        // DateTime now = DateTime.now();
        String fullName = _nameController.text.trim();
        String status = _statusController.text.trim();
        Timestamp date = Timestamp.fromDate(dateTime);

        FocusScope.of(context).requestFocus(new FocusNode());

        if (widget.horseId != null) {
          if (status != initialStatus ||
              fullName != initialName ||
              dateTime != initialDateTime) {
            await newHorseService.updateNewHorse(
              id: widget.horseId,
              fullName: fullName,
              status: status,
              date: date,
              // email: AppGlobals.email,
            );
            _updateInitials(fullName, status, dateTime);
            snackBar(context, 'cheval mis à jour avec succès');
          } else {
            snackBar(context, 'Les données sont déjà mises à jour!');
          }
        } else {
          await newHorseService.addNewHorse(
            fullName: fullName,
            status: status,
            date: date,
            // email: AppGlobals.email,
            // userId: AppGlobals.userId,
          );
          _emptyFields();
          snackBar(context, 'Cheval ajouté avec succès');
        }
      // } else {
      //   snackBar(context, 'Veuillez sélectionner le statut');
      // }
    }
  }

  void _emptyFields() {
    _statusController.clear();
    _nameController.clear();
    dateTime = DateTime.now();
    setState(() {});
  }

  void _updateInitials(String? name, nStatus, DateTime? date) {
    initialName = name;
    initialStatus = nStatus;
    initialDateTime = date;
  }
}
