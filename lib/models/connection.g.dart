// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConnectionImpl _$$ConnectionImplFromJson(Map<String, dynamic> json) =>
    _$ConnectionImpl(
      id: (json['id'] as num).toInt(),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      linkedinUrl: json['linkedinUrl'] as String,
      emailAddress: json['emailAddress'] as String?,
      company: json['company'] as String?,
      position: json['position'] as String?,
      connectedOn: json['connectedOn'] as String,
      connectionStrength: (json['connectionStrength'] as num?)?.toInt() ?? 1,
      lastInteractionDate: json['lastInteractionDate'] as String?,
      totalInteractions: (json['totalInteractions'] as num?)?.toInt() ?? 0,
      connectionSource: json['connectionSource'] as String?,
      tags: json['tags'] as String?,
      notes: json['notes'] as String?,
      canProvideIntro: json['canProvideIntro'] as bool? ?? false,
      worksAtTargetCompany: json['worksAtTargetCompany'] as bool? ?? false,
      isHiringManager: json['isHiringManager'] as bool? ?? false,
      isRecruiter: json['isRecruiter'] as bool? ?? false,
      importedFrom: json['importedFrom'] as String? ?? 'linkedin_export',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ConnectionImplToJson(_$ConnectionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'linkedinUrl': instance.linkedinUrl,
      'emailAddress': instance.emailAddress,
      'company': instance.company,
      'position': instance.position,
      'connectedOn': instance.connectedOn,
      'connectionStrength': instance.connectionStrength,
      'lastInteractionDate': instance.lastInteractionDate,
      'totalInteractions': instance.totalInteractions,
      'connectionSource': instance.connectionSource,
      'tags': instance.tags,
      'notes': instance.notes,
      'canProvideIntro': instance.canProvideIntro,
      'worksAtTargetCompany': instance.worksAtTargetCompany,
      'isHiringManager': instance.isHiringManager,
      'isRecruiter': instance.isRecruiter,
      'importedFrom': instance.importedFrom,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
