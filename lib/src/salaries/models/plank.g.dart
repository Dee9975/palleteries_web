// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plank _$PlankFromJson(Map<String, dynamic> json) => Plank(
      id: json['id'] as int,
      height: (json['height'] as num).toDouble(),
      length: (json['length'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      amount: json['amount'] as int,
      type: $enumDecode(_$TaraTypeEnumMap, json['type']),
      kalts: json['kalts'] as bool? ?? false,
      zkv: json['zkv'] as bool? ?? false,
      d9: json['d9'] as bool? ?? false,
    );

Map<String, dynamic> _$PlankToJson(Plank instance) => <String, dynamic>{
      'id': instance.id,
      'height': instance.height,
      'width': instance.width,
      'length': instance.length,
      'amount': instance.amount,
      'type': _$TaraTypeEnumMap[instance.type],
      'zkv': instance.zkv,
      'kalts': instance.kalts,
      'd9': instance.d9,
    };

const _$TaraTypeEnumMap = {
  TaraType.taraHigh: 'tara_high',
  TaraType.taraLow: 'tara_low',
};
