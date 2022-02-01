import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:salary_app/src/salaries/controllers/update_salaries_controller.dart';
import 'package:salary_app/src/salaries/models/plank.dart';
import 'package:salary_app/src/salaries/widgets/plank_list.dart';
import 'package:salary_app/src/salaries/widgets/update_plank_list.dart';

class UpdateAddPlankForm extends StatelessWidget {
  const UpdateAddPlankForm({
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
          key: UpdateSalariesController.to.plankFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Pievienot deli",
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: "height",
                      decoration: const InputDecoration(
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
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: FormBuilderTextField(
                      name: "width",
                      decoration: const InputDecoration(
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
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: FormBuilderTextField(
                      name: "length",
                      decoration: const InputDecoration(
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
              const SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: "amount",
                      decoration: const InputDecoration(
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
                      title: const Text("Zkv"),
                      initialValue: false,
                    ),
                  ),
                  Expanded(
                    child: FormBuilderCheckbox(
                      name: "kalts",
                      title: const Text("Kalts"),
                      initialValue: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              FormBuilderCheckbox(
                name: "d9",
                title: const Text("D9"),
                initialValue: false,
              ),
              const SizedBox(height: 8.0),
              FormBuilderDropdown(
                name: 'tara_type',
                initialValue: TaraType.taraHigh,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Cehs",
                ),
                items: [
                  const DropdownMenuItem(
                    value: TaraType.taraHigh,
                    child: Text("Zala iela 6"),
                  ),
                  const DropdownMenuItem(
                    value: TaraType.taraLow,
                    child: Text("Kraulu iela 4"),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: onPressed,
                child: const Text("Pievienot"),
              ),
              GetX<UpdateSalariesController>(
                builder: (controller) => UpdatePlankList(
                  planks: UpdateSalariesController.to.tara.value,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Obx(
                () => Text(
                  "Kopeja kubatura: " +
                      UpdateSalariesController.to.totalVolume
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
