import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salary_app/src/history/screens/team_history.dart';
import 'package:salary_app/src/salaries/controllers/salary_calculator_controller.dart';
import 'package:salary_app/src/salaries/controllers/update_salaries_controller.dart';
import 'package:salary_app/src/salaries/widgets/add_plank_form.dart';
import 'package:salary_app/src/salaries/widgets/employees_list.dart';
import 'package:salary_app/src/salaries/widgets/finished_members_list.dart';
import 'package:salary_app/src/salaries/widgets/plank_list.dart';
import 'package:salary_app/src/salaries/widgets/selected_employees_list.dart';
import 'package:salary_app/src/salaries/widgets/update_add_plank_form.dart';
import 'package:salary_app/src/salaries/widgets/update_finished_members_list.dart';
import 'package:salary_app/src/salaries/widgets/update_selected_employees_list.dart';

class UpdateSalaries extends StatelessWidget {
  const UpdateSalaries({
    Key? key,
    required this.team,
  }) : super(key: key);

  final team;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateSalariesController(team));
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => UpdateSalariesController.to.calculateSalaries(),
            child: const Text(
              "Aprekinat",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => controller.settings == null || controller.brigades.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        UpdateAddPlankForm(
                          onPressed: () =>
                              UpdateSalariesController.to.addPlank(),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // EmployeesList(
                        //   onPress: (e) => SalaryCalculatorController.to.addEmployee(e),
                        //   employees: SalaryCalculatorController.to.employees,
                        // ),
                        GetX<UpdateSalariesController>(
                          builder: (controller) => UpdateSelectedEmployeesList(
                            employees: controller.teamMembers.value,
                            onPress: (e) => controller.updateMember(e),
                            onDelete: (e) => controller.removeEmployee(e),
                            onForklift: (e, val) =>
                                controller.setForklift(e, val),
                          ),
                        ),
                      ],
                    ),
                    const UpdateFinishedMembersList(),
                  ],
                ),
              ),
      ),
    );
  }
}
