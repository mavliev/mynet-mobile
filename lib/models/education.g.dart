// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EducationImpl _$$EducationImplFromJson(Map<String, dynamic> json) =>
    _$EducationImpl(
      educationId: (json['educationId'] as num).toInt(),
      profileId: json['profileId'] as String,
      schoolName: json['schoolName'] as String,
      schoolUrl: json['schoolUrl'] as String?,
      degree: json['degree'] as String?,
      fieldOfStudy: json['fieldOfStudy'] as String?,
      startYear: (json['startYear'] as num?)?.toInt(),
      endYear: (json['endYear'] as num?)?.toInt(),
      grade: json['grade'] as String?,
      activities: json['activities'] as String?,
      description: json['description'] as String?,
      orderIndex: (json['orderIndex'] as num?)?.toInt(),
      extractedAt: json['extractedAt'] == null
          ? null
          : DateTime.parse(json['extractedAt'] as String),
    );

Map<String, dynamic> _$$EducationImplToJson(_$EducationImpl instance) =>
    <String, dynamic>{
      'educationId': instance.educationId,
      'profileId': instance.profileId,
      'schoolName': instance.schoolName,
      'schoolUrl': instance.schoolUrl,
      'degree': instance.degree,
      'fieldOfStudy': instance.fieldOfStudy,
      'startYear': instance.startYear,
      'endYear': instance.endYear,
      'grade': instance.grade,
      'activities': instance.activities,
      'description': instance.description,
      'orderIndex': instance.orderIndex,
      'extractedAt': instance.extractedAt?.toIso8601String(),
    };
