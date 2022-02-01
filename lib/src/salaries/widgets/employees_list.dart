import 'package:flutter/material.dart';
import 'package:salary_app/src/salaries/controllers/salary_calculator_controller.dart';
import 'package:salary_app/src/salaries/models/worker.dart';
import 'package:get/get.dart';

class EmployeesList extends StatelessWidget {
  final List<Employee> employees;
  final Function(Employee) onPress;

  const EmployeesList({
    Key? key,
    required this.onPress,
    required this.employees,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: context.width * 0.3,
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const Text(
              "Darbinieki",
              style: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: [
                ...employees
                    .map(
                      (e) => ListTile(
                        title: Text(e.name),
                        subtitle: Text("id: ${e.id}"),
                        dense: true,
                        onTap: () => onPress(e),
                      ),
                    )
                    .toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
