import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:salary_app/src/salaries/models/plank.dart';

class PlankHistoryController extends GetxController {
  static PlankHistoryController get to => Get.find();

  final List<Plank> planks;

  PlankHistoryController(this.planks);

  final _filterWidth = 0.0.obs;
  final _filterHeight = 0.0.obs;
  final _filterLength = 0.0.obs;
  double get filterWidth => _filterWidth.value;
  double get filterHeight => _filterHeight.value;
  double get filterLength => _filterLength.value;
  set filterWidth(double val) => _filterWidth.value = val;
  set filterHeight(double val) => _filterHeight.value = val;
  set filterLength(double val) => _filterLength.value = val;

  final _filteredPlanks = <Plank>[].obs;
  List<Plank> get filteredPlanks => _filteredPlanks.value
      .where((element) =>
          (_filterWidth.value == 0.0 &&
              _filterHeight.value == 0.0 &&
              _filterLength.value == 0.0) ||
          (_filterWidth.value != 0.0
              ? element.width == _filterWidth.value
              : false) ||
          (_filterHeight.value != 0.0
              ? element.height == _filterHeight.value
              : false) ||
          (_filterLength.value != 0.0
              ? element.length == _filterLength.value
              : false))
      .toList();

  @override
  void onInit() {
    _filteredPlanks.value = planks;
    super.onInit();
  }
}
