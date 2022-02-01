// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      id: json['id'] as int,
      createDate: DateTime.parse(json['createDate'] as String),
      members: (json['members'] as List<dynamic>)
          .map((e) => TeamMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      planks: (json['planks'] as List<dynamic>)
          .map((e) => Plank.fromJson(e as Map<String, dynamic>))
          .toList(),
      brigade: Brigade.fromJson(json['brigade'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'id': instance.id,
      'createDate': instance.createDate.toIso8601String(),
      'members': instance.members.map((e) => e.toJson()).toList(),
      'planks': instance.planks.map((e) => e.toJson()).toList(),
      'brigade': instance.brigade.toJson(),
    };

TeamMember _$TeamMemberFromJson(Map<String, dynamic> json) => TeamMember(
      id: json['id'] as int,
      name: json['name'] as String,
      forklift: json['forklift'] as bool? ?? false,
      kalts: json['kalts'] as bool? ?? false,
      hours: (json['hours'] as num?)?.toDouble() ?? 0.0,
      salary: (json['salary'] as num?)?.toDouble() ?? 0.0,
      splitWork: json['splitWork'] as bool? ?? false,
      splitHours: (json['splitHours'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$TeamMemberToJson(TeamMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'salary': instance.salary,
      'forklift': instance.forklift,
      'kalts': instance.kalts,
      'hours': instance.hours,
      'splitWork': instance.splitWork,
      'splitHours': instance.splitHours,
    };
