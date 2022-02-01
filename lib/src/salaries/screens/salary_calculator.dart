import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salary_app/src/history/screens/team_history.dart';
import 'package:salary_app/src/salaries/controllers/salary_calculator_controller.dart';
import 'package:salary_app/src/salaries/widgets/add_plank_form.dart';
import 'package:salary_app/src/salaries/widgets/employees_list.dart';
import 'package:salary_app/src/salaries/widgets/finished_members_list.dart';
import 'package:salary_app/src/salaries/widgets/plank_list.dart';
import 'package:salary_app/src/salaries/widgets/selected_employees_list.dart';

class SalaryCalculator extends StatelessWidget {
  const SalaryCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SalaryCalculatorController(), permanent: true);
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => SalaryCalculatorController.to.calculateSalaries(),
            child: Text(
              "Aprekinat",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Text(
                "Palleteries",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 38.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text("Algu kalkulators"),
            ),
            ListTile(
              title: Text("Vesture"),
              onTap: () => Get.toNamed("/history"),
            ),
            ListTile(
              title: Text("Iestatijumi"),
              onTap: () => Get.toNamed("/settings"),
            ),
            ListTile(
              title: Text("Brigades"),
              onTap: () => Get.toNamed("/brigades"),
            ),
            ListTile(
              title: Text("Menesa algas"),
              onTap: () => Get.toNamed("/monthly_salaries_filter"),
            ),
          ],
        ),
      ),
      body: Obx(
        () => controller.settings == null || controller.brigades.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        AddPlankForm(
                          onPressed: () =>
                              SalaryCalculatorController.to.addPlank(),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // EmployeesList(
                        //   onPress: (e) => SalaryCalculatorController.to.addEmployee(e),
                        //   employees: SalaryCalculatorController.to.employees,
                        // ),
                        GetX<SalaryCalculatorController>(
                          builder: (controller) => SelectedEmployeesList(
                            employees: controller.teamMembers.value,
                            onPress: (e) => controller.updateMember(e),
                            onDelete: (e) => controller.removeEmployee(e),
                            onForklift: (e, val) =>
                                controller.setForklift(e, val),
                          ),
                        ),
                      ],
                    ),
                    FinishedMembersList(),
                  ],
                ),
              ),
      ),
    );
  }
}
