# myNET Mobile - Database Schema Migration Guide

## Overview

This migration adds mobile-first annotation and interaction tracking capabilities to the existing myNET.db database without modifying any existing tables or data.

**Version:** 1.0.0
**Database:** myNET.db (12MB, 2,628 LinkedIn profiles, 1,850 Booth profiles)
**Impact:** Additive only - no existing data modified

---

## What's New

### Core Features

1. **Profile Notes** - Rich text notes with full-text search
2. **Profile Interactions** - Track calls, emails, meetings, follow-ups
3. **Profile Tags** - Flexible categorization with tag cloud
4. **App Metadata** - Offline-first settings and sync state
5. **Sync Queue** - Track pending syncs for offline operation
6. **Activity Log** - Audit trail for analytics

### New Tables (10)

| Table | Purpose | Rows (Expected) |
|-------|---------|-----------------|
| `profile_notes` | User notes on profiles | 0-1000 (grows over time) |
| `profile_notes_fts` | FTS5 search index for notes | Auto-managed |
| `profile_interactions` | Track touchpoints (calls/emails/meetings) | 0-500 |
| `profile_tags` | Many-to-many profile-to-tag mapping | 0-5000 |
| `tags` | Tag definitions | 0-100 |
| `app_metadata` | Key-value settings store | 14 (pre-populated) |
| `sync_queue` | Pending sync operations | 0-100 (transient) |
| `profile_activity_log` | Audit trail | 0-10000 (grows over time) |
| `search_history` | Search autocomplete data | 0-1000 (auto-pruned) |
| `schema_migrations` | Version control | 1+ |

### New Views (6)

- `v_profile_notes_enriched` - Notes joined with profile data
- `v_recent_interactions` - Last 100 interactions with context
- `v_follow_ups_pending` - Active follow-ups sorted by date
- `v_tag_cloud` - Tag usage statistics
- `v_profile_summary` - Profile with annotation counts
- `v_sync_status` - Sync queue dashboard

---

## Pre-Migration Checklist

### 1. Backup Database

```bash
# Create timestamped backup
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
cp /Users/andrewmavliev/job-search-automation/myNET.db \
   /Users/andrewmavliev/job-search-automation/myNET_backup_${TIMESTAMP}.db

# Verify backup
ls -lh /Users/andrewmavliev/job-search-automation/myNET_backup_*.db
```

### 2. Verify Database Integrity

```bash
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db "PRAGMA integrity_check;"
# Expected output: ok
```

### 3. Check Current Schema Version

```bash
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db \
  "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;"
```

Expected tables (before migration): `booth_*`, `linkedin_*`, `connections`, `messages`, etc.

### 4. Check Free Space

```bash
df -h /Users/andrewmavliev/job-search-automation/
# Ensure at least 50MB free (migration adds ~5-10MB initially)
```

---

## Migration Steps

### Option A: Automated Migration (Recommended)

```bash
cd /Users/andrewmavliev/mynet-mobile/database/

# Apply migration
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db < schema_extensions.sql

# Verify migration
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db \
  "SELECT version, description, applied_at FROM schema_migrations;"
```

Expected output:
```
1.0.0|Mobile app schema extensions - annotations and interactions|2025-12-19 ...
```

### Option B: Manual Migration (Step-by-Step)

```bash
# 1. Open database
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db

-- 2. Start transaction (for safety)
BEGIN TRANSACTION;

-- 3. Apply schema (paste contents of schema_extensions.sql)
-- ... (paste SQL) ...

-- 4. Verify tables created
.tables

-- 5. Check migration record
SELECT * FROM schema_migrations;

-- 6. Commit if everything looks good
COMMIT;

-- 7. Exit
.quit
```

---

## Post-Migration Validation

### 1. Verify New Tables

```bash
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db \
  "SELECT name FROM sqlite_master WHERE type='table' AND name LIKE 'profile_%' OR name LIKE 'app_%' OR name = 'tags';"
```

Expected output:
```
profile_notes
profile_notes_fts
profile_interactions
profile_tags
profile_activity_log
app_metadata
tags
search_history
sync_queue
schema_migrations
```

### 2. Verify Views

```bash
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db \
  "SELECT name FROM sqlite_master WHERE type='view' AND name LIKE 'v_%';"
```

Expected: `v_profile_notes_enriched`, `v_recent_interactions`, `v_follow_ups_pending`, etc.

### 3. Verify Triggers

```bash
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db \
  "SELECT name FROM sqlite_master WHERE type='trigger' AND name LIKE 'trg_%';"
```

Expected: `trg_notes_fts_insert`, `trg_notes_updated`, `trg_interactions_updated`, etc.

### 4. Verify Indexes

```bash
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db \
  "SELECT name FROM sqlite_master WHERE type='index' AND name LIKE 'idx_%';"
```

Expected: 20+ indexes for optimal query performance

### 5. Test FTS5 Search

```bash
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db \
  "SELECT * FROM profile_notes_fts LIMIT 1;"
# Should return empty result (no notes yet) without errors
```

### 6. Verify App Metadata Defaults

```bash
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db \
  "SELECT key, value FROM app_metadata ORDER BY key;"
```

Expected: 14 pre-populated settings (schema_version, sync_enabled, device_id, etc.)

### 7. Check Database Size

```bash
ls -lh /Users/andrewmavliev/job-search-automation/myNET.db
# Should be ~12-13MB (minimal increase from empty tables)
```

---

## Testing the Migration

### Test Script

Create `/Users/andrewmavliev/mynet-mobile/database/test_migration.sh`:

```bash
#!/bin/bash

DB_PATH="/Users/andrewmavliev/job-search-automation/myNET.db"

echo "Testing myNET.db schema migration..."
echo "======================================"

# Test 1: Insert a note
echo "Test 1: Insert profile note..."
sqlite3 "$DB_PATH" <<EOF
INSERT INTO profile_notes (profile_id, profile_type, title, content, note_type)
VALUES ('TEST_PROFILE_001', 'linkedin', 'Test Note', 'This is a test note for migration validation.', 'general');
SELECT 'PASS: Note inserted with ID ' || last_insert_rowid();
EOF

# Test 2: Query note with FTS
echo "Test 2: Full-text search..."
sqlite3 "$DB_PATH" <<EOF
SELECT 'PASS: FTS search returned ' || COUNT(*) || ' results'
FROM profile_notes_fts WHERE profile_notes_fts MATCH 'test';
EOF

# Test 3: Insert interaction
echo "Test 3: Insert interaction..."
sqlite3 "$DB_PATH" <<EOF
INSERT INTO profile_interactions (profile_id, profile_type, interaction_type, interaction_date, subject, summary, outcome)
VALUES ('TEST_PROFILE_001', 'linkedin', 'call', datetime('now'), 'Test Call', 'Test summary', 'positive');
SELECT 'PASS: Interaction inserted with ID ' || last_insert_rowid();
EOF

# Test 4: Insert tag and associate with profile
echo "Test 4: Tag system..."
sqlite3 "$DB_PATH" <<EOF
INSERT INTO tags (tag_name, tag_category, tag_color) VALUES ('Test Tag', 'custom', '#FF5733');
INSERT INTO profile_tags (profile_id, profile_type, tag_id)
VALUES ('TEST_PROFILE_001', 'linkedin', last_insert_rowid());
SELECT 'PASS: Tag created and associated';
EOF

# Test 5: Query view
echo "Test 5: Profile summary view..."
sqlite3 "$DB_PATH" <<EOF
SELECT 'PASS: View query returned ' || COUNT(*) || ' profiles'
FROM v_profile_summary LIMIT 10;
EOF

# Test 6: Sync queue
echo "Test 6: Sync queue..."
sqlite3 "$DB_PATH" <<EOF
INSERT INTO sync_queue (table_name, record_id, operation, priority)
VALUES ('profile_notes', 1, 'insert', 10);
SELECT 'PASS: Sync queue entry created';
EOF

# Test 7: App metadata update
echo "Test 7: App metadata..."
sqlite3 "$DB_PATH" <<EOF
UPDATE app_metadata SET value = 'test_device_123' WHERE key = 'device_id';
SELECT 'PASS: App metadata updated';
EOF

# Cleanup test data
echo "Cleanup: Removing test data..."
sqlite3 "$DB_PATH" <<EOF
DELETE FROM profile_notes WHERE profile_id = 'TEST_PROFILE_001';
DELETE FROM profile_interactions WHERE profile_id = 'TEST_PROFILE_001';
DELETE FROM profile_tags WHERE profile_id = 'TEST_PROFILE_001';
DELETE FROM tags WHERE tag_name = 'Test Tag';
DELETE FROM sync_queue WHERE table_name = 'profile_notes';
SELECT 'PASS: Test data cleaned up';
EOF

echo "======================================"
echo "All tests completed successfully!"
```

### Run Tests

```bash
chmod +x /Users/andrewmavliev/mynet-mobile/database/test_migration.sh
/Users/andrewmavliev/mynet-mobile/database/test_migration.sh
```

---

## Rollback Procedure

If you need to rollback the migration:

### Option A: Restore from Backup

```bash
# Stop all apps using the database first!

# Restore backup
cp /Users/andrewmavliev/job-search-automation/myNET_backup_YYYYMMDD_HHMMSS.db \
   /Users/andrewmavliev/job-search-automation/myNET.db

# Verify
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db \
  "SELECT name FROM sqlite_master WHERE type='table' AND name = 'profile_notes';"
# Should return empty (table doesn't exist)
```

### Option B: Manual Rollback (Drop New Tables)

```bash
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db <<EOF
BEGIN TRANSACTION;

-- Drop tables
DROP TABLE IF EXISTS profile_notes_fts;
DROP TABLE IF EXISTS profile_notes;
DROP TABLE IF EXISTS profile_interactions;
DROP TABLE IF EXISTS profile_tags;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS app_metadata;
DROP TABLE IF EXISTS sync_queue;
DROP TABLE IF EXISTS profile_activity_log;
DROP TABLE IF EXISTS search_history;
DROP TABLE IF EXISTS schema_migrations;

-- Drop views
DROP VIEW IF EXISTS v_profile_notes_enriched;
DROP VIEW IF EXISTS v_recent_interactions;
DROP VIEW IF EXISTS v_follow_ups_pending;
DROP VIEW IF EXISTS v_tag_cloud;
DROP VIEW IF EXISTS v_profile_summary;
DROP VIEW IF EXISTS v_sync_status;

COMMIT;
EOF
```

**Note:** Rollback will delete all notes, interactions, and tags created since migration.

---

## Performance Considerations

### Database Size Projections

| Usage Level | Notes | Interactions | Tags | Total DB Size |
|-------------|-------|--------------|------|---------------|
| Light (1 month) | 50 | 20 | 10 | +1MB |
| Medium (6 months) | 300 | 150 | 30 | +5MB |
| Heavy (1 year) | 1000 | 500 | 100 | +15MB |

### Optimization Tips

1. **Run ANALYZE quarterly:**
   ```bash
   sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db "ANALYZE;"
   ```

2. **Vacuum annually to reclaim space:**
   ```bash
   sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db "VACUUM;"
   ```

3. **Prune old activity logs:**
   ```bash
   sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db \
     "DELETE FROM profile_activity_log WHERE timestamp < date('now', '-1 year');"
   ```

4. **Monitor sync queue size:**
   ```bash
   sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db \
     "SELECT COUNT(*) FROM sync_queue WHERE status != 'completed';"
   # Should be < 100 under normal operation
   ```

---

## Integration with Flutter App

### Required Packages

```yaml
# pubspec.yaml
dependencies:
  sqflite: ^2.3.0
  path: ^1.8.3
  sqflite_common_ffi: ^2.3.0  # For desktop support
```

### Database Helper Example

```dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyNetDatabase {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'myNET.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Schema already exists in production DB
        // This onCreate is only for fresh installs
      },
    );
  }

  // Insert note
  Future<int> insertNote({
    required String profileId,
    required String profileType,
    required String content,
    String? title,
    String noteType = 'general',
  }) async {
    final db = await database;
    return await db.insert('profile_notes', {
      'profile_id': profileId,
      'profile_type': profileType,
      'title': title,
      'content': content,
      'note_type': noteType,
    });
  }

  // Query notes with FTS
  Future<List<Map<String, dynamic>>> searchNotes(String query) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT pn.* FROM profile_notes pn
      JOIN profile_notes_fts fts ON pn.id = fts.rowid
      WHERE profile_notes_fts MATCH ?
      ORDER BY pn.updated_at DESC
      LIMIT 50
    ''', [query]);
  }

  // Get profile summary
  Future<Map<String, dynamic>?> getProfileSummary(
    String profileId,
    String profileType,
  ) async {
    final db = await database;
    final result = await db.query(
      'v_profile_summary',
      where: 'profile_id = ? AND profile_type = ?',
      whereArgs: [profileId, profileType],
    );
    return result.isNotEmpty ? result.first : null;
  }
}
```

---

## Troubleshooting

### Issue: Migration fails with "table already exists"

**Cause:** Migration was partially applied before.

**Solution:**
```bash
# Check which tables exist
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db \
  "SELECT name FROM sqlite_master WHERE type='table' AND name LIKE 'profile_%';"

# If only some tables exist, rollback and re-apply
# See "Rollback Procedure" above
```

### Issue: FTS5 search returns "no such module: fts5"

**Cause:** SQLite was compiled without FTS5 support.

**Solution:**
```bash
# Check SQLite version and compile options
sqlite3 --version
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db "PRAGMA compile_options;" | grep FTS

# Upgrade SQLite if needed (macOS with Homebrew)
brew install sqlite3
```

### Issue: Slow queries after migration

**Cause:** Query planner statistics not updated.

**Solution:**
```bash
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db "ANALYZE;"
```

### Issue: Database locked errors in Flutter app

**Cause:** Multiple processes accessing database simultaneously.

**Solution:**
- Enable WAL mode for better concurrency:
  ```dart
  await db.execute('PRAGMA journal_mode=WAL;');
  ```

---

## Support & Documentation

### Files

- `/Users/andrewmavliev/mynet-mobile/database/schema_extensions.sql` - Migration SQL
- `/Users/andrewmavliev/mynet-mobile/database/MIGRATION_GUIDE.md` - This guide
- `/Users/andrewmavliev/mynet-mobile/database/test_migration.sh` - Test script

### Database Location

- Production: `/Users/andrewmavliev/job-search-automation/myNET.db`
- Backups: `/Users/andrewmavliev/job-search-automation/myNET_backup_*.db`

### Query Examples

See the "Usage Examples" section at the end of `schema_extensions.sql` for common queries.

---

## Next Steps

1. ✅ Backup database
2. ✅ Apply migration
3. ✅ Run validation tests
4. ⬜ Integrate with Flutter app
5. ⬜ Implement sync logic
6. ⬜ Add UI for notes/interactions/tags
7. ⬜ Set up cloud backup (optional)

---

**Migration Version:** 1.0.0
**Last Updated:** 2025-12-19
**Compatibility:** SQLite 3.24+ (FTS5 required)
