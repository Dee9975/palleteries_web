import 'dart:html';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salary_app/src/brigades/models/brigade.dart';
import 'package:salary_app/src/history/controllers/TeamHistoryController.dart';
import 'package:salary_app/src/history/controllers/plank_history_controller.dart';
import 'package:salary_app/src/history/screens/filter_history.dart';
import 'package:salary_app/src/salaries/controllers/salary_calculator_controller.dart';
import 'package:salary_app/src/salaries/controllers/update_salaries_controller.dart';
import 'package:salary_app/src/salaries/models/plank.dart';
import 'package:salary_app/src/salaries/models/team_member.dart';
import 'package:salary_app/src/salaries/models/worker.dart';
import 'package:salary_app/src/salaries/screens/salary_calculator.dart';
import 'package:salary_app/src/salaries/screens/update_salaries.dart';
import 'package:salary_app/src/services/firestore_service.dart';
import 'package:supercharged/supercharged.dart';

class TeamHistory extends StatelessWidget {
  const TeamHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<TeamHistoryController>(
      init: TeamHistoryController(),
      builder: (TeamHistoryController controller) => Scaffold(
        appBar: AppBar(
          title: Text("History"),
          actions: [
            IconButton(
              onPressed: () => controller.showFilter = !controller.showFilter,
              icon: Icon(Icons.filter_alt),
            ),
          ],
        ),
        body: controller.loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    children: [
                      if (controller.filteredTeams.isEmpty)
                        Expanded(
                          child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.teams.length,
                            itemBuilder: (context, i) {
                              Team el = controller.teams[i];
                              double totalVolume = 0.0;
                              for (var value in el.planks) {
                                totalVolume += value.volume;
                              }
                              return GestureDetector(
                                onTap: () {
                                  Get.dialog(
                                    AlertDialog(
                                      title: Text(
                                        DateFormat("dd/M/yyyy")
                                            .format(el.createDate),
                                      ),
                                      scrollable: true,
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 16.0,
                                          ),
                                          Text(
                                            el.brigade.name,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TeamTable(
                                            team: el,
                                          ),
                                          SizedBox(
                                            height: 16.0,
                                          ),
                                          Text(
                                            "Tara",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SelectableText(
                                            "Kopeja kubatura: " +
                                                totalVolume.toStringAsFixed(3),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.0,
                                          ),
                                          PlankTable(planks: el.planks),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  child: Container(
                                    width: context.width,
                                    padding: EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          DateFormat("dd/M/yyyy")
                                              .format(el.createDate),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 16.0),
                                        Text(
                                          el.brigade.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 16.0,
                                        ),
                                        IconButton(
                                          onPressed: () => Get.to(
                                            () => UpdateSalaries(team: el),
                                          ),
                                          icon: Icon(Icons.edit),
                                        ),
                                        SizedBox(width: 8.0),
                                        IconButton(
                                          onPressed: () => TeamHistoryController
                                              .to
                                              .removeTeam(el),
                                          icon: Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      if (controller.filteredTeams.isNotEmpty)
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: controller.filteredTeams.length,
                            itemBuilder: (context, i) {
                              Team el = controller.filteredTeams[i];
                              double totalVolume = 0.0;
                              for (var value in el.planks) {
                                totalVolume += value.volume;
                              }
                              return GestureDetector(
                                onTap: () {
                                  Get.dialog(
                                    AlertDialog(
                                      title: Text(
                                        DateFormat("dd/M/yyyy")
                                            .format(el.createDate),
                                      ),
                                      scrollable: true,
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 16.0,
                                          ),
                                          Text(
                                            el.brigade.name,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TeamTable(
                                            team: el,
                                          ),
                                          SizedBox(
                                            height: 16.0,
                                          ),
                                          Text(
                                            "Tara",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SelectableText(
                                            "Kopeja kubatura: " +
                                                totalVolume.toStringAsFixed(3),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.0,
                                          ),
                                          PlankTable(planks: el.planks),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  child: Container(
                                    width: context.width,
                                    padding: EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          DateFormat("dd/M/yyyy")
                                              .format(el.createDate),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 16.0),
                                        Text(
                                          el.brigade.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 16.0,
                                        ),
                                        IconButton(
                                          onPressed: () => Get.to(
                                            () => UpdateSalaries(team: el),
                                          ),
                                          icon: Icon(Icons.edit),
                                        ),
                                        SizedBox(width: 8.0),
                                        IconButton(
                                          onPressed: () => TeamHistoryController
                                              .to
                                              .removeTeam(el),
                                          icon: Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                  if (controller.showFilter)
                    Positioned(
                      top: 16.0,
                      right: 16.0,
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Filtrs",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              FormBuilder(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Datumi"),
                                    SizedBox(height: 4.0),
                                    SizedBox(
                                      width: 250,
                                      child: FormBuilderDateRangePicker(
                                        name: 'date_range',
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        onChanged: (DateTimeRange? d) {
                                          controller.dateRangeFilter = d;
                                        },
                                        firstDate: DateTime.utc(2022, 1, 1),
                                        lastDate: DateTime.utc(2023, 1, 1),
                                        format: DateFormat("dd/MM/yyyy"),
                                        initialEntryMode:
                                            DatePickerEntryMode.calendarOnly,
                                      ),
                                    ),
                                    SizedBox(height: 16.0),
                                    Text("Brigade"),
                                    SizedBox(height: 4.0),
                                    SizedBox(
                                      width: 250,
                                      child: FormBuilderDropdown<Brigade?>(
                                          onChanged: (Brigade? b) {
                                            controller.brigadeFilter = b;
                                          },
                                          name: "brigade",
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                          ),
                                          items: [
                                            ...controller.brigades.map(
                                              (e) => DropdownMenuItem<Brigade?>(
                                                child: Text(e.name),
                                                value: e,
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              child: const Text("All"),
                                              value: null,
                                            ),
                                          ]),
                                    ),
                                    SizedBox(height: 16.0),
                                    Text("Darbinieks"),
                                    SizedBox(height: 4.0),
                                    SizedBox(
                                      width: 250,
                                      child: FormBuilderDropdown<Employee?>(
                                          name: "employees",
                                          onChanged: (Employee? e) {
                                            controller.employeeFilter = e;
                                          },
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                          ),
                                          items: [
                                            ...SalaryCalculatorController
                                                .to.employees
                                                .map(
                                              (e) =>
                                                  DropdownMenuItem<Employee?>(
                                                child: Text(e.name),
                                                value: e,
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              child: const Text("All"),
                                              value: null,
                                            ),
                                          ]),
                                    ),
                                    SizedBox(
                                      height: 24.0,
                                    ),
                                    SizedBox(
                                      width: 250,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: FormBuilderCheckbox(
                                              name: "kalts_filter",
                                              title: Text("Kalts"),
                                              initialValue:
                                                  controller.filterKalts,
                                              onChanged: (bool? v) => v != null
                                                  ? controller.filterKalts = v
                                                  : false,
                                            ),
                                          ),
                                          Expanded(
                                            child: FormBuilderCheckbox(
                                              name: "zkv_filter",
                                              title: Text("Zkv"),
                                              initialValue:
                                                  controller.filterZkv,
                                              onChanged: (bool? v) => v != null
                                                  ? controller.filterZkv = v
                                                  : false,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 250,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: FormBuilderTextField(
                                              name: "height",
                                              onChanged: (String? v) {
                                                if (v != null) {
                                                  controller.heightFilter =
                                                      v.toDouble()!;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                isDense: true,
                                                border: OutlineInputBorder(),
                                                labelText: "Augstums",
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 8.0),
                                          Expanded(
                                            child: FormBuilderTextField(
                                              name: "width",
                                              onChanged: (String? v) {
                                                if (v != null) {
                                                  controller.widthFilter =
                                                      v.toDouble()!;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                isDense: true,
                                                border: OutlineInputBorder(),
                                                labelText: "Platums",
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 8.0),
                                          Expanded(
                                            child: FormBuilderTextField(
                                              name: "length",
                                              onChanged: (String? v) {
                                                if (v != null) {
                                                  controller.lengthFilter =
                                                      v.toDouble()!;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                isDense: true,
                                                border: OutlineInputBorder(),
                                                labelText: "Garums",
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 16.0),
                                    ElevatedButton(
                                      onPressed: () {
                                        controller.runFilter();
                                        Get.to(
                                          FilterHistory(
                                              planks: controller.filteredPlanks,
                                              members:
                                                  controller.filteredEmployees,
                                              teams: controller.filteredTeams),
                                        );
                                      },
                                      child: Text("Filter"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    Offstage(),
                ],
              ),
      ),
    );
  }
}

class TeamTable extends StatelessWidget {
  const TeamTable({
    Key? key,
    required this.team,
  }) : super(key: key);

  final Team team;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text("Vards")),
        DataColumn(label: Text("Kalts")),
        DataColumn(label: Text("Stundas")),
        DataColumn(label: Text("Alga")),
      ],
      rows: [
        ...team.members.map(
          (e) => DataRow(
            color: MaterialStateProperty.all<Color>(
              e.forklift ? Color(0xfffed931) : Colors.white,
            ),
            cells: [
              DataCell(
                SelectableText(e.name),
              ),
              DataCell(
                e.kalts
                    ? Icon(
                        Icons.check,
                        color: Colors.greenAccent,
                      )
                    : Icon(
                        Icons.close,
                        color: Colors.redAccent,
                      ),
              ),
              DataCell(Text(e.hours.toString())),
              DataCell(
                SelectableText(
                  e.salary.toStringAsFixed(2),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PlankTable extends StatelessWidget {
  const PlankTable({
    Key? key,
    required this.planks,
  }) : super(key: key);

  final List<Plank> planks;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text("Cehs")),
        DataColumn(label: Text("Augstums")),
        DataColumn(label: Text("Platums")),
        DataColumn(label: Text("Garums")),
        DataColumn(label: Text("Daudzums")),
        DataColumn(label: Text("Kubatura")),
        DataColumn(label: Text("Zkv")),
        DataColumn(label: Text("Kalts")),
      ],
      rows: [
        ...planks.map(
          (e) => DataRow(
            cells: [
              DataCell(
                SelectableText(e.type == TaraType.taraHigh
                    ? "Zala iela 6"
                    : "Kraulu iela 4"),
              ),
              DataCell(SelectableText(e.height.toString())),
              DataCell(SelectableText(e.width.toString())),
              DataCell(SelectableText(e.length.toString())),
              DataCell(SelectableText(e.amount.toString())),
              DataCell(
                SelectableText(
                  e.volume.toStringAsFixed(3),
                ),
              ),
              DataCell(
                e.zkv
                    ? Icon(
                        Icons.check,
                        color: Colors.greenAccent,
                      )
                    : Icon(
                        Icons.close,
                        color: Colors.redAccent,
                      ),
              ),
              DataCell(
                e.kalts
                    ? Icon(
                        Icons.check,
                        color: Colors.greenAccent,
                      )
                    : Icon(
                        Icons.close,
                        color: Colors.redAccent,
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
