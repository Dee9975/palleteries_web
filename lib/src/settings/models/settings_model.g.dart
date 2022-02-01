// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsModel _$SettingsModelFromJson(Map<String, dynamic> json) =>
    SettingsModel(
      zkv: (json['zkv'] as num).toDouble(),
      taraHigh: (json['taraHigh'] as num).toDouble(),
      taraLow: (json['taraLow'] as num).toDouble(),
      kalts: (json['kalts'] as num).toDouble(),
      sagatave: (json['sagatave'] as num).toDouble(),
      hourRate: (json['hourRate'] as num).toDouble(),
      d9Tara: (json['d9_tara'] as num).toDouble(),
      d9Zkv: (json['d9_zkv'] as num).toDouble(),
      taraKalts: (json['tara_kalts'] as num).toDouble(),
    );

Map<String, dynamic> _$SettingsModelToJson(SettingsModel instance) =>
    <String, dynamic>{
      'zkv': instance.zkv,
      'taraHigh': instance.taraHigh,
      'taraLow': instance.taraLow,
      'kalts': instance.kalts,
      'sagatave': instance.sagatave,
      'hourRate': instance.hourRate,
      'd9_tara': instance.d9Tara,
      'd9_zkv': instance.d9Zkv,
      'tara_kalts': instance.taraKalts,
    };
