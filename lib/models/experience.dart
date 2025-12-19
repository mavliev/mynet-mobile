import 'package:freezed_annotation/freezed_annotation.dart';

part 'experience.freezed.dart';
part 'experience.g.dart';

@freezed
class WorkExperience with _$WorkExperience {
  const factory WorkExperience({
    required int experienceId,
    required String profileId,
    required String positionTitle,
    String? companyName,
    String? companyUrl,
    String? employmentType,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
    String? durationText,
    @Default(false) bool isCurrent,
    String? description,
    int? orderIndex,
    DateTime? extractedAt,
  }) = _WorkExperience;

  factory WorkExperience.fromJson(Map<String, dynamic> json) =>
      _$WorkExperienceFromJson(json);

  factory WorkExperience.fromDb(Map<String, dynamic> map) {
    return WorkExperience(
      experienceId: map['experience_id'] as int,
      profileId: map['profile_id'] as String,
      positionTitle: map['position_title'] as String,
      companyName: map['company_name'] as String?,
      companyUrl: map['company_url'] as String?,
      employmentType: map['employment_type'] as String?,
      location: map['location'] as String?,
      startDate: map['start_date'] != null
          ? DateTime.parse(map['start_date'] as String)
          : null,
      endDate:
          map['end_date'] != null ? DateTime.parse(map['end_date'] as String) : null,
      durationText: map['duration_text'] as String?,
      isCurrent: (map['is_current'] as int? ?? 0) == 1,
      description: map['description'] as String?,
      orderIndex: map['order_index'] as int?,
      extractedAt: map['extracted_at'] != null
          ? DateTime.parse(map['extracted_at'] as String)
          : null,
    );
  }
}

extension WorkExperienceX on WorkExperience {
  Map<String, dynamic> toDb() {
    return {
      'experience_id': experienceId,
      'profile_id': profileId,
      'position_title': positionTitle,
      'company_name': companyName,
      'company_url': companyUrl,
      'employment_type': employmentType,
      'location': location,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'duration_text': durationText,
      'is_current': isCurrent ? 1 : 0,
      'description': description,
      'order_index': orderIndex,
      'extracted_at': extractedAt?.toIso8601String(),
    };
  }
}
