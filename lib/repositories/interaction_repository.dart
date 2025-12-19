import '../models/interaction.dart';
import '../services/database_service.dart';

class InteractionRepository {
  final DatabaseService _db = DatabaseService.instance;

  /// Get all interactions for a profile
  Future<List<ProfileInteraction>> getInteractionsForProfile(
    String profileId,
    String profileType,
  ) async {
    final results = await _db.query(
      'profile_interactions',
      where: 'profile_id = ? AND profile_type = ? AND is_deleted = 0',
      whereArgs: [profileId, profileType],
      orderBy: 'interaction_date DESC',
    );

    return results.map((map) => ProfileInteraction.fromDb(map)).toList();
  }

  /// Get an interaction by ID
  Future<ProfileInteraction?> getInteraction(int id) async {
    final results = await _db.query(
      'profile_interactions',
      where: 'id = ? AND is_deleted = 0',
      whereArgs: [id],
      limit: 1,
    );

    if (results.isEmpty) return null;
    return ProfileInteraction.fromDb(results.first);
  }

  /// Insert a new interaction
  Future<int> insertInteraction(ProfileInteraction interaction) async {
    return await _db.insert('profile_interactions', interaction.toDb());
  }

  /// Update an interaction
  Future<int> updateInteraction(ProfileInteraction interaction) async {
    final updateData = interaction.toDb();
    // Set updated_at to current time
    updateData['updated_at'] = DateTime.now().toIso8601String();

    return await _db.update(
      'profile_interactions',
      updateData,
      where: 'id = ?',
      whereArgs: [interaction.id],
    );
  }

  /// Soft delete an interaction
  Future<int> deleteInteraction(int id) async {
    return await _db.update(
      'profile_interactions',
      {
        'is_deleted': 1,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Mark follow-up as completed
  Future<int> completeFollowUp(int id) async {
    return await _db.update(
      'profile_interactions',
      {
        'follow_up_completed': 1,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Get recent interactions (uses view)
  Future<List<Map<String, dynamic>>> getRecentInteractions({
    int? limit = 50,
    String? profileId,
    String? profileType,
  }) async {
    String where = '1=1';
    List<Object?> whereArgs = [];

    if (profileId != null && profileType != null) {
      where += ' AND profile_id = ? AND profile_type = ?';
      whereArgs.add(profileId);
      whereArgs.add(profileType);
    }

    final results = await _db.query(
      'v_recent_interactions',
      where: where,
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
      limit: limit,
    );

    return results;
  }

  /// Get pending follow-ups (uses view)
  Future<List<Map<String, dynamic>>> getPendingFollowUps({
    bool overdueOnly = false,
  }) async {
    String where = '1=1';
    List<Object?> whereArgs = [];

    if (overdueOnly) {
      where += ' AND days_overdue > 0';
    }

    final results = await _db.query(
      'v_follow_ups_pending',
      where: where,
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
      orderBy: 'follow_up_date ASC',
    );

    return results;
  }

  /// Get interactions by type
  Future<List<ProfileInteraction>> getInteractionsByType(
    InteractionType type,
  ) async {
    String typeStr = _interactionTypeToString(type);

    final results = await _db.query(
      'profile_interactions',
      where: 'interaction_type = ? AND is_deleted = 0',
      whereArgs: [typeStr],
      orderBy: 'interaction_date DESC',
      limit: 50,
    );

    return results.map((map) => ProfileInteraction.fromDb(map)).toList();
  }

  /// Get important interactions
  Future<List<ProfileInteraction>> getImportantInteractions({
    int limit = 50,
  }) async {
    final results = await _db.query(
      'profile_interactions',
      where: 'is_important = 1 AND is_deleted = 0',
      whereArgs: [],
      orderBy: 'interaction_date DESC',
      limit: limit,
    );

    return results.map((map) => ProfileInteraction.fromDb(map)).toList();
  }

  /// Get interactions count for a profile
  Future<int> getInteractionsCount(String profileId, String profileType) async {
    final result = await _db.rawQuery('''
      SELECT COUNT(*) as count
      FROM profile_interactions
      WHERE profile_id = ?
        AND profile_type = ?
        AND is_deleted = 0
    ''', [profileId, profileType]);

    return result.first['count'] as int;
  }

  /// Get interactions by date range
  Future<List<ProfileInteraction>> getInteractionsByDateRange(
    DateTime startDate,
    DateTime endDate, {
    String? profileId,
    String? profileType,
  }) async {
    String where = 'interaction_date BETWEEN ? AND ? AND is_deleted = 0';
    List<Object?> whereArgs = [
      startDate.toIso8601String(),
      endDate.toIso8601String(),
    ];

    if (profileId != null && profileType != null) {
      where += ' AND profile_id = ? AND profile_type = ?';
      whereArgs.add(profileId);
      whereArgs.add(profileType);
    }

    final results = await _db.query(
      'profile_interactions',
      where: where,
      whereArgs: whereArgs,
      orderBy: 'interaction_date DESC',
    );

    return results.map((map) => ProfileInteraction.fromDb(map)).toList();
  }

  /// Get interaction statistics for a profile
  Future<Map<String, int>> getInteractionStats(
    String profileId,
    String profileType,
  ) async {
    final results = await _db.rawQuery('''
      SELECT
        interaction_type,
        COUNT(*) as count
      FROM profile_interactions
      WHERE profile_id = ?
        AND profile_type = ?
        AND is_deleted = 0
      GROUP BY interaction_type
    ''', [profileId, profileType]);

    final stats = <String, int>{};
    for (final row in results) {
      stats[row['interaction_type'] as String] = row['count'] as int;
    }

    return stats;
  }

  /// Batch insert interactions
  Future<void> batchInsertInteractions(
    List<ProfileInteraction> interactions,
  ) async {
    await _db.transaction((txn) async {
      for (final interaction in interactions) {
        await txn.insert('profile_interactions', interaction.toDb());
      }
    });
  }

  String _interactionTypeToString(InteractionType type) {
    switch (type) {
      case InteractionType.call:
        return 'call';
      case InteractionType.email:
        return 'email';
      case InteractionType.meeting:
        return 'meeting';
      case InteractionType.coffee:
        return 'coffee';
      case InteractionType.event:
        return 'event';
      case InteractionType.linkedinMessage:
        return 'linkedin_message';
      case InteractionType.text:
        return 'text';
      case InteractionType.introduction:
        return 'introduction';
      case InteractionType.referral:
        return 'referral';
      case InteractionType.other:
        return 'other';
    }
  }
}
