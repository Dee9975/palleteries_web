import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:salary_app/src/brigades/controllers/brigades_controller.dart';

class BrigadesList extends StatelessWidget {
  const BrigadesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrigadesController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.dialog(AlertDialog(
                title: Text("Pievienot brigadi"),
                content: FormBuilder(
                  key: controller.key,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FormBuilderTextField(
                        name: "name",
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                          labelText: "Nosaukums",
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.addBrigade();
                        },
                        child: Text("Pievienot"),
                      ),
                    ],
                  ),
                ),
              ));
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Obx(
          () => controller.loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Brigades",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    ...controller.brigades.map(
                      (e) => Card(
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(e.name),
                              IconButton(
                                onPressed: () {
                                  controller.removeBrigade(e.id);
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
