// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileTagImpl _$$ProfileTagImplFromJson(Map<String, dynamic> json) =>
    _$ProfileTagImpl(
      id: (json['id'] as num).toInt(),
      tagName: json['tagName'] as String,
      tagCategory: json['tagCategory'] as String?,
      tagColor: json['tagColor'] as String?,
      usageCount: (json['usageCount'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isSystemTag: json['isSystemTag'] as bool? ?? false,
    );

Map<String, dynamic> _$$ProfileTagImplToJson(_$ProfileTagImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tagName': instance.tagName,
      'tagCategory': instance.tagCategory,
      'tagColor': instance.tagColor,
      'usageCount': instance.usageCount,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isSystemTag': instance.isSystemTag,
    };

_$ProfileTagAssociationImpl _$$ProfileTagAssociationImplFromJson(
  Map<String, dynamic> json,
) => _$ProfileTagAssociationImpl(
  id: (json['id'] as num).toInt(),
  profileId: json['profileId'] as String,
  profileType: json['profileType'] as String,
  tagId: (json['tagId'] as num).toInt(),
  taggedBy: json['taggedBy'] as String?,
  taggedAt: DateTime.parse(json['taggedAt'] as String),
  syncedAt: json['syncedAt'] == null
      ? null
      : DateTime.parse(json['syncedAt'] as String),
  isDeleted: json['isDeleted'] as bool? ?? false,
);

Map<String, dynamic> _$$ProfileTagAssociationImplToJson(
  _$ProfileTagAssociationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'profileId': instance.profileId,
  'profileType': instance.profileType,
  'tagId': instance.tagId,
  'taggedBy': instance.taggedBy,
  'taggedAt': instance.taggedAt.toIso8601String(),
  'syncedAt': instance.syncedAt?.toIso8601String(),
  'isDeleted': instance.isDeleted,
};
