import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salary_app/src/salaries/controllers/salary_calculator_controller.dart';
import 'package:salary_app/src/salaries/controllers/update_salaries_controller.dart';

class UpdateFinishedMembersList extends StatelessWidget {
  const UpdateFinishedMembersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8.0),
        width: context.width * 0.3,
        child: Obx(
          () => ListView(
            shrinkWrap: true,
            children: [
              ...UpdateSalariesController.to.finishedMembers
                  .map(
                    (element) => Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: EdgeInsets.only(bottom: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Color(0xfffafafa),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Vards"),
                              Text(
                                element.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Alga"),
                              Text(
                                element.salary.toStringAsFixed(2) + "\$",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              if (UpdateSalariesController.to.splitMembers.isNotEmpty)
                Text(
                  "Sadalitie darbinieki",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              SizedBox(
                height: 8.0,
              ),
              ...UpdateSalariesController.to.splitMembers
                  .map(
                    (element) => Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: EdgeInsets.only(bottom: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Color(0xfffafafa),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Vards"),
                              Text(
                                element.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Alga"),
                              Text(
                                element.salary.toStringAsFixed(2) + "\$",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              if (UpdateSalariesController.to.finishedMembers.isNotEmpty)
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        UpdateSalariesController.to.exportToExcel();
                      },
                      child: Text("Export to excel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        UpdateSalariesController.to.updateTeam();
                      },
                      child: Text("Save"),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
