import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salary_app/src/monthly_salaries/screens/monthly_salaries_table.dart';
import 'package:salary_app/src/salaries/models/team_member.dart';
import 'package:salary_app/src/services/firestore_service.dart';
import 'package:collection/collection.dart';

class MonthlySalariesController extends GetxController {
  static MonthlySalariesController get to => Get.find();

  final _dateRangeFilter = Rx<DateTimeRange?>(null);
  DateTimeRange? get dateRangeFilter => _dateRangeFilter.value;
  set dateRangeFilter(DateTimeRange? val) => _dateRangeFilter.value = val;

  final _finalMembers = <TeamMember>[].obs;

  Future<void> calculateSalaries() async {
    List<Team> teams = await FirestoreService().findTeams();
    teams = teams
        .where((element) =>
            element.createDate.millisecondsSinceEpoch >=
                _dateRangeFilter.value!.start.millisecondsSinceEpoch &&
            element.createDate.millisecondsSinceEpoch <=
                _dateRangeFilter.value!.end.millisecondsSinceEpoch)
        .toList();
    final List<TeamMember> members = [];
    for (Team t in teams) {
      for (TeamMember m in t.members) {
        final i = members.indexWhere((element) => element.id == m.id);
        if (i >= 0) {
          members[i].salary += m.salary;
          continue;
        }
        members.add(m);
      }
    }
    _finalMembers.value = members;
    Get.to(
      () => MonthlySalariesTable(
        members: members,
      ),
    );
  }

  Future<void> exportToExcel() async {
    Excel excel = Excel.createExcel();
    Sheet sheet = excel["Algas"];

    sheet.updateCell(
      CellIndex.indexByColumnRow(
        columnIndex: 0,
        rowIndex: 0,
      ),
      "Vards",
      cellStyle: CellStyle(
        backgroundColorHex: "#00ffff",
      ),
    );
    sheet.updateCell(
      CellIndex.indexByColumnRow(
        columnIndex: 1,
        rowIndex: 0,
      ),
      "Alga",
      cellStyle: CellStyle(
        backgroundColorHex: "#00ffff",
      ),
    );

    _finalMembers.forEachIndexed((index, element) {
      sheet.updateCell(
        CellIndex.indexByColumnRow(
          columnIndex: 0,
          rowIndex: index + 1,
        ),
        element.name,
      );
      sheet.updateCell(
        CellIndex.indexByColumnRow(
          columnIndex: 1,
          rowIndex: index + 1,
        ),
        element.salary.toStringAsFixed(2),
      );
    });

    var fileBytes = excel.save(
      fileName: "${DateTime.now().millisecondsSinceEpoch}.xlsx",
    );
  }
}
