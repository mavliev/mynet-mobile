import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag.freezed.dart';
part 'tag.g.dart';

@freezed
class ProfileTag with _$ProfileTag {
  const factory ProfileTag({
    required int id,
    required String tagName,
    String? tagCategory,
    String? tagColor,
    @Default(0) int usageCount,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool isSystemTag,
  }) = _ProfileTag;

  factory ProfileTag.fromJson(Map<String, dynamic> json) =>
      _$ProfileTagFromJson(json);

  factory ProfileTag.fromDb(Map<String, dynamic> map) {
    return ProfileTag(
      id: map['id'] as int,
      tagName: map['tag_name'] as String,
      tagCategory: map['tag_category'] as String?,
      tagColor: map['tag_color'] as String?,
      usageCount: map['usage_count'] as int? ?? 0,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      isSystemTag: (map['is_system_tag'] as int? ?? 0) == 1,
    );
  }
}

extension ProfileTagX on ProfileTag {
  Map<String, dynamic> toDb() {
    return {
      'id': id,
      'tag_name': tagName,
      'tag_category': tagCategory,
      'tag_color': tagColor,
      'usage_count': usageCount,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_system_tag': isSystemTag ? 1 : 0,
    };
  }
}

@freezed
class ProfileTagAssociation with _$ProfileTagAssociation {
  const factory ProfileTagAssociation({
    required int id,
    required String profileId,
    required String profileType,
    required int tagId,
    String? taggedBy,
    required DateTime taggedAt,
    DateTime? syncedAt,
    @Default(false) bool isDeleted,
  }) = _ProfileTagAssociation;

  factory ProfileTagAssociation.fromJson(Map<String, dynamic> json) =>
      _$ProfileTagAssociationFromJson(json);

  factory ProfileTagAssociation.fromDb(Map<String, dynamic> map) {
    return ProfileTagAssociation(
      id: map['id'] as int,
      profileId: map['profile_id'] as String,
      profileType: map['profile_type'] as String,
      tagId: map['tag_id'] as int,
      taggedBy: map['tagged_by'] as String?,
      taggedAt: DateTime.parse(map['tagged_at'] as String),
      syncedAt: map['synced_at'] != null
          ? DateTime.parse(map['synced_at'] as String)
          : null,
      isDeleted: (map['is_deleted'] as int? ?? 0) == 1,
    );
  }
}

extension ProfileTagAssociationX on ProfileTagAssociation {
  Map<String, dynamic> toDb() {
    return {
      'id': id,
      'profile_id': profileId,
      'profile_type': profileType,
      'tag_id': tagId,
      'tagged_by': taggedBy,
      'tagged_at': taggedAt.toIso8601String(),
      'synced_at': syncedAt?.toIso8601String(),
      'is_deleted': isDeleted ? 1 : 0,
    };
  }
}
