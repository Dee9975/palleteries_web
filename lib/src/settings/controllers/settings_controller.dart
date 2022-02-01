import 'package:get/get.dart';
import 'package:salary_app/src/services/firestore_service.dart';
import 'package:salary_app/src/settings/models/settings_model.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  final _settings = Rx<SettingsModel?>(null);
  SettingsModel? get settings => _settings.value;

  void updateSettings({
    double? zkv,
    double? taraHigh,
    double? taraLow,
    double? kalts,
    double? sagatave,
    double? hourRate,
    double? d9tara,
    double? d9zkv,
    double? taraKalts,
  }) {
    _settings.update((val) {
      if (zkv != null) {
        val?.zkv = zkv;
      }
      if (taraHigh != null) {
        val?.taraHigh = taraHigh;
      }
      if (taraLow != null) {
        val?.taraLow = taraLow;
      }
      if (kalts != null) {
        val?.kalts = kalts;
      }
      if (sagatave != null) {
        val?.sagatave = sagatave;
      }
      if (hourRate != null) {
        val?.hourRate = hourRate;
      }
      if (d9tara != null) {
        val?.d9Tara = d9tara;
      }
      if (d9zkv != null) {
        val?.d9Zkv = d9zkv;
      }
      if (taraKalts != null) {
        val?.taraKalts = taraKalts;
      }
    });
  }

  @override
  Future<void> onInit() async {
    try {
      _settings.value = await FirestoreService().getSettings();
    } on StateError catch (e) {
      if (e.message == "No element") {
        await FirestoreService().createSettings(SettingsModel(
          zkv: 8.2,
          taraHigh: 14.5,
          taraLow: 12.15,
          kalts: 0.22,
          sagatave: 1.7,
          hourRate: 4.65,
          d9Tara: 10.8,
          d9Zkv: 7.2,
          taraKalts: 2.65,
        ));
      }
    }
    super.onInit();
  }

  Future<void> saveSettings() async {
    if (_settings.value != null) {
      await FirestoreService().updateSettings(_settings.value!);
    }
  }
}
