import 'package:sqflite/sqflite.dart';
import '../models/profile.dart';
import '../models/experience.dart';
import '../models/education.dart';
import '../models/skill.dart';
import '../models/connection.dart';
import '../services/database_service.dart';

class ProfileRepository {
  final DatabaseService _db = DatabaseService.instance;

  // ==================== LinkedIn Profiles ====================

  /// Get all LinkedIn profiles with pagination
  Future<List<LinkedInProfile>> getLinkedInProfiles({
    int? limit = 50,
    int? offset = 0,
    String? search,
    String? company,
    String? location,
  }) async {
    String where = 'is_active = 1';
    List<Object?> whereArgs = [];

    if (search != null && search.isNotEmpty) {
      where += ' AND full_name LIKE ?';
      whereArgs.add('%$search%');
    }

    if (company != null && company.isNotEmpty) {
      where += ' AND current_company LIKE ?';
      whereArgs.add('%$company%');
    }

    if (location != null && location.isNotEmpty) {
      where += ' AND location LIKE ?';
      whereArgs.add('%$location%');
    }

    final results = await _db.query(
      'linkedin_profiles',
      where: where,
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
      orderBy: 'full_name ASC',
      limit: limit,
      offset: offset,
    );

    return results.map((map) => LinkedInProfile.fromDb(map)).toList();
  }

  /// Get LinkedIn profile by ID
  Future<LinkedInProfile?> getLinkedInProfile(String profileId) async {
    final results = await _db.query(
      'linkedin_profiles',
      where: 'profile_id = ?',
      whereArgs: [profileId],
      limit: 1,
    );

    if (results.isEmpty) return null;
    return LinkedInProfile.fromDb(results.first);
  }

  /// Insert or update LinkedIn profile
  Future<int> upsertLinkedInProfile(LinkedInProfile profile) async {
    return await _db.insert(
      'linkedin_profiles',
      profile.toDb(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Search LinkedIn profiles (full-text if available, otherwise LIKE)
  Future<List<LinkedInProfile>> searchLinkedInProfiles(String query) async {
    final results = await _db.rawQuery('''
      SELECT * FROM linkedin_profiles
      WHERE is_active = 1
        AND (full_name LIKE ?
             OR headline LIKE ?
             OR current_company LIKE ?
             OR location LIKE ?)
      ORDER BY full_name ASC
      LIMIT 50
    ''', ['%$query%', '%$query%', '%$query%', '%$query%']);

    return results.map((map) => LinkedInProfile.fromDb(map)).toList();
  }

  // ==================== Work Experience ====================

  /// Get experiences for a profile
  Future<List<WorkExperience>> getExperiences(String profileId) async {
    final results = await _db.query(
      'linkedin_experiences',
      where: 'profile_id = ?',
      whereArgs: [profileId],
      orderBy: 'order_index ASC, start_date DESC',
    );

    return results.map((map) => WorkExperience.fromDb(map)).toList();
  }

  /// Insert experience
  Future<int> insertExperience(WorkExperience experience) async {
    return await _db.insert('linkedin_experiences', experience.toDb());
  }

  /// Update experience
  Future<int> updateExperience(WorkExperience experience) async {
    return await _db.update(
      'linkedin_experiences',
      experience.toDb(),
      where: 'experience_id = ?',
      whereArgs: [experience.experienceId],
    );
  }

  /// Delete experience
  Future<int> deleteExperience(int experienceId) async {
    return await _db.delete(
      'linkedin_experiences',
      where: 'experience_id = ?',
      whereArgs: [experienceId],
    );
  }

  // ==================== Education ====================

  /// Get education for a profile
  Future<List<Education>> getEducation(String profileId) async {
    final results = await _db.query(
      'linkedin_education',
      where: 'profile_id = ?',
      whereArgs: [profileId],
      orderBy: 'order_index ASC, end_year DESC',
    );

    return results.map((map) => Education.fromDb(map)).toList();
  }

  /// Insert education
  Future<int> insertEducation(Education education) async {
    return await _db.insert('linkedin_education', education.toDb());
  }

  /// Update education
  Future<int> updateEducation(Education education) async {
    return await _db.update(
      'linkedin_education',
      education.toDb(),
      where: 'education_id = ?',
      whereArgs: [education.educationId],
    );
  }

  /// Delete education
  Future<int> deleteEducation(int educationId) async {
    return await _db.delete(
      'linkedin_education',
      where: 'education_id = ?',
      whereArgs: [educationId],
    );
  }

  // ==================== Skills ====================

  /// Get skills for a profile
  Future<List<Skill>> getSkills(String profileId) async {
    final results = await _db.query(
      'linkedin_skills',
      where: 'profile_id = ?',
      whereArgs: [profileId],
      orderBy: 'is_top_skill DESC, endorsement_count DESC',
    );

    return results.map((map) => Skill.fromDb(map)).toList();
  }

  /// Insert skill
  Future<int> insertSkill(Skill skill) async {
    return await _db.insert('linkedin_skills', skill.toDb());
  }

  /// Update skill
  Future<int> updateSkill(Skill skill) async {
    return await _db.update(
      'linkedin_skills',
      skill.toDb(),
      where: 'skill_id = ?',
      whereArgs: [skill.skillId],
    );
  }

  /// Delete skill
  Future<int> deleteSkill(int skillId) async {
    return await _db.delete(
      'linkedin_skills',
      where: 'skill_id = ?',
      whereArgs: [skillId],
    );
  }

  // ==================== Connections ====================

  /// Get all connections with pagination
  Future<List<Connection>> getConnections({
    int? limit = 50,
    int? offset = 0,
    String? search,
    String? company,
    bool? isRecruiter,
  }) async {
    String where = '1=1';
    List<Object?> whereArgs = [];

    if (search != null && search.isNotEmpty) {
      where += ' AND (first_name LIKE ? OR last_name LIKE ?)';
      whereArgs.add('%$search%');
      whereArgs.add('%$search%');
    }

    if (company != null && company.isNotEmpty) {
      where += ' AND company LIKE ?';
      whereArgs.add('%$company%');
    }

    if (isRecruiter != null) {
      where += ' AND is_recruiter = ?';
      whereArgs.add(isRecruiter ? 1 : 0);
    }

    final results = await _db.query(
      'connections',
      where: where,
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
      orderBy: 'last_name ASC, first_name ASC',
      limit: limit,
      offset: offset,
    );

    return results.map((map) => Connection.fromDb(map)).toList();
  }

  /// Get connection by ID
  Future<Connection?> getConnection(int id) async {
    final results = await _db.query(
      'connections',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (results.isEmpty) return null;
    return Connection.fromDb(results.first);
  }

  /// Insert connection
  Future<int> insertConnection(Connection connection) async {
    return await _db.insert('connections', connection.toDb());
  }

  /// Update connection
  Future<int> updateConnection(Connection connection) async {
    return await _db.update(
      'connections',
      connection.toDb(),
      where: 'id = ?',
      whereArgs: [connection.id],
    );
  }

  /// Delete connection
  Future<int> deleteConnection(int id) async {
    return await _db.delete(
      'connections',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ==================== Profile Summary ====================

  /// Get profile summary with annotations (uses view)
  Future<List<Map<String, dynamic>>> getProfileSummaries({
    int? limit = 50,
    int? offset = 0,
    String? search,
    bool? hasNotes,
    bool? hasInteractions,
    bool? hasPendingFollowUp,
  }) async {
    String where = '1=1';
    List<Object?> whereArgs = [];

    if (search != null && search.isNotEmpty) {
      where += ' AND full_name LIKE ?';
      whereArgs.add('%$search%');
    }

    if (hasNotes == true) {
      where += ' AND notes_count > 0';
    }

    if (hasInteractions == true) {
      where += ' AND interactions_count > 0';
    }

    if (hasPendingFollowUp == true) {
      where += ' AND has_pending_follow_up = 1';
    }

    final results = await _db.query(
      'v_profile_summary',
      where: where,
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
      orderBy: 'last_interaction_date DESC NULLS LAST, full_name ASC',
      limit: limit,
      offset: offset,
    );

    return results;
  }

  /// Get profile summary by ID and type
  Future<Map<String, dynamic>?> getProfileSummary(
    String profileId,
    String profileType,
  ) async {
    final results = await _db.query(
      'v_profile_summary',
      where: 'profile_id = ? AND profile_type = ?',
      whereArgs: [profileId, profileType],
      limit: 1,
    );

    if (results.isEmpty) return null;
    return results.first;
  }

  // ==================== Company Analysis ====================

  /// Get profiles by company
  Future<List<LinkedInProfile>> getProfilesByCompany(String company) async {
    final results = await _db.query(
      'linkedin_profiles',
      where: 'current_company LIKE ? AND is_active = 1',
      whereArgs: ['%$company%'],
      orderBy: 'full_name ASC',
    );

    return results.map((map) => LinkedInProfile.fromDb(map)).toList();
  }

  /// Get top companies by profile count
  Future<List<Map<String, dynamic>>> getTopCompaniesByProfileCount({int limit = 10}) async {
    return await _db.rawQuery('''
      SELECT current_company as company, COUNT(*) as profile_count
      FROM linkedin_profiles
      WHERE current_company IS NOT NULL
        AND current_company != ''
        AND is_active = 1
      GROUP BY current_company
      ORDER BY profile_count DESC
      LIMIT ?
    ''', [limit]);
  }
}
