import 'package:json_annotation/json_annotation.dart';

part 'brigade.g.dart';

@JsonSerializable(explicitToJson: true)
class Brigade {
  final int id;
  final String name;

  Brigade({
    required this.id,
    required this.name,
  });

  factory Brigade.fromJson(Map<String, dynamic> json) =>
      _$BrigadeFromJson(json);
  Map<String, dynamic> toJson() => _$BrigadeToJson(this);
}
