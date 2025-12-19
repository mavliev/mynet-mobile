import 'package:freezed_annotation/freezed_annotation.dart';

part 'education.freezed.dart';
part 'education.g.dart';

@freezed
class Education with _$Education {
  const factory Education({
    required int educationId,
    required String profileId,
    required String schoolName,
    String? schoolUrl,
    String? degree,
    String? fieldOfStudy,
    int? startYear,
    int? endYear,
    String? grade,
    String? activities,
    String? description,
    int? orderIndex,
    DateTime? extractedAt,
  }) = _Education;

  factory Education.fromJson(Map<String, dynamic> json) =>
      _$EducationFromJson(json);

  factory Education.fromDb(Map<String, dynamic> map) {
    return Education(
      educationId: map['education_id'] as int,
      profileId: map['profile_id'] as String,
      schoolName: map['school_name'] as String,
      schoolUrl: map['school_url'] as String?,
      degree: map['degree'] as String?,
      fieldOfStudy: map['field_of_study'] as String?,
      startYear: map['start_year'] as int?,
      endYear: map['end_year'] as int?,
      grade: map['grade'] as String?,
      activities: map['activities'] as String?,
      description: map['description'] as String?,
      orderIndex: map['order_index'] as int?,
      extractedAt: map['extracted_at'] != null
          ? DateTime.parse(map['extracted_at'] as String)
          : null,
    );
  }
}

extension EducationX on Education {
  Map<String, dynamic> toDb() {
    return {
      'education_id': educationId,
      'profile_id': profileId,
      'school_name': schoolName,
      'school_url': schoolUrl,
      'degree': degree,
      'field_of_study': fieldOfStudy,
      'start_year': startYear,
      'end_year': endYear,
      'grade': grade,
      'activities': activities,
      'description': description,
      'order_index': orderIndex,
      'extracted_at': extractedAt?.toIso8601String(),
    };
  }
}
