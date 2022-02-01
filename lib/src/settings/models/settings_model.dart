import 'package:json_annotation/json_annotation.dart';

part 'settings_model.g.dart';

@JsonSerializable()
class SettingsModel {
  double zkv;
  double taraHigh;
  double taraLow;
  double kalts;
  double sagatave;
  double hourRate;
  @JsonKey(name: "d9_tara")
  double d9Tara;
  @JsonKey(name: "d9_zkv")
  double d9Zkv;
  @JsonKey(name: "tara_kalts")
  double taraKalts;

  SettingsModel({
    required this.zkv,
    required this.taraHigh,
    required this.taraLow,
    required this.kalts,
    required this.sagatave,
    required this.hourRate,
    required this.d9Tara,
    required this.d9Zkv,
    required this.taraKalts,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsModelToJson(this);
}
