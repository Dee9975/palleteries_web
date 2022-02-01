import 'package:json_annotation/json_annotation.dart';
import 'package:salary_app/src/brigades/models/brigade.dart';
import 'package:salary_app/src/salaries/models/plank.dart';

part 'team_member.g.dart';

@JsonSerializable(explicitToJson: true)
class Team {
  final int id;
  final DateTime createDate;
  final List<TeamMember> members;
  final List<Plank> planks;
  final Brigade brigade;

  Team({
    required this.id,
    required this.createDate,
    required this.members,
    required this.planks,
    required this.brigade,
  });
  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
  Map<String, dynamic> toJson() => _$TeamToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TeamMember {
  final int id;
  final String name;
  double salary;
  bool forklift;
  bool kalts;
  double hours;
  bool splitWork;
  double splitHours;

  TeamMember({
    required this.id,
    required this.name,
    this.forklift = false,
    this.kalts = false,
    this.hours = 0.0,
    this.salary = 0.0,
    this.splitWork = false,
    this.splitHours = 0.0,
  });
  factory TeamMember.fromJson(Map<String, dynamic> json) =>
      _$TeamMemberFromJson(json);
  Map<String, dynamic> toJson() => _$TeamMemberToJson(this);
}
