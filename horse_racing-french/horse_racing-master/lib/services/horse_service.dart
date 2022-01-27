import 'package:cloud_firestore/cloud_firestore.dart';

class HorseService {
  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  // Add New Horse
  Future<void> addHorse(
      {Timestamp? date,
      String? lastName,
      String? performance,
      double? weightBefore,
      double? weightAfter}) async {
    Horse horse = Horse(
      date: date,
      lastName: lastName,
      performance: performance,
      weightBefore: weightBefore,
      weightAfter: weightAfter,
    );

    await firestoreInstance.collection('Horses').add(horse.toJson());
  }

  ////Update Horse
  Future updateHorse(
      {String? id,
      Timestamp? date,
      String? lastName,
      String? performance,
      double? weightBefore,
      double? weightAfter}) async {
    Horse horse = Horse(
      date: date,
      lastName: lastName,
      performance: performance,
      weightBefore: weightBefore,
      weightAfter: weightAfter,
    );
    firestoreInstance.collection('Horses').doc('$id').set(
          horse.toJson(), // SetOptions(merge: true),
        );
  }

  //Delete Horse
  Future deleteHorse(String? id) async {
    try {
      await firestoreInstance.collection('Horses').doc('$id').delete();
    } catch (e) {
      print(e.toString());
    }
  }
}

class Horse {
  Timestamp? date;
  String? lastName;
  String? performance;
  double? weightAfter;
  double? weightBefore;

  Horse(
      {this.date,
      this.lastName,
      this.performance,
      this.weightAfter,
      this.weightBefore});

  Horse.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    lastName = json['lastName'];
    performance = json['performance'];
    weightBefore = (double.tryParse("${json['weightBefore']}")) ?? 0.0;
    weightAfter = (double.tryParse("${json['weightAfter']}")) ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['lastName'] = this.lastName;
    data['performance'] = this.performance;
    data['weightAfter'] = (double.tryParse("${this.weightAfter}")) ?? 0.0;
    data['weightBefore'] = (double.tryParse("${this.weightBefore}")) ?? 0.0;
    return data;
  }
}
