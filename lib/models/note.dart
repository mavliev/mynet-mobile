import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.freezed.dart';
part 'note.g.dart';

enum NoteType {
  general,
  meeting,
  research,
  followUp,
  personal,
}

@freezed
class ProfileNote with _$ProfileNote {
  const factory ProfileNote({
    required int id,
    required String profileId,
    required String profileType,
    String? title,
    required String content,
    @Default(NoteType.general) NoteType noteType,
    @Default(false) bool isPinned,
    String? colorTag,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
    @Default(false) bool isDeleted,
    String? deviceId,
    @Default(1) int version,
    @Default('last_write_wins') String conflictResolutionStrategy,
  }) = _ProfileNote;

  factory ProfileNote.fromJson(Map<String, dynamic> json) =>
      _$ProfileNoteFromJson(json);

  factory ProfileNote.fromDb(Map<String, dynamic> map) {
    return ProfileNote(
      id: map['id'] as int,
      profileId: map['profile_id'] as String,
      profileType: map['profile_type'] as String,
      title: map['title'] as String?,
      content: map['content'] as String,
      noteType: _parseNoteType(map['note_type'] as String?),
      isPinned: (map['is_pinned'] as int? ?? 0) == 1,
      colorTag: map['color_tag'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      syncedAt: map['synced_at'] != null
          ? DateTime.parse(map['synced_at'] as String)
          : null,
      isDeleted: (map['is_deleted'] as int? ?? 0) == 1,
      deviceId: map['device_id'] as String?,
      version: map['version'] as int? ?? 1,
      conflictResolutionStrategy:
          map['conflict_resolution_strategy'] as String? ?? 'last_write_wins',
    );
  }

  static NoteType _parseNoteType(String? value) {
    switch (value) {
      case 'meeting':
        return NoteType.meeting;
      case 'research':
        return NoteType.research;
      case 'follow_up':
        return NoteType.followUp;
      case 'personal':
        return NoteType.personal;
      default:
        return NoteType.general;
    }
  }
}

extension ProfileNoteX on ProfileNote {
  Map<String, dynamic> toDb() {
    return {
      'id': id,
      'profile_id': profileId,
      'profile_type': profileType,
      'title': title,
      'content': content,
      'note_type': _noteTypeToString(noteType),
      'is_pinned': isPinned ? 1 : 0,
      'color_tag': colorTag,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'synced_at': syncedAt?.toIso8601String(),
      'is_deleted': isDeleted ? 1 : 0,
      'device_id': deviceId,
      'version': version,
      'conflict_resolution_strategy': conflictResolutionStrategy,
    };
  }

  String _noteTypeToString(NoteType type) {
    switch (type) {
      case NoteType.general:
        return 'general';
      case NoteType.meeting:
        return 'meeting';
      case NoteType.research:
        return 'research';
      case NoteType.followUp:
        return 'follow_up';
      case NoteType.personal:
        return 'personal';
    }
  }
}
