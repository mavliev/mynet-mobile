// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LinkedInProfileImpl _$$LinkedInProfileImplFromJson(
  Map<String, dynamic> json,
) => _$LinkedInProfileImpl(
  profileId: json['profileId'] as String,
  profileUrl: json['profileUrl'] as String,
  fullName: json['fullName'] as String,
  headline: json['headline'] as String?,
  currentCompany: json['currentCompany'] as String?,
  location: json['location'] as String?,
  connectionCount: (json['connectionCount'] as num?)?.toInt(),
  followerCount: (json['followerCount'] as num?)?.toInt(),
  aboutText: json['aboutText'] as String?,
  profilePhotoUrl: json['profilePhotoUrl'] as String?,
  connectionDegree: json['connectionDegree'] as String?,
  scrapedAt: json['scrapedAt'] == null
      ? null
      : DateTime.parse(json['scrapedAt'] as String),
  lastUpdatedAt: json['lastUpdatedAt'] == null
      ? null
      : DateTime.parse(json['lastUpdatedAt'] as String),
  scrapeSource: json['scrapeSource'] as String?,
  isActive: json['isActive'] as bool? ?? true,
  dataVersion: (json['dataVersion'] as num?)?.toInt() ?? 1,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  websiteUrl: json['websiteUrl'] as String?,
  twitterHandle: json['twitterHandle'] as String?,
  birthday: json['birthday'] as String?,
  contactInfoScrapedAt: json['contactInfoScrapedAt'] == null
      ? null
      : DateTime.parse(json['contactInfoScrapedAt'] as String),
);

Map<String, dynamic> _$$LinkedInProfileImplToJson(
  _$LinkedInProfileImpl instance,
) => <String, dynamic>{
  'profileId': instance.profileId,
  'profileUrl': instance.profileUrl,
  'fullName': instance.fullName,
  'headline': instance.headline,
  'currentCompany': instance.currentCompany,
  'location': instance.location,
  'connectionCount': instance.connectionCount,
  'followerCount': instance.followerCount,
  'aboutText': instance.aboutText,
  'profilePhotoUrl': instance.profilePhotoUrl,
  'connectionDegree': instance.connectionDegree,
  'scrapedAt': instance.scrapedAt?.toIso8601String(),
  'lastUpdatedAt': instance.lastUpdatedAt?.toIso8601String(),
  'scrapeSource': instance.scrapeSource,
  'isActive': instance.isActive,
  'dataVersion': instance.dataVersion,
  'email': instance.email,
  'phone': instance.phone,
  'websiteUrl': instance.websiteUrl,
  'twitterHandle': instance.twitterHandle,
  'birthday': instance.birthday,
  'contactInfoScrapedAt': instance.contactInfoScrapedAt?.toIso8601String(),
};
