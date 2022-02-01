import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:salary_app/src/employees/controllers/employee_editor_controller.dart';

class EmployeeEditor extends StatelessWidget {
  const EmployeeEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmployeeEditorController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: Text("Pievienot darbinieku"),
                  content: FormBuilder(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FormBuilderTextField(
                          name: 'name',
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Vards",
                          ),
                          onChanged: (val) => controller.name = val ?? "",
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            controller.addEmployee();
                          },
                          child: Text("Pievienot"),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Darbinieki"),
              SizedBox(height: 16.0),
              ...controller.employees.map(
                (e) => Card(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(e.name),
                        IconButton(
                          onPressed: () {
                            controller.removeEmployee(e);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
