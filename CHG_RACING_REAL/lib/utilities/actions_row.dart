import 'package:chg_racing/pages/home/employees/add_employee.dart';
import 'package:chg_racing/pages/home/horses/add_horse.dart';
import 'package:chg_racing/pages/home/weighing/add_weighing.dart';
import 'package:chg_racing/services/employe_service.dart';
import 'package:chg_racing/services/horse_service.dart';
import 'package:chg_racing/services/new_horse_service.dart';
import 'package:chg_racing/utilities/custom_dialog.dart';
import 'package:chg_racing/utilities/custom_icon_button.dart';
import 'package:flutter/material.dart';

class ActionsRow extends StatelessWidget {
  ActionsRow({Key? key, this.employee, this.horse, this.id, this.newHorse}) : super(key: key);
  final String? id;
  final Employee? employee;
  final Horse? horse;
  final NewHorse? newHorse;

  final _horseService = HorseService();
  final _employeeService = EmployeeService();
  final _newHorseService = NewHorseService();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomIcon(
          icon: Icons.delete_outline,
          color: Colors.red,
          onTap: () async {
            String? deleteText = 'Are you sure you want to delete?';
            if (employee != null) {
              deleteText =
                  'Are you sure you want to delete ${employee!.fullName ?? ''}?';
            } else if (horse != null) {
              deleteText =
                  'Are you sure you want to delete ${horse!.lastName ?? ''}?';
            } else if(newHorse!=null){
              'Are you sure you want to delete ${newHorse!.fullName ?? ''}?';
            }
            showDialog(
              context: context,
              builder: (BuildContext context) => CustomDialog(
                title: 'Delete ${employee != null ? 'Employee' :horse!=null? 'Weigh':'Horse'}',
                desc: deleteText,
                button1: 'Oui',
                button2: 'Non',
                onTap2: () => Navigator.pop(context),
                onTap1: () async {
                  if (id != null) {
                    Navigator.pop(context);

                    if (employee != null)
                      await _employeeService.deleteEmployee(id!);
                    else if (horse != null)
                      await _horseService.deleteHorse(id!);
                    else if(newHorse!=null){
                      await _newHorseService.deleteNewHorse(id!);
                  }
                  }
                },
              ),
            );
          },
        ),
        CustomIcon(
          icon: Icons.edit,
          // color: Colors.greenAccent,
          onTap: () {
            DateTime? _date;
            if (employee != null) {
              if (employee!.date != null) _date = employee!.date!.toDate();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEmployee(
                      empId: id,
                      dateTime: _date,
                      name: employee!.fullName,
                      status: employee!.status,
                    ),
                  ));
            } else if (horse != null) {
              if (horse!.date != null) _date = horse!.date!.toDate();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddHorse(
                      horseId: id,
                      dateTime: _date,
                      name: horse!.lastName,
                      performance: horse!.performance,
                      distance: horse!.distance,
                      weightBefore: horse!.weightBefore,
                      weightAfter: horse!.weightAfter,
                    ),
                  ));
            } else if (newHorse != null) {
              if (newHorse!.date != null) _date = newHorse!.date!.toDate();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNewHorse(
                      horseId: id,
                      dateTime: _date,
                      name: newHorse!.fullName,
                      status: newHorse!.status,
                    ),
                  ));
            }
          },
        ),
      ],
    );
  }
}
