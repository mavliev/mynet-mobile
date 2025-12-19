import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
class LinkedInProfile with _$LinkedInProfile {
  const factory LinkedInProfile({
    required String profileId,
    required String profileUrl,
    required String fullName,
    String? headline,
    String? currentCompany,
    String? location,
    int? connectionCount,
    int? followerCount,
    String? aboutText,
    String? profilePhotoUrl,
    String? connectionDegree,
    DateTime? scrapedAt,
    DateTime? lastUpdatedAt,
    String? scrapeSource,
    @Default(true) bool isActive,
    @Default(1) int dataVersion,
    String? email,
    String? phone,
    String? websiteUrl,
    String? twitterHandle,
    String? birthday,
    DateTime? contactInfoScrapedAt,
  }) = _LinkedInProfile;

  factory LinkedInProfile.fromJson(Map<String, dynamic> json) =>
      _$LinkedInProfileFromJson(json);

  factory LinkedInProfile.fromDb(Map<String, dynamic> map) {
    return LinkedInProfile(
      profileId: map['profile_id'] as String,
      profileUrl: map['profile_url'] as String,
      fullName: map['full_name'] as String,
      headline: map['headline'] as String?,
      currentCompany: map['current_company'] as String?,
      location: map['location'] as String?,
      connectionCount: map['connection_count'] as int?,
      followerCount: map['follower_count'] as int?,
      aboutText: map['about_text'] as String?,
      profilePhotoUrl: map['profile_photo_url'] as String?,
      connectionDegree: map['connection_degree'] as String?,
      scrapedAt: map['scraped_at'] != null
          ? DateTime.parse(map['scraped_at'] as String)
          : null,
      lastUpdatedAt: map['last_updated_at'] != null
          ? DateTime.parse(map['last_updated_at'] as String)
          : null,
      scrapeSource: map['scrape_source'] as String?,
      isActive: (map['is_active'] as int? ?? 1) == 1,
      dataVersion: map['data_version'] as int? ?? 1,
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      websiteUrl: map['website_url'] as String?,
      twitterHandle: map['twitter_handle'] as String?,
      birthday: map['birthday'] as String?,
      contactInfoScrapedAt: map['contact_info_scraped_at'] != null
          ? DateTime.parse(map['contact_info_scraped_at'] as String)
          : null,
    );
  }
}

extension LinkedInProfileX on LinkedInProfile {
  Map<String, dynamic> toDb() {
    return {
      'profile_id': profileId,
      'profile_url': profileUrl,
      'full_name': fullName,
      'headline': headline,
      'current_company': currentCompany,
      'location': location,
      'connection_count': connectionCount,
      'follower_count': followerCount,
      'about_text': aboutText,
      'profile_photo_url': profilePhotoUrl,
      'connection_degree': connectionDegree,
      'scraped_at': scrapedAt?.toIso8601String(),
      'last_updated_at': lastUpdatedAt?.toIso8601String(),
      'scrape_source': scrapeSource,
      'is_active': isActive ? 1 : 0,
      'data_version': dataVersion,
      'email': email,
      'phone': phone,
      'website_url': websiteUrl,
      'twitter_handle': twitterHandle,
      'birthday': birthday,
      'contact_info_scraped_at': contactInfoScrapedAt?.toIso8601String(),
    };
  }
}
