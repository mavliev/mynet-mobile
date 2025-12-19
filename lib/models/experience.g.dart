// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkExperienceImpl _$$WorkExperienceImplFromJson(Map<String, dynamic> json) =>
    _$WorkExperienceImpl(
      experienceId: (json['experienceId'] as num).toInt(),
      profileId: json['profileId'] as String,
      positionTitle: json['positionTitle'] as String,
      companyName: json['companyName'] as String?,
      companyUrl: json['companyUrl'] as String?,
      employmentType: json['employmentType'] as String?,
      location: json['location'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      durationText: json['durationText'] as String?,
      isCurrent: json['isCurrent'] as bool? ?? false,
      description: json['description'] as String?,
      orderIndex: (json['orderIndex'] as num?)?.toInt(),
      extractedAt: json['extractedAt'] == null
          ? null
          : DateTime.parse(json['extractedAt'] as String),
    );

Map<String, dynamic> _$$WorkExperienceImplToJson(
  _$WorkExperienceImpl instance,
) => <String, dynamic>{
  'experienceId': instance.experienceId,
  'profileId': instance.profileId,
  'positionTitle': instance.positionTitle,
  'companyName': instance.companyName,
  'companyUrl': instance.companyUrl,
  'employmentType': instance.employmentType,
  'location': instance.location,
  'startDate': instance.startDate?.toIso8601String(),
  'endDate': instance.endDate?.toIso8601String(),
  'durationText': instance.durationText,
  'isCurrent': instance.isCurrent,
  'description': instance.description,
  'orderIndex': instance.orderIndex,
  'extractedAt': instance.extractedAt?.toIso8601String(),
};
