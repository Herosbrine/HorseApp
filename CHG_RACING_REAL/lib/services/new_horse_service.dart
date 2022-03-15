import 'package:chg_racing/services/employe_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewHorseService {
  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  // Add New NewHorse
  Future<void> addNewHorse(
      {Timestamp? date,
        String? fullName,
        String? email,
        String? status}) async {
    NewHorse newHorse = NewHorse(
      fullName: fullName,
      status: status,
      date: date,
    );

    await firestoreInstance.collection('NewHorses').add(newHorse.toJson());
  }

  ////Update NewHorse
  Future updateNewHorse(
      {String? id,
        Timestamp? date,
        String? fullName,
        String? email,
        String? status}) async {
    NewHorse newHorse = NewHorse(
      fullName: fullName,
      status: status,
      date: date,
    );
   await firestoreInstance.collection('NewHorses').doc('$id').set(
      newHorse.toJson(), // SetOptions(merge: true),
    );
  }

  //Delete NewHorse
  Future deleteNewHorse(String? id) async {
    try {
      await firestoreInstance.collection('NewHorses').doc('$id').delete();
    } catch (e) {
      print(e.toString());
    }
  }
}

class NewHorse {
  Timestamp? date;
  String? fullName;
  String? status;

  NewHorse({
    this.date,
    this.fullName,
    this.status,
  });

  NewHorse.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    fullName = json['fullName'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['fullName'] = this.fullName;
    data['status'] = this.status;

    return data;
  }
}
