// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SkillImpl _$$SkillImplFromJson(Map<String, dynamic> json) => _$SkillImpl(
  skillId: (json['skillId'] as num).toInt(),
  profileId: json['profileId'] as String,
  skillName: json['skillName'] as String,
  endorsementCount: (json['endorsementCount'] as num?)?.toInt() ?? 0,
  isTopSkill: json['isTopSkill'] as bool? ?? false,
  orderIndex: (json['orderIndex'] as num?)?.toInt(),
  extractedAt: json['extractedAt'] == null
      ? null
      : DateTime.parse(json['extractedAt'] as String),
);

Map<String, dynamic> _$$SkillImplToJson(_$SkillImpl instance) =>
    <String, dynamic>{
      'skillId': instance.skillId,
      'profileId': instance.profileId,
      'skillName': instance.skillName,
      'endorsementCount': instance.endorsementCount,
      'isTopSkill': instance.isTopSkill,
      'orderIndex': instance.orderIndex,
      'extractedAt': instance.extractedAt?.toIso8601String(),
    };
