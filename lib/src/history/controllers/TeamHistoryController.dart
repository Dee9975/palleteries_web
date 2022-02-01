import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salary_app/src/brigades/models/brigade.dart';
import 'package:salary_app/src/salaries/models/plank.dart';
import 'package:salary_app/src/salaries/models/team_member.dart';
import 'package:salary_app/src/salaries/models/worker.dart';
import 'package:salary_app/src/services/firestore_service.dart';
import 'package:collection/collection.dart';

class TeamHistoryController extends GetxController {
  static TeamHistoryController get to => Get.find();

  final _teams = <Team>[].obs;
  List<Team> get teams => _teams.value;

  final _loading = false.obs;
  bool get loading => _loading.value;

  final _brigades = <Brigade>[].obs;
  List<Brigade> get brigades => _brigades.value;

  final _showFilter = true.obs;
  bool get showFilter => _showFilter.value;
  set showFilter(bool val) => _showFilter.value = val;

  final _brigadeFilter = Rx<Brigade?>(null);
  Brigade? get brigadeFilter => _brigadeFilter.value;
  set brigadeFilter(Brigade? val) => _brigadeFilter.value = val;

  final _employeeFilter = Rx<Employee?>(null);
  Employee? get employeeFilter => _employeeFilter.value;
  set employeeFilter(Employee? val) => _employeeFilter.value = val;

  final _dateRangeFilter = Rx<DateTimeRange?>(null);
  DateTimeRange? get dateRangeFilter => _dateRangeFilter.value;
  set dateRangeFilter(DateTimeRange? val) => _dateRangeFilter.value = val;

  final _widthFilter = 0.0.obs;
  double get widthFilter => _widthFilter.value;
  set widthFilter(double val) => _widthFilter.value = val;

  final _heightFilter = 0.0.obs;
  double get heightFilter => _heightFilter.value;
  set heightFilter(double val) => _heightFilter.value = val;

  final _lengthFilter = 0.0.obs;
  double get lengthFilter => _lengthFilter.value;
  set lengthFilter(double val) => _lengthFilter.value = val;

  final _filteredTeams = <Team>[].obs;
  List<Team> get filteredTeams => _filteredTeams.value;

  final _filteredPlanks = <Plank>[].obs;
  List<Plank> get filteredPlanks => _filteredPlanks.value;

  final _filteredEmployees = <TeamMember>[].obs;
  List<TeamMember> get filteredEmployees => _filteredEmployees.value;

  final _filterKalts = false.obs;
  bool get filterKalts => _filterKalts.value;
  set filterKalts(bool val) => _filterKalts.value = val;

  final _filterZkv = false.obs;
  bool get filterZkv => _filterZkv.value;
  set filterZkv(bool val) => _filterZkv.value = val;

  double getFilteredVolume() {
    double t = 0.0;
    for (Plank p in _filteredPlanks) {
      t += p.volume;
    }
    return t;
  }

  double getFilteredSalary() {
    double t = 0.0;
    for (TeamMember m in _filteredEmployees) {
      t += m.salary;
    }
    return t;
  }

  @override
  Future<void> onInit() async {
    _loading.value = true;
    _teams.value = await FirestoreService().findTeams();
    _brigades.value = await FirestoreService().getBrigades();
    _loading.value = false;
    super.onInit();
  }

  Future<void> exportPlanksToPdf() async {
    Excel excel = Excel.createExcel();
    Sheet sheet = excel["Tara"];

    sheet.updateCell(
      CellIndex.indexByColumnRow(
        columnIndex: 0,
        rowIndex: 0,
      ),
      "Augstums",
      cellStyle: CellStyle(
        backgroundColorHex: "#00ffff",
      ),
    );
    sheet.updateCell(
      CellIndex.indexByColumnRow(
        columnIndex: 1,
        rowIndex: 0,
      ),
      "Platums",
      cellStyle: CellStyle(
        backgroundColorHex: "#00ffff",
      ),
    );
    sheet.updateCell(
      CellIndex.indexByColumnRow(
        columnIndex: 2,
        rowIndex: 0,
      ),
      "Garums",
      cellStyle: CellStyle(
        backgroundColorHex: "#00ffff",
      ),
    );
    sheet.updateCell(
      CellIndex.indexByColumnRow(
        columnIndex: 3,
        rowIndex: 0,
      ),
      "Kubatura",
      cellStyle: CellStyle(
        backgroundColorHex: "#00ffff",
      ),
    );
    sheet.updateCell(
      CellIndex.indexByColumnRow(
        columnIndex: 4,
        rowIndex: 0,
      ),
      "Zkv",
      cellStyle: CellStyle(
        backgroundColorHex: "#00ffff",
      ),
    );
    sheet.updateCell(
      CellIndex.indexByColumnRow(
        columnIndex: 5,
        rowIndex: 0,
      ),
      "Kalts",
      cellStyle: CellStyle(
        backgroundColorHex: "#00ffff",
      ),
    );
    double totalVolume = 0.0;
    _filteredPlanks.forEachIndexed((index, element) {
      totalVolume += element.volume;
      sheet.updateCell(
        CellIndex.indexByColumnRow(
          columnIndex: 0,
          rowIndex: index + 1,
        ),
        element.height,
      );
      sheet.updateCell(
        CellIndex.indexByColumnRow(
          columnIndex: 1,
          rowIndex: index + 1,
        ),
        element.width,
      );
      sheet.updateCell(
        CellIndex.indexByColumnRow(
          columnIndex: 2,
          rowIndex: index + 1,
        ),
        element.length,
      );
      sheet.updateCell(
        CellIndex.indexByColumnRow(
          columnIndex: 3,
          rowIndex: index + 1,
        ),
        element.volume.toStringAsFixed(3),
      );
      sheet.updateCell(
        CellIndex.indexByColumnRow(
          columnIndex: 4,
          rowIndex: index + 1,
        ),
        element.zkv ? "X" : "",
      );
      sheet.updateCell(
        CellIndex.indexByColumnRow(
          columnIndex: 5,
          rowIndex: index + 1,
        ),
        element.kalts ? "X" : "",
      );
    });

    sheet.updateCell(
      CellIndex.indexByColumnRow(
        columnIndex: 6,
        rowIndex: 0,
      ),
      "$totalVolume",
    );

    var fileBytes = excel.save(
      fileName: "${DateTime.now().millisecondsSinceEpoch}.xlsx",
    );
  }

  Future<void> exportEmployeesToExcel() async {
    Excel excel = Excel.createExcel();
    Sheet sheet = excel["Algas"];

    sheet.updateCell(
      CellIndex.indexByColumnRow(
        columnIndex: 1,
        rowIndex: 1,
      ),
      "Vards",
    );

    sheet.updateCell(
      CellIndex.indexByColumnRow(
        columnIndex: 3,
        rowIndex: 1,
      ),
      "Kalts",
    );
    sheet.updateCell(
      CellIndex.indexByColumnRow(
        columnIndex: 4,
        rowIndex: 1,
      ),
      "Iekravejs",
    );

    sheet.updateCell(
      CellIndex.indexByColumnRow(
        columnIndex: 2,
        rowIndex: 1,
      ),
      "Alga",
    );

    _filteredEmployees.forEachIndexed((index, element) {
      sheet.updateCell(
        CellIndex.indexByColumnRow(
          columnIndex: 1,
          rowIndex: 2 + index,
        ),
        element.name,
      );
      sheet.updateCell(
        CellIndex.indexByColumnRow(
          columnIndex: 2,
          rowIndex: 2 + index,
        ),
        element.salary,
      );

      sheet.updateCell(
        CellIndex.indexByColumnRow(
          columnIndex: 3,
          rowIndex: 2 + index,
        ),
        element.kalts ? "x" : "",
      );

      sheet.updateCell(
        CellIndex.indexByColumnRow(
          columnIndex: 4,
          rowIndex: 2 + index,
        ),
        element.forklift ? "x" : "",
      );
    });

    var fileBytes =
        excel.save(fileName: "${DateTime.now().millisecondsSinceEpoch}.xlsx");
    // final content = base64Encode(fileBytes!);
    // final anchor = AnchorElement(
    //     href: "data:application/octet-stream;charset=utf-16le;base64,$content")
    //   ..setAttribute("download", "algas.xlsx")
    //   ..click();
  }

  void runFilter() {
    var bFilter = <Team>[];
    var plankFilter = <Plank>[];
    var eFilter = <TeamMember>[];
    var dFilter = <Team>[];

    if (_dateRangeFilter.value != null) {
      // run dateRange filter
      for (Team t in _teams) {
        if (t.createDate.millisecondsSinceEpoch >=
                _dateRangeFilter.value!.start.millisecondsSinceEpoch &&
            t.createDate.millisecondsSinceEpoch <=
                _dateRangeFilter.value!.end.millisecondsSinceEpoch) {
          dFilter.add(t);
        }
      }
    } else {
      dFilter = _teams;
    }

    if (_brigadeFilter.value != null) {
      // run brigade filter
      for (Team t in dFilter) {
        if (t.brigade.id == _brigadeFilter.value!.id) {
          bFilter.add(t);
        }
      }
      if (bFilter.isNotEmpty) {
        dFilter = bFilter;
      }
    }

    if (_employeeFilter.value != null) {
      // run employee
      for (Team t in dFilter) {
        for (TeamMember m in t.members) {
          if (m.id == _employeeFilter.value!.id) {
            eFilter.add(m);
          }
        }
      }
    }

    if (_widthFilter.value > 0.0 &&
        _lengthFilter.value > 0.0 &&
        _heightFilter.value > 0.0) {
      // run plank filter
      for (Team t in dFilter) {
        for (Plank p in t.planks) {
          if (p.width == _widthFilter.value &&
              p.length == _lengthFilter.value &&
              p.height == _heightFilter.value) {
            plankFilter.add(p);
          }
        }
      }
    }

    if (_filterKalts.value) {
      final newList = <Plank>[];
      for (Plank p in plankFilter) {
        if (p.kalts) {
          newList.add(p);
        }
      }
      plankFilter = newList;
    }

    if (_filterZkv.value) {
      final newList = <Plank>[];
      for (Plank p in plankFilter) {
        if (p.zkv) {
          newList.add(p);
        }
      }
      plankFilter = newList;
    }

    _filteredTeams.value = dFilter;
    _filteredPlanks.value = plankFilter;
    _filteredEmployees.value = eFilter;
  }
}
