import 'package:chg_racing/constants/app_strings.dart';
import 'package:chg_racing/pages/home/horses/add_horse.dart';
import 'package:chg_racing/services/convert_date.dart';
import 'package:chg_racing/services/employe_service.dart';
import 'package:chg_racing/services/new_horse_service.dart';
import 'package:chg_racing/utilities/custom_appbar.dart';
import 'package:chg_racing/utilities/custom_searchbar.dart';
import 'package:chg_racing/utilities/styling.dart';
import 'package:chg_racing/utilities/actions_row.dart';
import 'package:chg_racing/utilities/cell_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lazy_data_table/lazy_data_table.dart';

class NewHorsesPage extends StatefulWidget {
  const NewHorsesPage({Key? key}) : super(key: key);

  @override
  _NewHorsesPageState createState() => _NewHorsesPageState();
}

class _NewHorsesPageState extends State<NewHorsesPage> {
  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  TextEditingController _searchController = TextEditingController();
 // EmployeeService horseService = EmployeeService();

  List<QueryDocumentSnapshot> _searchResults = [];
  List<QueryDocumentSnapshot> _allNewHorses = [];

  // List employees = [];
  List searchResults = [];

  List _headers = [
    'Nom Complet',
    'Statut',
    'Date',
    'Actions',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Chevaux',
        icon: Icons.add_box_outlined,
        actionTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewHorse()),
          );
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomSearchBar(
                controller: _searchController,
                onChangeFunction: onSearchTextChanged,
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestoreInstance
                    .collection("NewHorses")
                    .orderBy('date', descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');

                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      // _addAllEmployees(snapshot.data!.docs);
                      _allNewHorses = List.from(snapshot.data!.docs);

                      return _searchResults.length > 0 ||
                          _searchController.text.isNotEmpty
                          ? _showNewHorses(_searchResults)
                            :_showNewHorses(_allNewHorses);
                    }
                    return Center(
                      child: Text(
                        AppStrings.somethingWrong,
                        style: Styling.setTextStyle(
                          size: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  } else
                    return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showNewHorses(List<QueryDocumentSnapshot<Object?>> docs) {
    List<NewHorse> newHorseList = docs
        .map((doc) => NewHorse.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    List<String> _ids = docs.map((doc) => doc.id).toList();

    return Container(
      child: newHorseList.isNotEmpty
          ? Container(
        child: LazyDataTable(
          rows: newHorseList.length,
          columns: 4,
          tableTheme: LazyDataTableTheme(
            columnHeaderColor: Colors.orangeAccent,
            cornerColor: Colors.orangeAccent,
            rowHeaderColor: Colors.orange,
            alternateRowHeaderColor: Colors.orangeAccent,
          ),
          tableDimensions: LazyDataTableDimensions(
            cellWidth: 200,
            cellHeight: 70,
            topHeaderHeight: 60,
            leftHeaderWidth: 40,
          ),
          topHeaderBuilder: (i) => CellText(
            text: _headers[i],
            isBold: true,
            size: 18,
          ),
          dataCellBuilder: (i, j) {
            switch (j) {
              case 0:
                return CellText(text: newHorseList[i].fullName);
              case 1:
                return CellText(text: newHorseList[i].status);
              case 2:
                DateTime? _dateTime;
                if (newHorseList[i].date != null)
                  _dateTime = newHorseList[i].date!.toDate();
                String? _date = ConvertDate.formatDate(_dateTime);
                return CellText(text: _date);
              case 3:
                return ActionsRow(id: _ids[i], newHorse: newHorseList[i]);
              default:
                return Container();
            }
          },
          topLeftCornerWidget: CellText(
            text: '#',
            isBold: true,
            size: 18,
          ),
          leftHeaderBuilder: (i) => CellText(text: '${i + 1}'),
        ),
      )

      // ListView.builder(
      //   itemCount: docsList.length,
      //   shrinkWrap: true,
      //   physics: ScrollPhysics(),
      //   itemBuilder: (BuildContext context, int index) {
      //     String id = docsList[index].id;
      //     Map data = docsList[index].data() as Map<String, dynamic>;
      //     return _showEmployeeRow(id, data);
      //   },
      // ),

          : Center(
        child: Text(
          'Aucun chevaux trouvé',
          textAlign: TextAlign.center,
          style: Styling.setTextStyle(
            size: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  onSearchTextChanged(String text) {
    _searchResults.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _allNewHorses.forEach((horse) {
      NewHorse data = NewHorse.fromJson(horse.data() as Map<String, dynamic>);

      if (data.fullName != null) {
        String msgText = data.fullName!.toLowerCase();
        String query = text.trim().toLowerCase();

        if (msgText.startsWith(query) || msgText.contains(query))
          _searchResults.add(horse);
      }
    });

    setState(() {});
  }
}
