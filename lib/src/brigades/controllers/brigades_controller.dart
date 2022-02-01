import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:salary_app/src/brigades/models/brigade.dart';
import 'package:salary_app/src/services/firestore_service.dart';

class BrigadesController extends GetxController {
  static BrigadesController get to => Get.find();

  final _brigades = <Brigade>[].obs;
  List<Brigade> get brigades => _brigades.value;

  final _loading = false.obs;
  bool get loading => _loading.value;

  final GlobalKey<FormBuilderState> key = GlobalKey<FormBuilderState>();

  @override
  Future<void> onInit() async {
    _loading.value = true;
    _brigades.value = await FirestoreService().getBrigades();
    _loading.value = false;
    super.onInit();
  }

  Future<void> addBrigade() async {
    if (key.currentState!.validate()) {
      Get.back();
      _loading.value = true;
      await FirestoreService().addBrigade(
        Brigade(
          id: DateTime.now().millisecondsSinceEpoch,
          name: key.currentState!.fields["name"]!.value as String,
        ),
      );
      _brigades.value = await FirestoreService().getBrigades();
      _loading.value = false;
    }
  }

  Future<void> removeBrigade(int id) async {
    _loading.value = true;
    await FirestoreService().removeBrigade(id);
    _brigades.removeWhere((element) => element.id == id);
    _loading.value = false;
  }
}
