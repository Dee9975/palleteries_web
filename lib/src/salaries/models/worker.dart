import 'package:json_annotation/json_annotation.dart';

part 'worker.g.dart';

@JsonSerializable()
class Employee {
  final int id;
  final String name;

  Employee({
    required this.id,
    required this.name,
  });

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}
