import '../models/note.dart';
import '../services/database_service.dart';

class NoteRepository {
  final DatabaseService _db = DatabaseService.instance;

  /// Get all notes for a profile
  Future<List<ProfileNote>> getNotesForProfile(
    String profileId,
    String profileType,
  ) async {
    final results = await _db.query(
      'profile_notes',
      where: 'profile_id = ? AND profile_type = ? AND is_deleted = 0',
      whereArgs: [profileId, profileType],
      orderBy: 'is_pinned DESC, updated_at DESC',
    );

    return results.map((map) => ProfileNote.fromDb(map)).toList();
  }

  /// Get a note by ID
  Future<ProfileNote?> getNote(int id) async {
    final results = await _db.query(
      'profile_notes',
      where: 'id = ? AND is_deleted = 0',
      whereArgs: [id],
      limit: 1,
    );

    if (results.isEmpty) return null;
    return ProfileNote.fromDb(results.first);
  }

  /// Insert a new note
  Future<int> insertNote(ProfileNote note) async {
    return await _db.insert('profile_notes', note.toDb());
  }

  /// Update a note
  Future<int> updateNote(ProfileNote note) async {
    final updateData = note.toDb();
    // Set updated_at to current time
    updateData['updated_at'] = DateTime.now().toIso8601String();

    return await _db.update(
      'profile_notes',
      updateData,
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  /// Soft delete a note
  Future<int> deleteNote(int id) async {
    return await _db.update(
      'profile_notes',
      {
        'is_deleted': 1,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Hard delete a note (permanent)
  Future<int> hardDeleteNote(int id) async {
    return await _db.delete(
      'profile_notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Toggle pin status
  Future<int> togglePin(int id) async {
    final note = await getNote(id);
    if (note == null) return 0;

    return await _db.update(
      'profile_notes',
      {
        'is_pinned': note.isPinned ? 0 : 1,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Search notes using FTS5
  Future<List<ProfileNote>> searchNotes(String query) async {
    final results = await _db.rawQuery('''
      SELECT pn.*
      FROM profile_notes pn
      JOIN profile_notes_fts fts ON pn.id = fts.rowid
      WHERE profile_notes_fts MATCH ?
        AND pn.is_deleted = 0
      ORDER BY pn.updated_at DESC
      LIMIT 50
    ''', [query]);

    return results.map((map) => ProfileNote.fromDb(map)).toList();
  }

  /// Get enriched notes with profile info (uses view)
  Future<List<Map<String, dynamic>>> getEnrichedNotes({
    int? limit = 50,
    int? offset = 0,
    String? profileId,
    String? profileType,
    NoteType? noteType,
    bool? pinnedOnly,
  }) async {
    String where = '1=1';
    List<Object?> whereArgs = [];

    if (profileId != null) {
      where += ' AND profile_id = ?';
      whereArgs.add(profileId);
    }

    if (profileType != null) {
      where += ' AND profile_type = ?';
      whereArgs.add(profileType);
    }

    if (noteType != null) {
      where += ' AND note_type = ?';
      whereArgs.add(noteType.toString().split('.').last);
    }

    if (pinnedOnly == true) {
      where += ' AND is_pinned = 1';
    }

    final results = await _db.query(
      'v_profile_notes_enriched',
      where: where,
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
      orderBy: 'is_pinned DESC, updated_at DESC',
      limit: limit,
      offset: offset,
    );

    return results;
  }

  /// Get recent notes across all profiles
  Future<List<Map<String, dynamic>>> getRecentNotes({int limit = 20}) async {
    return await _db.query(
      'v_profile_notes_enriched',
      orderBy: 'updated_at DESC',
      limit: limit,
    );
  }

  /// Get pinned notes
  Future<List<ProfileNote>> getPinnedNotes() async {
    final results = await _db.query(
      'profile_notes',
      where: 'is_pinned = 1 AND is_deleted = 0',
      orderBy: 'updated_at DESC',
    );

    return results.map((map) => ProfileNote.fromDb(map)).toList();
  }

  /// Get notes by type
  Future<List<ProfileNote>> getNotesByType(NoteType type) async {
    String noteTypeStr;
    switch (type) {
      case NoteType.meeting:
        noteTypeStr = 'meeting';
        break;
      case NoteType.research:
        noteTypeStr = 'research';
        break;
      case NoteType.followUp:
        noteTypeStr = 'follow_up';
        break;
      case NoteType.personal:
        noteTypeStr = 'personal';
        break;
      default:
        noteTypeStr = 'general';
    }

    final results = await _db.query(
      'profile_notes',
      where: 'note_type = ? AND is_deleted = 0',
      whereArgs: [noteTypeStr],
      orderBy: 'updated_at DESC',
    );

    return results.map((map) => ProfileNote.fromDb(map)).toList();
  }

  /// Get notes count for a profile
  Future<int> getNotesCount(String profileId, String profileType) async {
    final result = await _db.rawQuery('''
      SELECT COUNT(*) as count
      FROM profile_notes
      WHERE profile_id = ?
        AND profile_type = ?
        AND is_deleted = 0
    ''', [profileId, profileType]);

    return result.first['count'] as int;
  }

  /// Batch insert notes
  Future<void> batchInsertNotes(List<ProfileNote> notes) async {
    await _db.transaction((txn) async {
      for (final note in notes) {
        await txn.insert('profile_notes', note.toDb());
      }
    });
  }
}
