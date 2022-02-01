import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:salary_app/src/salaries/controllers/salary_calculator_controller.dart';
import 'package:salary_app/src/salaries/models/plank.dart';

class PlankList extends StatelessWidget {
  const PlankList({
    Key? key,
    required this.planks,
  }) : super(key: key);

  final List<Plank> planks;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...planks.map(
              (e) => GestureDetector(
                onTap: () => Get.dialog(
                  AlertDialog(
                    title: Text("Mainit izmerus"),
                    content: FormBuilder(
                      key: SalaryCalculatorController.to.plankEditFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: FormBuilderTextField(
                                  name: "height",
                                  initialValue: e.height.toString(),
                                  decoration: InputDecoration(
                                    labelText: "Augstums",
                                    hintText: "0.0",
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.numeric(context),
                                    FormBuilderValidators.required(context),
                                  ]),
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Expanded(
                                child: FormBuilderTextField(
                                  name: "width",
                                  initialValue: e.width.toString(),
                                  decoration: InputDecoration(
                                    labelText: "Platums",
                                    hintText: "0.0",
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.numeric(context),
                                    FormBuilderValidators.required(context),
                                  ]),
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Expanded(
                                child: FormBuilderTextField(
                                  name: "length",
                                  initialValue: e.length.toString(),
                                  decoration: InputDecoration(
                                    labelText: "Garums",
                                    hintText: "0.0",
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.numeric(context),
                                    FormBuilderValidators.required(context),
                                  ]),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          FormBuilderTextField(
                            name: "amount",
                            initialValue: e.amount.toString(),
                            decoration: InputDecoration(
                              labelText: "Daudzums",
                              hintText: "0.0",
                              border: OutlineInputBorder(),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.numeric(context),
                              FormBuilderValidators.required(context),
                            ]),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: FormBuilderCheckbox(
                                  name: "zkv",
                                  title: Text("Zkv"),
                                  initialValue: e.zkv,
                                ),
                              ),
                              Expanded(
                                child: FormBuilderCheckbox(
                                  name: "kalts",
                                  title: Text("Kalts"),
                                  initialValue: e.kalts,
                                ),
                              ),
                              Expanded(
                                child: FormBuilderDropdown(
                                  name: 'tara_type',
                                  initialValue: e.type,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Cehs",
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                      value: TaraType.taraHigh,
                                      child: Text("Zala iela 6"),
                                    ),
                                    DropdownMenuItem(
                                      value: TaraType.taraLow,
                                      child: Text("Kraulu iela 4"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: () {
                              SalaryCalculatorController.to.updatePlank(e.id);
                              Get.back();
                            },
                            child: const Text("Apstiprinat"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(),
                              Text(
                                e.type == TaraType.taraHigh
                                    ? "Zala iela 6"
                                    : "Kraulu iela 4",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(text: "Augstums: "),
                                    TextSpan(
                                      text: "${e.height} | ",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const TextSpan(text: "Platums: "),
                                    TextSpan(
                                      text: "${e.width} | ",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const TextSpan(text: "Garums: "),
                                    TextSpan(
                                      text: "${e.length}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                              ),
                              Text("Daudzums: ${e.amount}"),
                              Text(
                                "Tilpums: " + e.volume.toStringAsFixed(3),
                              ),
                              Text("Zkv: ${e.zkv ? "Ja" : "Ne"}"),
                              Text("Kalts: ${e.kalts ? "Ja" : "Ne"}"),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            SalaryCalculatorController.to.removePlank(e);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
