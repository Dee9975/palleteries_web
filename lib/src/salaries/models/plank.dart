import 'package:json_annotation/json_annotation.dart';

part 'plank.g.dart';

@JsonSerializable(explicitToJson: true)
class Plank {
  final int id;
  final double height;
  final double width;
  final double length;
  final int amount;
  final TaraType type;
  bool zkv;
  bool kalts;

  double get volume => height * width * length * amount;

  Plank({
    required this.id,
    required this.height,
    required this.length,
    required this.width,
    required this.amount,
    required this.type,
    this.kalts = false,
    this.zkv = false,
  });

  factory Plank.fromJson(Map<String, dynamic> json) => _$PlankFromJson(json);
  Map<String, dynamic> toJson() => _$PlankToJson(this);
}

@JsonEnum()
enum TaraType {
  @JsonValue('tara_high')
  taraHigh,
  @JsonValue("tara_low")
  taraLow
}
