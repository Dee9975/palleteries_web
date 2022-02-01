import 'package:flutter/material.dart';
import 'package:salary_app/src/monthly_salaries/controllers/monthly_salaries_controller.dart';
import 'package:salary_app/src/salaries/models/team_member.dart';

class MonthlySalariesTable extends StatelessWidget {
  const MonthlySalariesTable({
    Key? key,
    required this.members,
  }) : super(key: key);

  final List<TeamMember> members;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DataTable(
              columns: [
                DataColumn(label: Text("Vards")),
                DataColumn(label: Text("Alga")),
              ],
              rows: members
                  .map(
                    (e) => DataRow(
                      cells: [
                        DataCell(
                          SelectableText(e.name),
                        ),
                        DataCell(
                          SelectableText(
                            e.salary.toStringAsFixed(2),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
            ElevatedButton(
              onPressed: () => MonthlySalariesController.to.exportToExcel(),
              child: Text("Export"),
            ),
          ],
        ),
      ),
    );
  }
}
