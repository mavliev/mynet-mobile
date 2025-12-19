import 'package:sqflite/sqflite.dart';
import '../models/tag.dart';
import '../services/database_service.dart';

class TagRepository {
  final DatabaseService _db = DatabaseService.instance;

  // ==================== Tags ====================

  /// Get all tags
  Future<List<ProfileTag>> getAllTags({
    String? category,
    int? minUsage,
  }) async {
    String where = '1=1';
    List<Object?> whereArgs = [];

    if (category != null) {
      where += ' AND tag_category = ?';
      whereArgs.add(category);
    }

    if (minUsage != null) {
      where += ' AND usage_count >= ?';
      whereArgs.add(minUsage);
    }

    final results = await _db.query(
      'tags',
      where: where,
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
      orderBy: 'usage_count DESC, tag_name ASC',
    );

    return results.map((map) => ProfileTag.fromDb(map)).toList();
  }

  /// Get tag by ID
  Future<ProfileTag?> getTag(int id) async {
    final results = await _db.query(
      'tags',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (results.isEmpty) return null;
    return ProfileTag.fromDb(results.first);
  }

  /// Get tag by name
  Future<ProfileTag?> getTagByName(String name) async {
    final results = await _db.query(
      'tags',
      where: 'tag_name = ?',
      whereArgs: [name],
      limit: 1,
    );

    if (results.isEmpty) return null;
    return ProfileTag.fromDb(results.first);
  }

  /// Create tag (or return existing if name already exists)
  Future<ProfileTag> createTag({
    required String tagName,
    String? tagCategory,
    String? tagColor,
    bool isSystemTag = false,
  }) async {
    // Check if tag already exists
    final existing = await getTagByName(tagName);
    if (existing != null) {
      return existing;
    }

    // Create new tag
    final now = DateTime.now();
    final tagData = {
      'tag_name': tagName,
      'tag_category': tagCategory,
      'tag_color': tagColor,
      'usage_count': 0,
      'created_at': now.toIso8601String(),
      'updated_at': now.toIso8601String(),
      'is_system_tag': isSystemTag ? 1 : 0,
    };

    final id = await _db.insert('tags', tagData);

    return ProfileTag(
      id: id,
      tagName: tagName,
      tagCategory: tagCategory,
      tagColor: tagColor,
      usageCount: 0,
      createdAt: now,
      updatedAt: now,
      isSystemTag: isSystemTag,
    );
  }

  /// Update tag
  Future<int> updateTag(ProfileTag tag) async {
    final updateData = tag.toDb();
    updateData['updated_at'] = DateTime.now().toIso8601String();

    return await _db.update(
      'tags',
      updateData,
      where: 'id = ?',
      whereArgs: [tag.id],
    );
  }

  /// Delete tag
  Future<int> deleteTag(int id) async {
    // This will cascade delete all profile_tags associations
    return await _db.delete(
      'tags',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ==================== Profile Tag Associations ====================

  /// Get tags for a profile
  Future<List<ProfileTag>> getTagsForProfile(
    String profileId,
    String profileType,
  ) async {
    final results = await _db.rawQuery('''
      SELECT t.*
      FROM tags t
      JOIN profile_tags pt ON t.id = pt.tag_id
      WHERE pt.profile_id = ?
        AND pt.profile_type = ?
        AND pt.is_deleted = 0
      ORDER BY t.tag_name ASC
    ''', [profileId, profileType]);

    return results.map((map) => ProfileTag.fromDb(map)).toList();
  }

  /// Get profiles with a specific tag
  Future<List<Map<String, dynamic>>> getProfilesWithTag(
    int tagId, {
    String? profileType,
    int? limit = 50,
  }) async {
    String where = 'pt.tag_id = ? AND pt.is_deleted = 0';
    List<Object?> whereArgs = [tagId];

    if (profileType != null) {
      where += ' AND pt.profile_type = ?';
      whereArgs.add(profileType);
    }

    final results = await _db.rawQuery('''
      SELECT
        pt.profile_id,
        pt.profile_type,
        pt.tagged_at,
        ps.full_name,
        ps.headline,
        ps.current_company,
        ps.location,
        ps.photo_url
      FROM profile_tags pt
      LEFT JOIN v_profile_summary ps
        ON pt.profile_id = ps.profile_id
        AND pt.profile_type = ps.profile_type
      WHERE $where
      ORDER BY pt.tagged_at DESC
      LIMIT ?
    ''', [...whereArgs, limit]);

    return results;
  }

  /// Add tag to profile
  Future<int> addTagToProfile({
    required String profileId,
    required String profileType,
    required int tagId,
    String? taggedBy,
  }) async {
    // Check if association already exists
    final existing = await _db.query(
      'profile_tags',
      where: 'profile_id = ? AND profile_type = ? AND tag_id = ?',
      whereArgs: [profileId, profileType, tagId],
      limit: 1,
    );

    if (existing.isNotEmpty) {
      // If it was soft deleted, restore it
      if ((existing.first['is_deleted'] as int) == 1) {
        return await _db.update(
          'profile_tags',
          {
            'is_deleted': 0,
            'tagged_at': DateTime.now().toIso8601String(),
          },
          where: 'id = ?',
          whereArgs: [existing.first['id']],
        );
      }
      // Already exists and not deleted
      return existing.first['id'] as int;
    }

    // Create new association
    return await _db.insert('profile_tags', {
      'profile_id': profileId,
      'profile_type': profileType,
      'tag_id': tagId,
      'tagged_by': taggedBy,
      'tagged_at': DateTime.now().toIso8601String(),
      'is_deleted': 0,
    });
  }

  /// Remove tag from profile (soft delete)
  Future<int> removeTagFromProfile({
    required String profileId,
    required String profileType,
    required int tagId,
  }) async {
    return await _db.update(
      'profile_tags',
      {'is_deleted': 1},
      where: 'profile_id = ? AND profile_type = ? AND tag_id = ?',
      whereArgs: [profileId, profileType, tagId],
    );
  }

  /// Get tag cloud (uses view)
  Future<List<Map<String, dynamic>>> getTagCloud({
    int? minUsage = 1,
    int? limit = 50,
  }) async {
    String where = '1=1';
    List<Object?> whereArgs = [];

    if (minUsage != null) {
      where += ' AND usage_count >= ?';
      whereArgs.add(minUsage);
    }

    final results = await _db.query(
      'v_tag_cloud',
      where: where,
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
      orderBy: 'usage_count DESC',
      limit: limit,
    );

    return results;
  }

  /// Search tags by name
  Future<List<ProfileTag>> searchTags(String query) async {
    final results = await _db.query(
      'tags',
      where: 'tag_name LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: 'usage_count DESC, tag_name ASC',
      limit: 20,
    );

    return results.map((map) => ProfileTag.fromDb(map)).toList();
  }

  /// Get tags by category
  Future<List<ProfileTag>> getTagsByCategory(String category) async {
    final results = await _db.query(
      'tags',
      where: 'tag_category = ?',
      whereArgs: [category],
      orderBy: 'tag_name ASC',
    );

    return results.map((map) => ProfileTag.fromDb(map)).toList();
  }

  /// Get tag categories
  Future<List<String>> getTagCategories() async {
    final results = await _db.rawQuery('''
      SELECT DISTINCT tag_category
      FROM tags
      WHERE tag_category IS NOT NULL
      ORDER BY tag_category ASC
    ''');

    return results
        .map((row) => row['tag_category'] as String)
        .where((category) => category.isNotEmpty)
        .toList();
  }

  /// Get popular tags (most used)
  Future<List<ProfileTag>> getPopularTags({int limit = 10}) async {
    final results = await _db.query(
      'tags',
      where: 'usage_count > 0',
      orderBy: 'usage_count DESC',
      limit: limit,
    );

    return results.map((map) => ProfileTag.fromDb(map)).toList();
  }

  /// Batch add tags to profile
  Future<void> batchAddTagsToProfile({
    required String profileId,
    required String profileType,
    required List<int> tagIds,
    String? taggedBy,
  }) async {
    await _db.transaction((txn) async {
      for (final tagId in tagIds) {
        // Check if exists
        final existing = await txn.query(
          'profile_tags',
          where: 'profile_id = ? AND profile_type = ? AND tag_id = ?',
          whereArgs: [profileId, profileType, tagId],
          limit: 1,
        );

        if (existing.isEmpty) {
          await txn.insert('profile_tags', {
            'profile_id': profileId,
            'profile_type': profileType,
            'tag_id': tagId,
            'tagged_by': taggedBy,
            'tagged_at': DateTime.now().toIso8601String(),
            'is_deleted': 0,
          });
        }
      }
    });
  }

  /// Get tags count for a profile
  Future<int> getTagsCount(String profileId, String profileType) async {
    final result = await _db.rawQuery('''
      SELECT COUNT(*) as count
      FROM profile_tags
      WHERE profile_id = ?
        AND profile_type = ?
        AND is_deleted = 0
    ''', [profileId, profileType]);

    return result.first['count'] as int;
  }
}
