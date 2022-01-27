import 'package:chg_racing/constants/app_colors.dart';
import 'package:chg_racing/constants/app_strings.dart';
import 'package:chg_racing/pages/home/horses/add_horse.dart';
import 'package:chg_racing/services/convert_date.dart';
import 'package:chg_racing/services/horse_service.dart';
import 'package:chg_racing/utilities/custom_appbar.dart';
import 'package:chg_racing/utilities/custom_dialog.dart';
import 'package:chg_racing/utilities/custom_icon_button.dart';
import 'package:chg_racing/utilities/custom_searchbar.dart';
import 'package:chg_racing/utilities/styling.dart';
import 'package:chg_racing/utilities/actions_row.dart';
import 'package:chg_racing/utilities/cell_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lazy_data_table/lazy_data_table.dart';

class HorsesPage extends StatefulWidget {
  const HorsesPage({Key? key}) : super(key: key);

  @override
  _HorsesPageState createState() => _HorsesPageState();
}

class _HorsesPageState extends State<HorsesPage> {
  HorseService horseService = HorseService();

  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  TextEditingController _searchController = TextEditingController();

  List<QueryDocumentSnapshot> _searchResults = [];
  List<QueryDocumentSnapshot> _allHorses = [];

  List _headers = [
    'Nom',
    'Performance',
    'Poids avant',
    'Poids après',
    'Date',
    'Actions',
  ];

  @override
  void initState() {
    super.initState();
    // getData();
  }

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection('Horses').get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    //for a specific field
    // final allData =
    //     querySnapshot.docs.map((doc) => doc.get('fieldName')).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Chevaux',
        icon: Icons.add_box_outlined,
        actionTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddHorse()),
          );
        },
      ),
      body: Column(
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
                  .collection("Horses")
                  .orderBy('date', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return Center(child: Text('Error: ${snapshot.error}'));

                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    _allHorses = List.from(snapshot.data!.docs);

                    return _searchResults.length > 0 ||
                            _searchController.text.isNotEmpty
                        ? _showHorses(_searchResults)
                        : _showHorses(_allHorses);
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
    );
  }

  Widget _showHorses(List<QueryDocumentSnapshot<Object?>> docs) {
    List<Horse> horseList = docs
        .map((doc) => Horse.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    List<String> _ids = docs.map((doc) => doc.id).toList();

    return Container(
      child: horseList.isNotEmpty
          ? Container(
              child: LazyDataTable(
                rows: horseList.length,
                columns: 6,
                tableTheme: LazyDataTableTheme(
                  columnHeaderColor: Colors.orangeAccent,
                  cornerColor: Colors.orangeAccent,
                  rowHeaderColor: Colors.orange,
                  alternateRowHeaderColor: Colors.orangeAccent,
                ),
                tableDimensions: LazyDataTableDimensions(
                  cellWidth: 180,
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
                      return CellText(text: horseList[i].lastName);
                    case 1:
                      return CellText(text: horseList[i].performance);
                    case 2:
                      return CellText(
                          text: (horseList[i].weightBefore ?? 0)
                              .toStringAsFixed(1));
                    case 3:
                      return CellText(
                          text: (horseList[i].weightAfter ?? 0)
                              .toStringAsFixed(1));
                    case 4:
                      DateTime? _dateTime;
                      if (horseList[i].date != null)
                        _dateTime = horseList[i].date!.toDate();
                      String? _date = ConvertDate.formatDate(_dateTime);
                      return CellText(text: _date);
                    case 5:
                      return ActionsRow(id: _ids[i], horse: horseList[i]);
                    default:
                      return Container();
                  }
                },
                topLeftCornerWidget:
                    CellText(text: '#', isBold: true, size: 18),
                leftHeaderBuilder: (i) => CellText(text: '${i + 1}'),
              ),
            )

          // ListView.builder(
          //     itemCount: docsList.length,
          //     shrinkWrap: true,
          //     physics: ScrollPhysics(),
          //     itemBuilder: (BuildContext context, int index) {
          //       Map data = docsList[index].data() as Map<String, dynamic>;
          //       return _showEmployeeRow(data);
          //     },
          //   )
          : Center(
              child: Text(
                'Aucun cheval trouvé',
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

    _allHorses.forEach((horse) {
      Horse data = Horse.fromJson(horse.data() as Map<String, dynamic>);

      if (data.lastName != null) {
        String msgText = data.lastName!.toLowerCase();
        String query = text.trim().toLowerCase();

        if (msgText.startsWith(query) || msgText.contains(query))
          _searchResults.add(horse);
      }
    });

    setState(() {});
  }
}
