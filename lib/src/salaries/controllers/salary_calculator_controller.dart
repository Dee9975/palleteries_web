import 'dart:convert';
import 'dart:html';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:salary_app/src/brigades/models/brigade.dart';
import 'package:salary_app/src/salaries/models/plank.dart';
import 'package:salary_app/src/salaries/models/team_member.dart';
import 'package:salary_app/src/salaries/models/worker.dart';
import 'package:salary_app/src/services/firestore_service.dart';
import 'package:salary_app/src/settings/models/settings_model.dart';
import 'package:supercharged/supercharged.dart';
import 'package:collection/collection.dart';

class SalaryCalculatorController extends GetxController {
  static SalaryCalculatorController get to => Get.find();

  final _employees = <Employee>[
    Employee(id: 1, name: "Agnis Birznieks"),
    Employee(id: 2, name: "Agris Gailis"),
    Employee(id: 3, name: "Aigars Muižnieks"),
    Employee(id: 4, name: "Aija Prūse"),
    Employee(id: 5, name: "Ainars Gūtmanis"),
    Employee(id: 6, name: "Ainars Jurjurs"),
    Employee(id: 7, name: "Ainārs Prūsis"),
    Employee(id: 8, name: "Aldis Dzintars"),
    Employee(id: 9, name: "Andis Rībens"),
    Employee(id: 10, name: "Andrejs Birsanu"),
    Employee(id: 11, name: "Andris Staltmanis"),
    Employee(id: 12, name: "Anna Nasteviča"),
    Employee(id: 13, name: "Antanas Bulionis"),
    Employee(id: 14, name: "Antra Damberga"),
    Employee(id: 15, name: "Arnis Cielava"),
    Employee(id: 16, name: "Artūrs Berkins"),
    Employee(id: 17, name: "Arvis Kreiders"),
    Employee(id: 18, name: "Dace Rubule"),
    Employee(id: 19, name: "Dainis Balabka"),
    Employee(id: 901, name: "Dainis Hibners"),
    Employee(id: 20, name: "Dainis Pētersons"),
    Employee(id: 20, name: "Dainis Prūsis"),
    Employee(id: 21, name: "Dzintars Vecrumba"),
    Employee(id: 22, name: "Edgars Ungerts"),
    Employee(id: 23, name: "Egija Snipe"),
    Employee(id: 24, name: "Elita Pujāte"),
    Employee(id: 25, name: "Elīna Dreijere"),
    Employee(id: 26, name: "Elmārs Krūmiņš"),
    Employee(id: 27, name: "Evita Bādere"),
    Employee(id: 333, name: "Gints Puzars"),
    Employee(id: 28, name: "Gundars Šternbergs"),
    Employee(id: 29, name: "Guntars Jansons"),
    Employee(id: 30, name: "Guntis Kārkliņš"),
    Employee(id: 31, name: "Igors Kungs"),
    Employee(id: 32, name: "Ilgvars Simsons"),
    Employee(id: 33, name: "Ilmārs Linde"),
    Employee(id: 34, name: "Iluta Gaile"),
    Employee(id: 35, name: "Ilze Pūce"),
    Employee(id: 36, name: "Indars Vētrājs"),
    Employee(id: 37, name: "Ingus Beļakovs"),
    Employee(id: 38, name: "Ingus Mazbergs"),
    Employee(id: 39, name: "Ivars Steiks"),
    Employee(id: 40, name: "Jānis Blūms"),
    Employee(id: 41, name: "Jānis Cērps"),
    Employee(id: 255, name: "Jānis Hibners"),
    Employee(id: 42, name: "Jānis Krasts"),
    Employee(id: 43, name: "Jānis Mūrnieks"),
    Employee(id: 44, name: "Jeļena Ņevska"),
    Employee(id: 45, name: "Jolanta Alkšare"),
    Employee(id: 450, name: "Jolanta Dambica"),
    Employee(id: 46, name: "Jozs Stankevičus"),
    Employee(id: 47, name: "Juris Kudiņš"),
    Employee(id: 48, name: "Juris Kupča"),
    Employee(id: 49, name: "Juris Silarājs"),
    Employee(id: 50, name: "Jurita Rezņikova"),
    Employee(id: 51, name: "Justīne Intenberga"),
    Employee(id: 52, name: "Kaspars Juška"),
    Employee(id: 53, name: "Kaspars Karps"),
    Employee(id: 54, name: "Kitija Strazdovska"),
    Employee(id: 55, name: "Klāvs Jansons"),
    Employee(id: 56, name: "Klāvs Zvirbulis"),
    Employee(id: 58, name: "Kristaps Radviniskaitis"),
    Employee(id: 59, name: "Laima Gūtmane"),
    Employee(id: 60, name: "Laura Balandiņa"),
    Employee(id: 61, name: "Lauris Cērmanis"),
    Employee(id: 62, name: "Lauris Daniels Joniņš"),
    Employee(id: 63, name: "Leonīds Faterkins"),
    Employee(id: 64, name: "Liene Adamane"),
    Employee(id: 65, name: "Liene Berševica"),
    Employee(id: 67, name: "Līga Rebaine"),
    Employee(id: 68, name: "Līvija Linde"),
    Employee(id: 69, name: "Madars Zaics"),
    Employee(id: 70, name: "Mārcis Vētrājs"),
    Employee(id: 71, name: "Māris Dzintars"),
    Employee(id: 72, name: "Māris Pūce"),
    Employee(id: 73, name: "Mārtiņš Ezeriņš"),
    Employee(id: 74, name: "Mārtiņš Feldmanis"),
    Employee(id: 75, name: "Mārtiņš Kristapsons"),
    Employee(id: 76, name: "Mārtiņš Leimanis"),
    Employee(id: 77, name: "Mārtiņš Leja"),
    Employee(id: 324, name: "Mārtiņš Osis"),
    Employee(id: 78, name: "Mārtiņš Rēfelds"),
    Employee(id: 79, name: "Mārtiņš Rībens"),
    Employee(id: 80, name: "Mārtiņš Vilsons"),
    Employee(id: 81, name: "Mārtiņš Volkonovskis"),
    Employee(id: 82, name: "Nauris Dzintars"),
    Employee(id: 83, name: "Normunds Jansons"),
    Employee(id: 84, name: "Normunds Kūla"),
    Employee(id: 85, name: "Oskars Bergmanis"),
    Employee(id: 86, name: "Oskars Krolmanis"),
    Employee(id: 87, name: "Raimonds Balandiņš"),
    Employee(id: 870, name: "Roberts Alkšars"),
    Employee(id: 88, name: "Reinis Anševics"),
    Employee(id: 89, name: "Santa Braunfelde"),
    Employee(id: 90, name: "Sintija Leke-Vīnvalde"),
    Employee(id: 91, name: "Valdis Leimanis"),
    Employee(id: 92, name: "Viktors Guļaško"),
    Employee(id: 93, name: "Vilnis Haferbergs"),
    Employee(id: 94, name: "Vineta Rubule"),
  ].obs;

  List<Employee> get employees => _employees;

  final hourRate = 5.0.obs;

  final teamMembers = <TeamMember>[].obs;

  final finishedMembers = <TeamMember>[].obs;

  final splitMembers = <TeamMember>[].obs;

  final _settings = Rx<SettingsModel?>(null);
  SettingsModel? get settings => _settings.value;

  final _selectedDateTime = Rx<DateTime>(DateTime.now());
  DateTime get selectedDateTime => _selectedDateTime.value;
  set selectedDateTime(DateTime t) => _selectedDateTime.value = t;

  final _brigades = <Brigade>[].obs;
  List<Brigade> get brigades => _brigades.value;

  final _selectedBrigade = Rx<Brigade?>(null);
  Brigade? get selectedBrigade => _selectedBrigade.value;

  final tara = <Plank>[].obs;

  final formKey = GlobalKey<FormBuilderState>();
  final plankFormKey = GlobalKey<FormBuilderState>();
  final plankEditFormKey = GlobalKey<FormBuilderState>();

  double get totalVolume {
    double val = 0.0;

    for (var element in tara) {
      val += element.volume;
    }

    return val;
  }

  @override
  Future<void> onInit() async {
    // ever(teamMembers, (List<TeamMember> m) {
    //   if (m.isNotEmpty && tara.isNotEmpty) {
    //     calculateSalaries();
    //   }
    // });
    // ever(tara, (List<Plank> t) {
    //   if (t.isNotEmpty && teamMembers.isNotEmpty) {
    //     calculateSalaries();
    //   }
    // });
    _settings.value = await FirestoreService().getSettings();
    _brigades.value = await FirestoreService().getBrigades();
    _selectedBrigade.value = _brigades[0];
    super.onInit();
  }

  void addEmployee(Employee e) {
    teamMembers.add(
      TeamMember(
        id: e.id,
        name: e.name,
      ),
    );
  }

  void removeEmployee(TeamMember e) {
    teamMembers.removeWhere((element) => element.id == e.id);
  }

  void setForklift(
    TeamMember e,
    bool val,
  ) {
    final i = teamMembers.indexWhere(
      (element) => e.id == element.id,
    );
    teamMembers[i] = TeamMember(
      id: e.id,
      name: e.name,
      forklift: val,
    );
  }

  void updateMember(TeamMember m) {
    Get.dialog(
      AlertDialog(
        title: Text("#${m.id} ${m.name}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormBuilder(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormBuilderCheckbox(
                    name: 'kalts',
                    initialValue: m.kalts,
                    title: const Text("Kalts"),
                  ),
                  FormBuilderCheckbox(
                    name: 'split_work',
                    initialValue: m.splitWork,
                    title: const Text("Sadalits darbs"),
                  ),
                  FormBuilderTextField(
                    name: "split_hours",
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Nostradatas Stundas",
                      hintText: "0.0",
                    ),
                    initialValue: m.splitHours.toString(),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.numeric(Get.context!),
                    ]),
                  ),
                  SizedBox(height: 16.0),
                  FormBuilderTextField(
                    name: "hours",
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Stundas",
                      hintText: "0.0",
                    ),
                    initialValue: m.hours.toString(),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.numeric(Get.context!),
                    ]),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      bool kalts = m.kalts;
                      bool splitWork = m.splitWork;
                      double splitHours = m.splitHours;
                      double hours = 0.0;

                      if (formKey.currentState!.validate()) {
                        for (var element
                            in formKey.currentState!.fields.entries) {
                          switch (element.key) {
                            case "kalts":
                              kalts = element.value.value as bool;
                              break;
                            case "split_work":
                              splitWork = element.value.value as bool;
                              break;
                            case "hours":
                              if (element.value.value == null ||
                                  element.value.value == "") {
                                hours = 0.0;
                                break;
                              }
                              hours =
                                  (element.value.value as String).toDouble() ??
                                      0.0;
                              break;
                            case "split_hours":
                              if (element.value.value == null ||
                                  element.value.value == "") {
                                hours = 0.0;
                                break;
                              }
                              splitHours =
                                  (element.value.value as String).toDouble() ??
                                      0.0;
                              break;
                            default:
                              break;
                          }
                        }
                        final i = teamMembers.indexWhere(
                          (element) => m.id == element.id,
                        );
                        teamMembers[i] = TeamMember(
                          id: m.id,
                          name: m.name,
                          hours: hours,
                          kalts: kalts,
                          splitWork: splitWork,
                          splitHours: splitHours,
                        );
                        Get.back();
                      }
                    },
                    child: const Text("Apstiprinat"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addPlank() {
    if (plankFormKey.currentState!.validate()) {
      double width = 0.0;
      double height = 0.0;
      double length = 0.0;
      int amount = 0;
      bool zkv = false;
      bool kalts = false;
      bool d9 = false;
      TaraType type = TaraType.taraHigh;

      for (var element in plankFormKey.currentState!.fields.entries) {
        switch (element.key) {
          case "width":
            if (element.value.value == null || element.value.value == "") {
              width = 0.0;
              break;
            }
            width = (element.value.value as String).toDouble() ?? 0.0;
            break;
          case "height":
            if (element.value.value == null || element.value.value == "") {
              height = 0.0;
              break;
            }
            height = (element.value.value as String).toDouble() ?? 0.0;
            break;
          case "length":
            if (element.value.value == null || element.value.value == "") {
              length = 0.0;
              break;
            }
            length = (element.value.value as String).toDouble() ?? 0.0;
            break;
          case "amount":
            if (element.value.value == null || element.value.value == "") {
              amount = 0;
              break;
            }
            amount = (element.value.value as String).toInt() ?? 0;
            break;
          case "zkv":
            zkv = element.value.value as bool;
            break;
          case "kalts":
            kalts = element.value.value as bool;
            break;
          case "d9":
            d9 = element.value.value as bool;
            break;
          case "tara_type":
            type = element.value.value as TaraType;
            break;
          default:
            break;
        }
      }
      tara.add(
        Plank(
          id: DateTime.now().millisecondsSinceEpoch,
          width: width / 1000,
          height: height / 1000,
          length: length / 1000,
          amount: amount,
          zkv: zkv,
          kalts: kalts,
          d9: d9,
          type: type,
        ),
      );
    }
  }

  void removePlank(Plank p) {
    final i = tara.removeWhere((element) => p.id == element.id);
  }

  void updatePlank(int id) {
    if (plankEditFormKey.currentState!.validate()) {
      double width = 0.0;
      double height = 0.0;
      double length = 0.0;
      int amount = 0;
      bool zkv = false;
      bool kalts = false;
      TaraType type = TaraType.taraHigh;

      for (var element in plankEditFormKey.currentState!.fields.entries) {
        switch (element.key) {
          case "width":
            if (element.value.value == null || element.value.value == "") {
              width = 0.0;
              break;
            }
            width = (element.value.value as String).toDouble() ?? 0.0;
            break;
          case "height":
            if (element.value.value == null || element.value.value == "") {
              height = 0.0;
              break;
            }
            height = (element.value.value as String).toDouble() ?? 0.0;
            break;
          case "length":
            if (element.value.value == null || element.value.value == "") {
              length = 0.0;
              break;
            }
            length = (element.value.value as String).toDouble() ?? 0.0;
            break;
          case "amount":
            if (element.value.value == null || element.value.value == "") {
              amount = 0;
              break;
            }
            amount = (element.value.value as String).toInt() ?? 0;
            break;
          case "zkv":
            zkv = element.value.value as bool;
            break;
          case "kalts":
            kalts = element.value.value as bool;
            break;
          case "tara_type":
            type = element.value.value as TaraType;
            break;
          default:
            break;
        }
      }
      final Plank newPlank = Plank(
        id: id,
        width: width / 1000,
        height: height / 1000,
        length: length / 1000,
        amount: amount,
        zkv: zkv,
        kalts: kalts,
        type: type,
      );
      tara[tara.indexWhere((element) => element.id == id)] = newPlank;
    }
  }

  double calculatePayout(Plank p) {
    if (p.zkv) {
      return p.d9 ? _settings.value!.d9Zkv : _settings.value!.zkv;
    }
    if (p.type == TaraType.taraHigh) {
      return p.d9 ? _settings.value!.d9Tara : _settings.value!.taraHigh;
    }
    return p.d9 ? _settings.value!.d9Tara : _settings.value!.taraLow;
  }

  double calculateTotal() {
    double t = 0.0;
    for (Plank plank in tara) {
      double payout = calculatePayout(plank);
      t += payout * plank.volume;
    }
    return t;
  }

  double calculateSalary(double t, [bool split = false]) {
    if (teamMembers.isNotEmpty) {
      final workingMembers = teamMembers
          .where(
            (m) => !m.forklift && !m.splitWork,
          )
          .toList();
      double totalHours = 0.0;
      for (TeamMember m in teamMembers) {
        totalHours += m.splitHours;
      }

      return t / (workingMembers.length + totalHours / 8);
    }
    return 0.0;
  }

  void calculateSalaries() {
    finishedMembers.clear();
    final total = calculateTotal();
    final double dayPay = calculateSalary(total);
    for (TeamMember member in teamMembers) {
      double salary = dayPay;
      if (member.forklift) {
        salary += (0.2 * dayPay);
      }
      if (member.kalts) {
        for (Plank p in tara) {
          if (p.kalts) {
            salary += p.volume * _settings.value!.kalts;
          }
        }
      }
      if (member.hours > 0) {
        salary += _settings.value!.hourRate * member.hours;
      }
      if (!member.splitWork) {
        TeamMember finishedMember = member;
        finishedMember.salary = salary;
        final i = teamMembers.indexWhere((element) => element.id == member.id);
        teamMembers[i] = finishedMember;
        finishedMembers.add(finishedMember);
        continue;
      }
      TeamMember splitMember = member;
      splitMember.salary = (dayPay / 8) * member.splitHours;
      final i = teamMembers.indexWhere((element) => element.id == member.id);
      teamMembers[i] = splitMember;
      splitMembers.add(splitMember);
    }
  }

  Future<void> exportToExcel() async {
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

    finishedMembers.forEachIndexed((index, element) {
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

  Future<void> uploadTeam() async {
    final team = Team(
      id: DateTime.now().millisecondsSinceEpoch,
      createDate: _selectedDateTime.value,
      members: teamMembers.toList(),
      planks: tara.toList(),
      brigade: _selectedBrigade.value!,
    );
    await FirestoreService().addTeam(team);
  }
}
