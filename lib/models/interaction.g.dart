// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileInteractionImpl _$$ProfileInteractionImplFromJson(
  Map<String, dynamic> json,
) => _$ProfileInteractionImpl(
  id: (json['id'] as num).toInt(),
  profileId: json['profileId'] as String,
  profileType: json['profileType'] as String,
  interactionType: $enumDecode(
    _$InteractionTypeEnumMap,
    json['interactionType'],
  ),
  interactionDate: DateTime.parse(json['interactionDate'] as String),
  durationMinutes: (json['durationMinutes'] as num?)?.toInt(),
  subject: json['subject'] as String?,
  summary: json['summary'] as String?,
  outcome: $enumDecodeNullable(_$InteractionOutcomeEnumMap, json['outcome']),
  followUpDate: json['followUpDate'] == null
      ? null
      : DateTime.parse(json['followUpDate'] as String),
  followUpCompleted: json['followUpCompleted'] as bool? ?? false,
  location: json['location'] as String?,
  attachmentPaths: json['attachmentPaths'] as String?,
  relatedNoteIds: json['relatedNoteIds'] as String?,
  isImportant: json['isImportant'] as bool? ?? false,
  tags: json['tags'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  syncedAt: json['syncedAt'] == null
      ? null
      : DateTime.parse(json['syncedAt'] as String),
  isDeleted: json['isDeleted'] as bool? ?? false,
  deviceId: json['deviceId'] as String?,
  version: (json['version'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$$ProfileInteractionImplToJson(
  _$ProfileInteractionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'profileId': instance.profileId,
  'profileType': instance.profileType,
  'interactionType': _$InteractionTypeEnumMap[instance.interactionType]!,
  'interactionDate': instance.interactionDate.toIso8601String(),
  'durationMinutes': instance.durationMinutes,
  'subject': instance.subject,
  'summary': instance.summary,
  'outcome': _$InteractionOutcomeEnumMap[instance.outcome],
  'followUpDate': instance.followUpDate?.toIso8601String(),
  'followUpCompleted': instance.followUpCompleted,
  'location': instance.location,
  'attachmentPaths': instance.attachmentPaths,
  'relatedNoteIds': instance.relatedNoteIds,
  'isImportant': instance.isImportant,
  'tags': instance.tags,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'syncedAt': instance.syncedAt?.toIso8601String(),
  'isDeleted': instance.isDeleted,
  'deviceId': instance.deviceId,
  'version': instance.version,
};

const _$InteractionTypeEnumMap = {
  InteractionType.call: 'call',
  InteractionType.email: 'email',
  InteractionType.meeting: 'meeting',
  InteractionType.coffee: 'coffee',
  InteractionType.event: 'event',
  InteractionType.linkedinMessage: 'linkedinMessage',
  InteractionType.text: 'text',
  InteractionType.introduction: 'introduction',
  InteractionType.referral: 'referral',
  InteractionType.other: 'other',
};

const _$InteractionOutcomeEnumMap = {
  InteractionOutcome.positive: 'positive',
  InteractionOutcome.neutral: 'neutral',
  InteractionOutcome.negative: 'negative',
  InteractionOutcome.followUpNeeded: 'followUpNeeded',
};
