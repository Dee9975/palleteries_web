import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:salary_app/src/settings/controllers/settings_controller.dart';
import 'package:supercharged/supercharged.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Iestatijumi",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Obx(
              () => SettingsController.to.settings == null
                  ? CircularProgressIndicator()
                  : FormBuilder(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text("Tara low: "),
                              ),
                              Container(
                                width: 80,
                                child: FormBuilderTextField(
                                  name: 'taraLow',
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                  ),
                                  onChanged: (v) => SettingsController.to
                                      .updateSettings(taraLow: v?.toDouble()),
                                  initialValue: SettingsController
                                          .to.settings?.taraLow
                                          .toString() ??
                                      "0.0",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text("Tara high: "),
                              ),
                              Container(
                                width: 80,
                                child: FormBuilderTextField(
                                  name: 'taraHigh',
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                  ),
                                  onChanged: (v) => SettingsController.to
                                      .updateSettings(taraHigh: v?.toDouble()),
                                  initialValue: SettingsController
                                          .to.settings?.taraHigh
                                          .toString() ??
                                      "0.0",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text("Sagataves: "),
                              ),
                              Container(
                                width: 80,
                                child: FormBuilderTextField(
                                  name: 'sagatave',
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                  ),
                                  onChanged: (v) => SettingsController.to
                                      .updateSettings(sagatave: v?.toDouble()),
                                  initialValue: SettingsController
                                          .to.settings?.sagatave
                                          .toString() ??
                                      "0.0",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text("Kalts: "),
                              ),
                              Container(
                                width: 80,
                                child: FormBuilderTextField(
                                  name: 'kalts',
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                  ),
                                  onChanged: (v) => SettingsController.to
                                      .updateSettings(kalts: v?.toDouble()),
                                  initialValue: SettingsController
                                          .to.settings?.kalts
                                          .toString() ??
                                      "0.0",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text("Zkv: "),
                              ),
                              Container(
                                width: 80,
                                child: FormBuilderTextField(
                                  name: 'zkv',
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                  ),
                                  onChanged: (v) => SettingsController.to
                                      .updateSettings(zkv: v?.toDouble()),
                                  initialValue: SettingsController
                                          .to.settings?.zkv
                                          .toString() ??
                                      "0.0",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text("Stundas Likme: "),
                              ),
                              Container(
                                width: 80,
                                child: FormBuilderTextField(
                                  name: 'hour_rate',
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                  ),
                                  onChanged: (v) => SettingsController.to
                                      .updateSettings(hourRate: v?.toDouble()),
                                  initialValue: SettingsController
                                          .to.settings?.hourRate
                                          .toString() ??
                                      "0.0",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text("D9 Tara: "),
                              ),
                              Container(
                                width: 80,
                                child: FormBuilderTextField(
                                  name: 'd9_tara',
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                  ),
                                  onChanged: (v) => SettingsController.to
                                      .updateSettings(d9tara: v?.toDouble()),
                                  initialValue: SettingsController
                                          .to.settings?.d9Tara
                                          .toString() ??
                                      "0.0",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text("D9 Zkv: "),
                              ),
                              Container(
                                width: 80,
                                child: FormBuilderTextField(
                                  name: 'd9_zkv',
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                  ),
                                  onChanged: (v) => SettingsController.to
                                      .updateSettings(d9zkv: v?.toDouble()),
                                  initialValue: SettingsController
                                          .to.settings?.d9Zkv
                                          .toString() ??
                                      "0.0",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text("Tara Kalts: "),
                              ),
                              Container(
                                width: 80,
                                child: FormBuilderTextField(
                                  name: 'tara_kalts',
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                  ),
                                  onChanged: (v) => SettingsController.to
                                      .updateSettings(taraKalts: v?.toDouble()),
                                  initialValue: SettingsController
                                          .to.settings?.taraKalts
                                          .toString() ??
                                      "0.0",
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          ElevatedButton(
                            onPressed: () =>
                                SettingsController.to.saveSettings(),
                            child: Text("Saglabat"),
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
