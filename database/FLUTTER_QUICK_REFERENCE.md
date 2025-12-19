# myNET Mobile - Flutter Quick Reference

## Database Schema Quick Reference for Flutter Developers

This guide provides ready-to-use code snippets for common database operations in the myNET mobile app.

---

## Database Setup

### pubspec.yaml Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.3.0
  path: ^1.8.3
  sqflite_common_ffi: ^2.3.0  # For desktop/testing
```

### Database Helper Singleton

```dart
// lib/database/db_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('myNET.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onConfigure: (db) async {
        // Enable foreign keys
        await db.execute('PRAGMA foreign_keys = ON');
        // Enable WAL mode for better concurrency
        await db.execute('PRAGMA journal_mode = WAL');
      },
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // Schema already exists in production DB
    // This onCreate is only for fresh installs/testing
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
```

---

## Profile Notes

### Insert Note

```dart
Future<int> insertNote({
  required String profileId,
  required String profileType, // 'linkedin' | 'booth' | 'connection'
  required String content,
  String? title,
  String noteType = 'general',
  bool isPinned = false,
  String? colorTag,
}) async {
  final db = await DatabaseHelper.instance.database;

  return await db.insert('profile_notes', {
    'profile_id': profileId,
    'profile_type': profileType,
    'title': title,
    'content': content,
    'note_type': noteType,
    'is_pinned': isPinned ? 1 : 0,
    'color_tag': colorTag,
  });
}
```

### Update Note

```dart
Future<int> updateNote(int noteId, {
  String? title,
  String? content,
  String? noteType,
  bool? isPinned,
  String? colorTag,
}) async {
  final db = await DatabaseHelper.instance.database;

  Map<String, dynamic> updates = {};
  if (title != null) updates['title'] = title;
  if (content != null) updates['content'] = content;
  if (noteType != null) updates['note_type'] = noteType;
  if (isPinned != null) updates['is_pinned'] = isPinned ? 1 : 0;
  if (colorTag != null) updates['color_tag'] = colorTag;

  // updated_at will be auto-updated by trigger

  return await db.update(
    'profile_notes',
    updates,
    where: 'id = ?',
    whereArgs: [noteId],
  );
}
```

### Get Notes for Profile

```dart
Future<List<Map<String, dynamic>>> getNotesForProfile(
  String profileId,
  String profileType,
) async {
  final db = await DatabaseHelper.instance.database;

  return await db.query(
    'profile_notes',
    where: 'profile_id = ? AND profile_type = ? AND is_deleted = 0',
    whereArgs: [profileId, profileType],
    orderBy: 'is_pinned DESC, updated_at DESC',
  );
}
```

### Search Notes (Full-Text)

```dart
Future<List<Map<String, dynamic>>> searchNotes(String query) async {
  final db = await DatabaseHelper.instance.database;

  return await db.rawQuery('''
    SELECT pn.*,
           COALESCE(lp.full_name, bp.full_name) as profile_name,
           COALESCE(lp.profile_photo_url, bp.photo_url) as photo_url
    FROM profile_notes pn
    JOIN profile_notes_fts fts ON pn.id = fts.rowid
    LEFT JOIN linkedin_profiles lp ON pn.profile_id = lp.profile_id AND pn.profile_type = 'linkedin'
    LEFT JOIN booth_profiles bp ON pn.profile_id = bp.booth_id AND pn.profile_type = 'booth'
    WHERE profile_notes_fts MATCH ?
      AND pn.is_deleted = 0
    ORDER BY pn.updated_at DESC
    LIMIT 50
  ''', [query]);
}
```

### Soft Delete Note

```dart
Future<int> deleteNote(int noteId) async {
  final db = await DatabaseHelper.instance.database;

  return await db.update(
    'profile_notes',
    {'is_deleted': 1},
    where: 'id = ?',
    whereArgs: [noteId],
  );
}
```

---

## Profile Interactions

### Insert Interaction

```dart
Future<int> insertInteraction({
  required String profileId,
  required String profileType,
  required String interactionType, // 'call' | 'email' | 'meeting' | etc.
  required DateTime interactionDate,
  String? subject,
  String? summary,
  String? outcome, // 'positive' | 'neutral' | 'negative' | 'follow_up_needed'
  DateTime? followUpDate,
  int? durationMinutes,
  String? location,
  bool isImportant = false,
}) async {
  final db = await DatabaseHelper.instance.database;

  return await db.insert('profile_interactions', {
    'profile_id': profileId,
    'profile_type': profileType,
    'interaction_type': interactionType,
    'interaction_date': interactionDate.toIso8601String(),
    'subject': subject,
    'summary': summary,
    'outcome': outcome,
    'follow_up_date': followUpDate?.toIso8601String(),
    'duration_minutes': durationMinutes,
    'location': location,
    'is_important': isImportant ? 1 : 0,
    'follow_up_completed': 0,
  });
}
```

### Get Recent Interactions

```dart
Future<List<Map<String, dynamic>>> getRecentInteractions({
  String? profileId,
  String? profileType,
  int limit = 50,
}) async {
  final db = await DatabaseHelper.instance.database;

  if (profileId != null && profileType != null) {
    return await db.query(
      'v_recent_interactions',
      where: 'profile_id = ? AND profile_type = ?',
      whereArgs: [profileId, profileType],
      limit: limit,
    );
  } else {
    return await db.query(
      'v_recent_interactions',
      limit: limit,
    );
  }
}
```

### Get Pending Follow-Ups

```dart
Future<List<Map<String, dynamic>>> getPendingFollowUps({
  bool overdueOnly = false,
}) async {
  final db = await DatabaseHelper.instance.database;

  if (overdueOnly) {
    return await db.query(
      'v_follow_ups_pending',
      where: 'days_overdue > 0',
      orderBy: 'days_overdue DESC',
    );
  } else {
    return await db.query('v_follow_ups_pending');
  }
}
```

### Mark Follow-Up as Completed

```dart
Future<int> completeFollowUp(int interactionId) async {
  final db = await DatabaseHelper.instance.database;

  return await db.update(
    'profile_interactions',
    {'follow_up_completed': 1},
    where: 'id = ?',
    whereArgs: [interactionId],
  );
}
```

---

## Tags

### Create Tag

```dart
Future<int> createTag({
  required String tagName,
  String? tagCategory,
  String? tagColor,
  bool isSystemTag = false,
}) async {
  final db = await DatabaseHelper.instance.database;

  try {
    return await db.insert('tags', {
      'tag_name': tagName,
      'tag_category': tagCategory,
      'tag_color': tagColor,
      'is_system_tag': isSystemTag ? 1 : 0,
    });
  } on DatabaseException catch (e) {
    if (e.isUniqueConstraintError()) {
      // Tag already exists, return existing ID
      final existing = await db.query(
        'tags',
        columns: ['id'],
        where: 'tag_name = ?',
        whereArgs: [tagName],
      );
      return existing.first['id'] as int;
    }
    rethrow;
  }
}
```

### Add Tag to Profile

```dart
Future<int> addTagToProfile({
  required String profileId,
  required String profileType,
  required int tagId,
}) async {
  final db = await DatabaseHelper.instance.database;

  try {
    return await db.insert('profile_tags', {
      'profile_id': profileId,
      'profile_type': profileType,
      'tag_id': tagId,
    });
  } on DatabaseException catch (e) {
    if (e.isUniqueConstraintError()) {
      // Tag already associated, ignore
      return 0;
    }
    rethrow;
  }
}
```

### Remove Tag from Profile

```dart
Future<int> removeTagFromProfile({
  required String profileId,
  required String profileType,
  required int tagId,
}) async {
  final db = await DatabaseHelper.instance.database;

  // Soft delete for sync
  return await db.update(
    'profile_tags',
    {'is_deleted': 1},
    where: 'profile_id = ? AND profile_type = ? AND tag_id = ?',
    whereArgs: [profileId, profileType, tagId],
  );
}
```

### Get Tags for Profile

```dart
Future<List<Map<String, dynamic>>> getTagsForProfile(
  String profileId,
  String profileType,
) async {
  final db = await DatabaseHelper.instance.database;

  return await db.rawQuery('''
    SELECT t.*
    FROM tags t
    JOIN profile_tags pt ON t.id = pt.tag_id
    WHERE pt.profile_id = ?
      AND pt.profile_type = ?
      AND pt.is_deleted = 0
    ORDER BY t.tag_name
  ''', [profileId, profileType]);
}
```

### Get Tag Cloud

```dart
Future<List<Map<String, dynamic>>> getTagCloud({int minUsage = 1}) async {
  final db = await DatabaseHelper.instance.database;

  return await db.query(
    'v_tag_cloud',
    where: 'usage_count >= ?',
    whereArgs: [minUsage],
    orderBy: 'usage_count DESC',
    limit: 50,
  );
}
```

---

## Profile Summary

### Get Profile with Annotations

```dart
Future<Map<String, dynamic>?> getProfileSummary(
  String profileId,
  String profileType,
) async {
  final db = await DatabaseHelper.instance.database;

  final result = await db.query(
    'v_profile_summary',
    where: 'profile_id = ? AND profile_type = ?',
    whereArgs: [profileId, profileType],
  );

  return result.isNotEmpty ? result.first : null;
}
```

### Search Profiles with Filters

```dart
Future<List<Map<String, dynamic>>> searchProfiles({
  String? nameQuery,
  String? company,
  String? location,
  List<int>? tagIds,
  bool hasNotes = false,
  bool hasInteractions = false,
  bool hasPendingFollowUp = false,
}) async {
  final db = await DatabaseHelper.instance.database;

  String where = '1=1';
  List<dynamic> whereArgs = [];

  if (nameQuery != null && nameQuery.isNotEmpty) {
    where += ' AND full_name LIKE ?';
    whereArgs.add('%$nameQuery%');
  }

  if (company != null && company.isNotEmpty) {
    where += ' AND current_company LIKE ?';
    whereArgs.add('%$company%');
  }

  if (location != null && location.isNotEmpty) {
    where += ' AND location LIKE ?';
    whereArgs.add('%$location%');
  }

  if (hasNotes) {
    where += ' AND notes_count > 0';
  }

  if (hasInteractions) {
    where += ' AND interactions_count > 0';
  }

  if (hasPendingFollowUp) {
    where += ' AND has_pending_follow_up = 1';
  }

  var query = 'SELECT * FROM v_profile_summary WHERE $where';

  // Filter by tags (if provided)
  if (tagIds != null && tagIds.isNotEmpty) {
    final tagPlaceholders = List.filled(tagIds.length, '?').join(',');
    query = '''
      SELECT DISTINCT ps.*
      FROM v_profile_summary ps
      JOIN profile_tags pt ON ps.profile_id = pt.profile_id
                           AND ps.profile_type = pt.profile_type
      WHERE pt.tag_id IN ($tagPlaceholders)
        AND pt.is_deleted = 0
        AND ($where)
    ''';
    whereArgs = [...tagIds, ...whereArgs];
  }

  return await db.rawQuery('$query ORDER BY full_name', whereArgs);
}
```

---

## App Metadata & Settings

### Get Setting

```dart
Future<String?> getSetting(String key) async {
  final db = await DatabaseHelper.instance.database;

  final result = await db.query(
    'app_metadata',
    columns: ['value'],
    where: 'key = ?',
    whereArgs: [key],
  );

  return result.isNotEmpty ? result.first['value'] as String? : null;
}
```

### Update Setting

```dart
Future<void> updateSetting(String key, String value) async {
  final db = await DatabaseHelper.instance.database;

  await db.insert(
    'app_metadata',
    {
      'key': key,
      'value': value,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
```

### Common Settings

```dart
// Dark mode
Future<bool> isDarkMode() async {
  final value = await getSetting('dark_mode');
  return value == 'true';
}

Future<void> setDarkMode(bool enabled) async {
  await updateSetting('dark_mode', enabled ? 'true' : 'false');
}

// Offline mode
Future<bool> isOfflineMode() async {
  final value = await getSetting('offline_mode');
  return value == 'true';
}

// Last sync timestamp
Future<DateTime?> getLastSync() async {
  final value = await getSetting('last_full_sync');
  return value != null ? DateTime.parse(value) : null;
}

Future<void> updateLastSync() async {
  await updateSetting('last_full_sync', DateTime.now().toIso8601String());
}
```

---

## Sync Queue

### Add to Sync Queue

```dart
Future<int> addToSyncQueue({
  required String tableName,
  required int recordId,
  required String operation, // 'insert' | 'update' | 'delete'
  int priority = 5,
}) async {
  final db = await DatabaseHelper.instance.database;

  return await db.insert('sync_queue', {
    'table_name': tableName,
    'record_id': recordId,
    'operation': operation,
    'priority': priority,
  });
}
```

### Get Pending Sync Items

```dart
Future<List<Map<String, dynamic>>> getPendingSyncItems({
  int limit = 100,
}) async {
  final db = await DatabaseHelper.instance.database;

  return await db.query(
    'sync_queue',
    where: 'status = ?',
    whereArgs: ['pending'],
    orderBy: 'priority DESC, created_at ASC',
    limit: limit,
  );
}
```

### Mark Sync Item as Completed

```dart
Future<int> markSyncCompleted(int syncId) async {
  final db = await DatabaseHelper.instance.database;

  return await db.update(
    'sync_queue',
    {
      'status': 'completed',
      'completed_at': DateTime.now().toIso8601String(),
    },
    where: 'id = ?',
    whereArgs: [syncId],
  );
}
```

### Get Sync Status

```dart
Future<Map<String, dynamic>> getSyncStatus() async {
  final db = await DatabaseHelper.instance.database;

  final result = await db.query('v_sync_status');
  return result.first;
}
```

---

## Activity Logging

### Log Profile View

```dart
Future<void> logProfileView(String profileId, String profileType) async {
  final db = await DatabaseHelper.instance.database;

  await db.insert('profile_activity_log', {
    'profile_id': profileId,
    'profile_type': profileType,
    'activity_type': 'viewed',
    'device_id': await getSetting('device_id'),
  });
}
```

### Log Search

```dart
Future<void> logSearch({
  required String query,
  required String searchType,
  int? resultsCount,
  String? selectedResultId,
}) async {
  final db = await DatabaseHelper.instance.database;

  await db.insert('search_history', {
    'search_query': query,
    'search_type': searchType,
    'results_count': resultsCount,
    'selected_result_id': selectedResultId,
    'device_id': await getSetting('device_id'),
  });
}
```

---

## Performance Tips

### Use Transactions for Bulk Operations

```dart
Future<void> importMultipleNotes(List<Map<String, dynamic>> notes) async {
  final db = await DatabaseHelper.instance.database;

  await db.transaction((txn) async {
    for (var note in notes) {
      await txn.insert('profile_notes', note);
    }
  });
}
```

### Use Raw Queries for Complex Joins

```dart
Future<List<Map<String, dynamic>>> getProfilesWithTagsAndNotes() async {
  final db = await DatabaseHelper.instance.database;

  return await db.rawQuery('''
    SELECT
      ps.*,
      GROUP_CONCAT(DISTINCT t.tag_name) as tags,
      COUNT(DISTINCT pn.id) as note_count
    FROM v_profile_summary ps
    LEFT JOIN profile_tags pt ON ps.profile_id = pt.profile_id
                              AND ps.profile_type = pt.profile_type
                              AND pt.is_deleted = 0
    LEFT JOIN tags t ON pt.tag_id = t.id
    LEFT JOIN profile_notes pn ON ps.profile_id = pn.profile_id
                               AND ps.profile_type = pn.profile_type
                               AND pn.is_deleted = 0
    GROUP BY ps.profile_id, ps.profile_type
    ORDER BY ps.last_interaction_date DESC NULLS LAST
    LIMIT 100
  ''');
}
```

### Use Streams for Real-Time Updates

```dart
import 'dart:async';

class NotesBloc {
  final _notesController = StreamController<List<Map<String, dynamic>>>.broadcast();

  Stream<List<Map<String, dynamic>>> get notesStream => _notesController.stream;

  Future<void> loadNotesForProfile(String profileId, String profileType) async {
    final notes = await getNotesForProfile(profileId, profileType);
    _notesController.add(notes);
  }

  void dispose() {
    _notesController.close();
  }
}
```

---

## Common Queries

### Dashboard Stats

```dart
Future<Map<String, int>> getDashboardStats() async {
  final db = await DatabaseHelper.instance.database;

  final stats = {
    'total_profiles': 0,
    'total_notes': 0,
    'total_interactions': 0,
    'pending_follow_ups': 0,
    'profiles_with_notes': 0,
  };

  // Total profiles
  final profileCount = await db.rawQuery('SELECT COUNT(*) as count FROM v_profile_summary');
  stats['total_profiles'] = profileCount.first['count'] as int;

  // Total notes
  final noteCount = await db.rawQuery('SELECT COUNT(*) as count FROM profile_notes WHERE is_deleted = 0');
  stats['total_notes'] = noteCount.first['count'] as int;

  // Total interactions
  final interactionCount = await db.rawQuery('SELECT COUNT(*) as count FROM profile_interactions WHERE is_deleted = 0');
  stats['total_interactions'] = interactionCount.first['count'] as int;

  // Pending follow-ups
  final followUpCount = await db.rawQuery('SELECT COUNT(*) as count FROM v_follow_ups_pending');
  stats['pending_follow_ups'] = followUpCount.first['count'] as int;

  // Profiles with notes
  final profilesWithNotes = await db.rawQuery('SELECT COUNT(*) as count FROM v_profile_summary WHERE notes_count > 0');
  stats['profiles_with_notes'] = profilesWithNotes.first['count'] as int;

  return stats;
}
```

---

## Error Handling

### Check for Unique Constraint Violations

```dart
extension DatabaseExceptionExtension on DatabaseException {
  bool isUniqueConstraintError() {
    return this.toString().contains('UNIQUE constraint failed');
  }

  bool isForeignKeyError() {
    return this.toString().contains('FOREIGN KEY constraint failed');
  }
}
```

### Safe Insert with Conflict Handling

```dart
Future<int> safeInsert(
  String table,
  Map<String, dynamic> values, {
  ConflictAlgorithm conflictAlgorithm = ConflictAlgorithm.abort,
}) async {
  final db = await DatabaseHelper.instance.database;

  try {
    return await db.insert(table, values, conflictAlgorithm: conflictAlgorithm);
  } on DatabaseException catch (e) {
    print('Database error inserting into $table: $e');
    rethrow;
  }
}
```

---

## Testing

### Mock Database for Unit Tests

```dart
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void setupTestDatabase() {
  // Initialize ffi
  sqfliteFfiInit();

  // Set global factory
  databaseFactory = databaseFactoryFfi;
}

Future<Database> createTestDatabase() async {
  setupTestDatabase();

  // Create in-memory database
  return await openDatabase(
    inMemoryDatabasePath,
    onCreate: (db, version) async {
      // Apply schema here
    },
  );
}
```

---

**Quick Reference Version:** 1.0.0
**Last Updated:** 2025-12-19
**Database Schema:** See `/Users/andrewmavliev/mynet-mobile/database/schema_extensions.sql`
