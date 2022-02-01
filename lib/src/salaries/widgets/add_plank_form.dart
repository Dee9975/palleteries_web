import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:salary_app/src/salaries/controllers/salary_calculator_controller.dart';
import 'package:salary_app/src/salaries/models/plank.dart';
import 'package:salary_app/src/salaries/widgets/plank_list.dart';

class AddPlankForm extends StatelessWidget {
  const AddPlankForm({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: context.width * 0.3,
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
        child: FormBuilder(
          key: SalaryCalculatorController.to.plankFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pievienot deli",
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: "height",
                      decoration: InputDecoration(
                        labelText: "Austums",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.numeric(context),
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: FormBuilderTextField(
                      name: "width",
                      decoration: InputDecoration(
                        labelText: "Platums",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.numeric(context),
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: FormBuilderTextField(
                      name: "length",
                      decoration: InputDecoration(
                        labelText: "Garums",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.numeric(context),
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: "amount",
                      decoration: InputDecoration(
                        labelText: "Daudzums",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.numeric(context),
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                  ),
                  Expanded(
                    child: FormBuilderCheckbox(
                      name: "zkv",
                      title: Text("Zkv"),
                      initialValue: false,
                    ),
                  ),
                  Expanded(
                    child: FormBuilderCheckbox(
                      name: "kalts",
                      title: Text("Kalts"),
                      initialValue: false,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              FormBuilderDropdown(
                name: 'tara_type',
                initialValue: TaraType.taraHigh,
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
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: onPressed,
                child: Text("Pievienot"),
              ),
              GetX<SalaryCalculatorController>(
                builder: (controller) => PlankList(
                  planks: SalaryCalculatorController.to.tara.value,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Obx(
                () => Text(
                  "Kopeja kubatura: " +
                      SalaryCalculatorController.to.totalVolume
                          .toStringAsFixed(3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
