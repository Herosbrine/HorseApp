import 'package:chg_racing/pages/home/employees/add_employee.dart';
import 'package:chg_racing/pages/home/horses/add_horse.dart';
import 'package:chg_racing/services/employe_service.dart';
import 'package:chg_racing/services/horse_service.dart';
import 'package:chg_racing/utilities/custom_dialog.dart';
import 'package:chg_racing/utilities/custom_icon_button.dart';
import 'package:flutter/material.dart';

class ActionsRow extends StatelessWidget {
  ActionsRow({Key? key, this.employee, this.horse, this.id}) : super(key: key);
  final String? id;
  final Employee? employee;
  final Horse? horse;

  final _horseService = HorseService();
  final _employeeService = EmployeeService();

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
            }
            showDialog(
              context: context,
              builder: (BuildContext context) => CustomDialog(
                title: 'Delete ${employee != null ? 'Employee' : 'Horse'}',
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
            }
          },
        ),
      ],
    );
  }
}
