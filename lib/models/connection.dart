import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection.freezed.dart';
part 'connection.g.dart';

@freezed
class Connection with _$Connection {
  const factory Connection({
    required int id,
    required String firstName,
    required String lastName,
    required String linkedinUrl,
    String? emailAddress,
    String? company,
    String? position,
    required String connectedOn,
    @Default(1) int connectionStrength,
    String? lastInteractionDate,
    @Default(0) int totalInteractions,
    String? connectionSource,
    String? tags,
    String? notes,
    @Default(false) bool canProvideIntro,
    @Default(false) bool worksAtTargetCompany,
    @Default(false) bool isHiringManager,
    @Default(false) bool isRecruiter,
    @Default('linkedin_export') String importedFrom,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Connection;

  factory Connection.fromJson(Map<String, dynamic> json) =>
      _$ConnectionFromJson(json);

  factory Connection.fromDb(Map<String, dynamic> map) {
    return Connection(
      id: map['id'] as int,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      linkedinUrl: map['linkedin_url'] as String,
      emailAddress: map['email_address'] as String?,
      company: map['company'] as String?,
      position: map['position'] as String?,
      connectedOn: map['connected_on'] as String,
      connectionStrength: map['connection_strength'] as int? ?? 1,
      lastInteractionDate: map['last_interaction_date'] as String?,
      totalInteractions: map['total_interactions'] as int? ?? 0,
      connectionSource: map['connection_source'] as String?,
      tags: map['tags'] as String?,
      notes: map['notes'] as String?,
      canProvideIntro: (map['can_provide_intro'] as int? ?? 0) == 1,
      worksAtTargetCompany: (map['works_at_target_company'] as int? ?? 0) == 1,
      isHiringManager: (map['is_hiring_manager'] as int? ?? 0) == 1,
      isRecruiter: (map['is_recruiter'] as int? ?? 0) == 1,
      importedFrom: map['imported_from'] as String? ?? 'linkedin_export',
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }
}

extension ConnectionX on Connection {
  Map<String, dynamic> toDb() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'linkedin_url': linkedinUrl,
      'email_address': emailAddress,
      'company': company,
      'position': position,
      'connected_on': connectedOn,
      'connection_strength': connectionStrength,
      'last_interaction_date': lastInteractionDate,
      'total_interactions': totalInteractions,
      'connection_source': connectionSource,
      'tags': tags,
      'notes': notes,
      'can_provide_intro': canProvideIntro ? 1 : 0,
      'works_at_target_company': worksAtTargetCompany ? 1 : 0,
      'is_hiring_manager': isHiringManager ? 1 : 0,
      'is_recruiter': isRecruiter ? 1 : 0,
      'imported_from': importedFrom,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  String get fullName => '$firstName $lastName';
}
