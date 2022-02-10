import 'package:chg_racing/constants/globals.dart';
import 'package:chg_racing/services/authentication.dart';
import 'package:chg_racing/services/convert_date.dart';
import 'package:chg_racing/services/horse_service.dart';
import 'package:chg_racing/utilities/custom_appbar.dart';
import 'package:chg_racing/utilities/custom_button.dart';
import 'package:chg_racing/utilities/custom_textfield.dart';
import 'package:chg_racing/utilities/styling.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddHorse extends StatefulWidget {
  const AddHorse({
    Key? key,
    this.horseId,
    this.dateTime,
    this.name,
    this.performance,
    this.weightBefore,
    this.weightAfter, this.distance,
  }) : super(key: key);
  final String? horseId, name, performance;
  final double? distance, weightBefore, weightAfter;
  final DateTime? dateTime;
  @override
  _AddHorseState createState() => _AddHorseState();
}

class _AddHorseState extends State<AddHorse> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _performaceController = TextEditingController();
  TextEditingController _distanceController = TextEditingController();
  TextEditingController _weightBFController = TextEditingController();
  TextEditingController _weightAfController = TextEditingController();
  HorseService horseService = HorseService();
  DateTime dateTime = DateTime.now();
  DateTime? initialDateTime;
  String? initialName, initialperformance;
  double? initialDistance, initialWeightBefore, initialWeightAfter;

  @override
  void initState() {
    print(widget.distance);
    super.initState();
    _updateInitials(widget.name, widget.performance, widget.distance, widget.weightBefore,
        widget.weightAfter, widget.dateTime);

    _nameController.text = widget.name ?? '';
    _performaceController.text = widget.performance ?? '';
    if(widget.distance!=null) _distanceController.text = widget.distance.toString();
    if (widget.dateTime != null) dateTime = widget.dateTime!;
    if (widget.weightBefore != null && widget.weightAfter != null) {
      _weightBFController.text = widget.weightBefore.toString();
      _weightAfController.text = widget.weightAfter.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title:
            widget.horseId != null ? 'Modifier le cheval' : 'Ajouter un cheval',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _showHorseFormFields(),
                SizedBox(height: AppGlobals.screenHeight * 0.06),
                CustomFlatButton(
                  title: 'Sauvegarder le cheval',
                  onTap: () {
                    _submitHorse();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _showHorseFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            'Nom',
            style: Styling.setTextStyle(size: 18, fontWeight: FontWeight.w600),
          ),
        ),
        CustomTextField(
          hintText: 'Nom',
          controller: _nameController,
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value.isEmpty) {
              return 'Veuillez entrer le nom du cheval';
            }
            return null;
          },
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Performance',
                  style: Styling.setTextStyle(
                      size: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Flexible(
                child: CustomTextField(
                  hintText: 'Performance',
                  controller: _performaceController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Veuillez saisir les performances';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Distance (mètres)',
                  style: Styling.setTextStyle(
                      size: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Flexible(
                child: CustomTextField(
                  hintText: '2000',
                  controller: _distanceController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Veuillez entrer le distance';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Poids avant (kg)',
                  style: Styling.setTextStyle(
                      size: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Flexible(
                child: CustomTextField(
                  hintText: '600',
                  controller: _weightBFController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Veuillez entrer le poids';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Poids après (kg)',
                  style: Styling.setTextStyle(
                      size: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),  
            Flexible(
              child: CustomTextField(
                hintText: '580',
                controller: _weightAfController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Veuillez entrer le poids';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        showDate(),
      ],
    );
  }

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

  void _submitHorse() async {
    if (_formKey.currentState!.validate()) {
      // if (status != null) {
      // DateTime now = DateTime.now();
      Timestamp date = Timestamp.fromDate(dateTime);
      String name = _nameController.text.trim();
      String performance = _performaceController.text.trim();
      double distance = double.parse(_distanceController.text.trim());
      double weightBefore = double.parse(_weightBFController.text.trim());
      double weightAfter = double.parse(_weightAfController.text.trim());

      FocusScope.of(context).requestFocus(new FocusNode());

      if (widget.horseId != null) {
        if (performance != initialperformance ||
            name != initialName ||
            distance != initialDistance ||
            weightBefore != initialWeightBefore ||
            weightAfter != initialWeightAfter ||
            dateTime != initialDateTime) {
          await horseService.updateHorse(
            date: date,
            id: widget.horseId,
            lastName: name,
            performance: performance,
            distance: distance,
            weightBefore: weightBefore,
            weightAfter: weightAfter,
          );
          _updateInitials(
              name, performance, distance, weightBefore, weightAfter, dateTime);
          snackBar(context, 'Cheval mis à jour avec succès');
        } else {
          snackBar(context, 'Les données sont déjà mises à jour!');
        }
      } else {
        await horseService.addHorse(
          date: date,
          lastName: name,
          performance: performance,
          distance: distance,
          weightBefore: weightBefore,
          weightAfter: weightAfter,
        );
        _emptyFields();
        snackBar(context, 'Cheval ajouté avec succès');
      }
      // } else {
      //   snackBar(context, 'Please select status');
      // }
    }
  }

  void _emptyFields() {
    _nameController.clear();
    _performaceController.clear();
    _distanceController.clear();
    _weightBFController.clear();
    _weightAfController.clear();
    dateTime = DateTime.now();

    setState(() {});
  }

  void _updateInitials(
      String? name, String? perf, double? dis, double? wbf, double? waf, DateTime? date) {
    initialName = name;
    initialperformance = perf;
    initialDistance = dis;
    initialWeightBefore = wbf;
    initialWeightAfter = waf;
    initialDateTime = date;
  }
}
