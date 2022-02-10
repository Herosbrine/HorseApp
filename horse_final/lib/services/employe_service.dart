import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeService {
  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  // Add New Employee
  Future<void> addEmployee(
      {Timestamp? date,
      String? fullName,
      String? email,
      String? status}) async {
    Employee employee = Employee(
      fullName: fullName,
      status: status,
      date: date,
    );

    await firestoreInstance.collection('Employees').add(employee.toJson());
  }

  ////Update employee
  Future updateEmployee(
      {String? id,
      Timestamp? date,
      String? fullName,
      String? email,
      String? status}) async {
    Employee employee = Employee(
      fullName: fullName,
      status: status,
      date: date,
    );
    firestoreInstance.collection('Employees').doc('$id').set(
          employee.toJson(), // SetOptions(merge: true),
        );
  }

  //Delete employee
  Future deleteEmployee(String? id) async {
    try {
      await firestoreInstance.collection('Employees').doc('$id').delete();
    } catch (e) {
      print(e.toString());
    }
  }
}

class Employee {
  Timestamp? date;
  String? fullName;
  String? status;

  Employee({
    this.date,
    this.fullName,
    this.status,
  });

  Employee.fromJson(Map<String, dynamic> json) {
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
