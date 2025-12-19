import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  /// Get database instance, initialize if needed
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  /// Initialize database - copy from assets if first launch, run migrations
  Future<Database> _initDB() async {
    final Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, 'myNET.db');

    // Check if database exists
    final bool exists = await databaseExists(path);

    if (!exists) {
      // Create directory if it doesn't exist
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy database from assets
      ByteData data = await rootBundle.load('assets/database/myNET.db');
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }

    // Open database
    final db = await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onConfigure: _onConfigure,
      onOpen: _onOpen,
    );

    return db;
  }

  /// Configure database settings
  Future<void> _onConfigure(Database db) async {
    // Enable foreign keys
    await db.execute('PRAGMA foreign_keys = ON');
    // Enable WAL mode for better concurrency
    await db.execute('PRAGMA journal_mode = WAL');
    // Set cache size (in KB)
    await db.execute('PRAGMA cache_size = -32000'); // 32MB
    // Set temp store in memory
    await db.execute('PRAGMA temp_store = MEMORY');
  }

  /// Called when database is first created (for testing/fresh installs)
  Future<void> _createDB(Database db, int version) async {
    // Schema already exists in the database file from assets
    // This is only called for testing scenarios when database doesn't exist
    // In production, the database is copied from assets and already has schema
  }

  /// Called when database is opened - run migrations if needed
  Future<void> _onOpen(Database db) async {

    // Check if migrations table exists
    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='schema_migrations'",
    );

    if (tables.isEmpty) {
      // First time opening - run schema extensions migration
      await _runMigrations(db);
    } else {
      // Check current schema version
      final result = await db.query(
        'schema_migrations',
        where: 'version = ?',
        whereArgs: ['1.0.0'],
      );

      if (result.isEmpty) {
        // Migration not applied yet
        await _runMigrations(db);
      }
    }
  }

  /// Run database migrations from schema_extensions.sql
  Future<void> _runMigrations(Database db) async {

    try {
      // Load migration SQL from assets
      final String migrationSql = await rootBundle.loadString(
        'assets/database/schema_extensions.sql',
      );

      // Split by statement (simple approach - assumes ; at end of each statement)
      // Note: This is a simplified version. For production, consider a more robust SQL parser
      final List<String> statements = migrationSql
          .split(';')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty && !s.startsWith('--'))
          .toList();

      // Execute each statement in a transaction
      await db.transaction((txn) async {
        for (final statement in statements) {
          if (statement.trim().isNotEmpty) {
            try {
              await txn.execute(statement);
            } catch (e) {
              // Ignore IF NOT EXISTS errors and continue
              if (!e.toString().contains('already exists')) {
                rethrow;
              }
            }
          }
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  /// Close database connection
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }

  /// Execute raw query
  Future<List<Map<String, dynamic>>> rawQuery(
    String sql, [
    List<Object?>? arguments,
  ]) async {
    final db = await database;
    return await db.rawQuery(sql, arguments);
  }

  /// Execute raw insert/update/delete
  Future<int> rawExecute(String sql, [List<Object?>? arguments]) async {
    final db = await database;
    return await db.rawUpdate(sql, arguments);
  }

  /// Insert record
  Future<int> insert(
    String table,
    Map<String, dynamic> values, {
    ConflictAlgorithm? conflictAlgorithm,
  }) async {
    final db = await database;
    return await db.insert(table, values, conflictAlgorithm: conflictAlgorithm);
  }

  /// Update record
  Future<int> update(
    String table,
    Map<String, dynamic> values, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final db = await database;
    return await db.update(table, values, where: where, whereArgs: whereArgs);
  }

  /// Delete record
  Future<int> delete(
    String table, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final db = await database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }

  /// Query records
  Future<List<Map<String, dynamic>>> query(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final db = await database;
    return await db.query(
      table,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  /// Run in transaction
  Future<T> transaction<T>(Future<T> Function(Transaction txn) action) async {
    final db = await database;
    return await db.transaction(action);
  }

  /// Batch operations
  Future<List<Object?>> batch(
    Function(Batch batch) operations, {
    bool? exclusive,
    bool? noResult,
    bool? continueOnError,
  }) async {
    final db = await database;
    final batch = db.batch();
    operations(batch);
    return await batch.commit(
      exclusive: exclusive,
      noResult: noResult,
      continueOnError: continueOnError,
    );
  }

  /// Get database statistics
  Future<Map<String, int>> getStats() async {
    final db = await database;

    final stats = <String, int>{};

    // Count profiles
    stats['linkedin_profiles'] = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM linkedin_profiles WHERE is_active = 1'),
        ) ??
        0;

    stats['booth_profiles'] = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM booth_profiles WHERE is_active = 1'),
        ) ??
        0;

    stats['connections'] = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM connections'),
        ) ??
        0;

    // Count annotations
    stats['notes'] = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM profile_notes WHERE is_deleted = 0'),
        ) ??
        0;

    stats['interactions'] = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM profile_interactions WHERE is_deleted = 0'),
        ) ??
        0;

    stats['tags'] = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM tags'),
        ) ??
        0;

    // Pending follow-ups
    stats['pending_follow_ups'] = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM v_follow_ups_pending'),
        ) ??
        0;

    return stats;
  }

  /// Run database integrity check
  Future<bool> checkIntegrity() async {
    final db = await database;
    final result = await db.rawQuery('PRAGMA integrity_check');
    return result.isNotEmpty && result.first['integrity_check'] == 'ok';
  }

  /// Optimize database (VACUUM and ANALYZE)
  Future<void> optimize() async {
    final db = await database;
    await db.execute('VACUUM');
    await db.execute('ANALYZE');
  }

  /// Get database file size in bytes
  Future<int> getDatabaseSize() async {
    final Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, 'myNET.db');
    final file = File(path);
    if (await file.exists()) {
      return await file.length();
    }
    return 0;
  }

  /// Export database to file
  Future<String> exportDatabase(String targetPath) async {
    final Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String sourcePath = join(documentsDirectory.path, 'myNET.db');
    final sourceFile = File(sourcePath);

    await sourceFile.copy(targetPath);
    return targetPath;
  }
}
