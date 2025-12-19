import 'package:freezed_annotation/freezed_annotation.dart';

part 'skill.freezed.dart';
part 'skill.g.dart';

@freezed
class Skill with _$Skill {
  const factory Skill({
    required int skillId,
    required String profileId,
    required String skillName,
    @Default(0) int endorsementCount,
    @Default(false) bool isTopSkill,
    int? orderIndex,
    DateTime? extractedAt,
  }) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);

  factory Skill.fromDb(Map<String, dynamic> map) {
    return Skill(
      skillId: map['skill_id'] as int,
      profileId: map['profile_id'] as String,
      skillName: map['skill_name'] as String,
      endorsementCount: map['endorsement_count'] as int? ?? 0,
      isTopSkill: (map['is_top_skill'] as int? ?? 0) == 1,
      orderIndex: map['order_index'] as int?,
      extractedAt: map['extracted_at'] != null
          ? DateTime.parse(map['extracted_at'] as String)
          : null,
    );
  }
}

extension SkillX on Skill {
  Map<String, dynamic> toDb() {
    return {
      'skill_id': skillId,
      'profile_id': profileId,
      'skill_name': skillName,
      'endorsement_count': endorsementCount,
      'is_top_skill': isTopSkill ? 1 : 0,
      'order_index': orderIndex,
      'extracted_at': extractedAt?.toIso8601String(),
    };
  }
}
