// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileNoteImpl _$$ProfileNoteImplFromJson(Map<String, dynamic> json) =>
    _$ProfileNoteImpl(
      id: (json['id'] as num).toInt(),
      profileId: json['profileId'] as String,
      profileType: json['profileType'] as String,
      title: json['title'] as String?,
      content: json['content'] as String,
      noteType:
          $enumDecodeNullable(_$NoteTypeEnumMap, json['noteType']) ??
          NoteType.general,
      isPinned: json['isPinned'] as bool? ?? false,
      colorTag: json['colorTag'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      isDeleted: json['isDeleted'] as bool? ?? false,
      deviceId: json['deviceId'] as String?,
      version: (json['version'] as num?)?.toInt() ?? 1,
      conflictResolutionStrategy:
          json['conflictResolutionStrategy'] as String? ?? 'last_write_wins',
    );

Map<String, dynamic> _$$ProfileNoteImplToJson(_$ProfileNoteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profileId': instance.profileId,
      'profileType': instance.profileType,
      'title': instance.title,
      'content': instance.content,
      'noteType': _$NoteTypeEnumMap[instance.noteType]!,
      'isPinned': instance.isPinned,
      'colorTag': instance.colorTag,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'isDeleted': instance.isDeleted,
      'deviceId': instance.deviceId,
      'version': instance.version,
      'conflictResolutionStrategy': instance.conflictResolutionStrategy,
    };

const _$NoteTypeEnumMap = {
  NoteType.general: 'general',
  NoteType.meeting: 'meeting',
  NoteType.research: 'research',
  NoteType.followUp: 'followUp',
  NoteType.personal: 'personal',
};
