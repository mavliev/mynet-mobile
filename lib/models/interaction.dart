import 'package:freezed_annotation/freezed_annotation.dart';

part 'interaction.freezed.dart';
part 'interaction.g.dart';

enum InteractionType {
  call,
  email,
  meeting,
  coffee,
  event,
  linkedinMessage,
  text,
  introduction,
  referral,
  other,
}

enum InteractionOutcome {
  positive,
  neutral,
  negative,
  followUpNeeded,
}

@freezed
class ProfileInteraction with _$ProfileInteraction {
  const factory ProfileInteraction({
    required int id,
    required String profileId,
    required String profileType,
    required InteractionType interactionType,
    required DateTime interactionDate,
    int? durationMinutes,
    String? subject,
    String? summary,
    InteractionOutcome? outcome,
    DateTime? followUpDate,
    @Default(false) bool followUpCompleted,
    String? location,
    String? attachmentPaths,
    String? relatedNoteIds,
    @Default(false) bool isImportant,
    String? tags,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
    @Default(false) bool isDeleted,
    String? deviceId,
    @Default(1) int version,
  }) = _ProfileInteraction;

  factory ProfileInteraction.fromJson(Map<String, dynamic> json) =>
      _$ProfileInteractionFromJson(json);

  factory ProfileInteraction.fromDb(Map<String, dynamic> map) {
    return ProfileInteraction(
      id: map['id'] as int,
      profileId: map['profile_id'] as String,
      profileType: map['profile_type'] as String,
      interactionType: _parseInteractionType(map['interaction_type'] as String),
      interactionDate: DateTime.parse(map['interaction_date'] as String),
      durationMinutes: map['duration_minutes'] as int?,
      subject: map['subject'] as String?,
      summary: map['summary'] as String?,
      outcome: _parseOutcome(map['outcome'] as String?),
      followUpDate: map['follow_up_date'] != null
          ? DateTime.parse(map['follow_up_date'] as String)
          : null,
      followUpCompleted: (map['follow_up_completed'] as int? ?? 0) == 1,
      location: map['location'] as String?,
      attachmentPaths: map['attachment_paths'] as String?,
      relatedNoteIds: map['related_note_ids'] as String?,
      isImportant: (map['is_important'] as int? ?? 0) == 1,
      tags: map['tags'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      syncedAt: map['synced_at'] != null
          ? DateTime.parse(map['synced_at'] as String)
          : null,
      isDeleted: (map['is_deleted'] as int? ?? 0) == 1,
      deviceId: map['device_id'] as String?,
      version: map['version'] as int? ?? 1,
    );
  }

  static InteractionType _parseInteractionType(String value) {
    switch (value) {
      case 'call':
        return InteractionType.call;
      case 'email':
        return InteractionType.email;
      case 'meeting':
        return InteractionType.meeting;
      case 'coffee':
        return InteractionType.coffee;
      case 'event':
        return InteractionType.event;
      case 'linkedin_message':
        return InteractionType.linkedinMessage;
      case 'text':
        return InteractionType.text;
      case 'introduction':
        return InteractionType.introduction;
      case 'referral':
        return InteractionType.referral;
      default:
        return InteractionType.other;
    }
  }

  static InteractionOutcome? _parseOutcome(String? value) {
    if (value == null) return null;
    switch (value) {
      case 'positive':
        return InteractionOutcome.positive;
      case 'neutral':
        return InteractionOutcome.neutral;
      case 'negative':
        return InteractionOutcome.negative;
      case 'follow_up_needed':
        return InteractionOutcome.followUpNeeded;
      default:
        return null;
    }
  }
}

extension ProfileInteractionX on ProfileInteraction {
  Map<String, dynamic> toDb() {
    return {
      'id': id,
      'profile_id': profileId,
      'profile_type': profileType,
      'interaction_type': _interactionTypeToString(interactionType),
      'interaction_date': interactionDate.toIso8601String(),
      'duration_minutes': durationMinutes,
      'subject': subject,
      'summary': summary,
      'outcome': outcome != null ? _outcomeToString(outcome!) : null,
      'follow_up_date': followUpDate?.toIso8601String(),
      'follow_up_completed': followUpCompleted ? 1 : 0,
      'location': location,
      'attachment_paths': attachmentPaths,
      'related_note_ids': relatedNoteIds,
      'is_important': isImportant ? 1 : 0,
      'tags': tags,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'synced_at': syncedAt?.toIso8601String(),
      'is_deleted': isDeleted ? 1 : 0,
      'device_id': deviceId,
      'version': version,
    };
  }

  String _interactionTypeToString(InteractionType type) {
    switch (type) {
      case InteractionType.call:
        return 'call';
      case InteractionType.email:
        return 'email';
      case InteractionType.meeting:
        return 'meeting';
      case InteractionType.coffee:
        return 'coffee';
      case InteractionType.event:
        return 'event';
      case InteractionType.linkedinMessage:
        return 'linkedin_message';
      case InteractionType.text:
        return 'text';
      case InteractionType.introduction:
        return 'introduction';
      case InteractionType.referral:
        return 'referral';
      case InteractionType.other:
        return 'other';
    }
  }

  String _outcomeToString(InteractionOutcome outcome) {
    switch (outcome) {
      case InteractionOutcome.positive:
        return 'positive';
      case InteractionOutcome.neutral:
        return 'neutral';
      case InteractionOutcome.negative:
        return 'negative';
      case InteractionOutcome.followUpNeeded:
        return 'follow_up_needed';
    }
  }
}
