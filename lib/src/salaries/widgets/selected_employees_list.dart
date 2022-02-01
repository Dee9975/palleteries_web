import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:salary_app/src/salaries/controllers/salary_calculator_controller.dart';
import 'package:salary_app/src/salaries/models/team_member.dart';
import 'package:get/get.dart';
import 'package:salary_app/src/salaries/models/worker.dart';
import 'package:string_similarity/string_similarity.dart';

class SelectedEmployeesList extends StatelessWidget {
  const SelectedEmployeesList({
    Key? key,
    required this.employees,
    required this.onDelete,
    required this.onForklift,
    required this.onPress,
  }) : super(key: key);

  final List<TeamMember> employees;
  final Function(TeamMember) onDelete;
  final Function(TeamMember, bool) onForklift;
  final Function(TeamMember) onPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: context.width * 0.3,
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Komanda",
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: FormBuilderDateTimePicker(
                      name: 'date',
                      onChanged: (DateTime? t) => SalaryCalculatorController
                          .to.selectedDateTime = t ?? DateTime.now(),
                      inputType: InputType.date,
                      initialValue:
                          SalaryCalculatorController.to.selectedDateTime,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownSearch<Employee>(
                mode: Mode.MENU,
                showSearchBox: true,
                showClearButton: true,
                itemAsString: (e) {
                  return e?.name ?? "";
                },
                onFind: (String? filter) async {
                  final list = <Employee>[];
                  for (var element in SalaryCalculatorController.to.employees) {
                    double similarity = StringSimilarity.compareTwoStrings(
                        element.name, filter);
                    if (similarity > 0) {
                      list.add(element);
                    }
                  }

                  return list;
                },
                onChanged: (e) {
                  SalaryCalculatorController.to.addEmployee(e!);
                },
                // dropdownBuilder: (context, m) {
                //   return ListTile(
                //     title: Text(m?.name ?? ""),
                //   );
                // },
                items: SalaryCalculatorController.to.employees,
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            ListView(
              shrinkWrap: true,
              children: employees
                  .map(
                    (e) => ListTile(
                      onTap: () => onPress(e),
                      tileColor:
                          e.forklift ? const Color(0xfffed931) : Colors.white,
                      title: Text(e.name),
                      subtitle: Text(
                          "id: ${e.id} | stundas: ${e.hours} | kalts: ${e.kalts ? "Ja" : "Ne"} | ${e.salary}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => onForklift(e, !e.forklift),
                            icon: const Icon(Icons.agriculture),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => onDelete(e),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: FormBuilder(
                child: FormBuilderDropdown(
                  name: "brigade",
                  initialValue: SalaryCalculatorController.to.selectedBrigade,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Brigade",
                  ),
                  items: [
                    ...SalaryCalculatorController.to.brigades.map(
                      (e) => DropdownMenuItem(
                        child: Text(e.name),
                        value: e,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
