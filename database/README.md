# myNET Mobile - Database Documentation

## Quick Start

This directory contains the complete database schema extensions and migration tools for the myNET Flutter mobile app.

### Files Overview

| File | Purpose | Size |
|------|---------|------|
| `schema_extensions.sql` | Complete SQL migration script | 26 KB |
| `MIGRATION_GUIDE.md` | Step-by-step migration instructions | 15 KB |
| `test_migration.sh` | Automated migration test suite (24 tests) | 11 KB |
| `FLUTTER_QUICK_REFERENCE.md` | Flutter/Dart code snippets for database operations | 19 KB |
| `INDEX_RECOMMENDATIONS.md` | Performance tuning and index optimization guide | 16 KB |

---

## Database Overview

**Production Database:** `/Users/andrewmavliev/job-search-automation/myNET.db`

**Current Size:** 12 MB
**Total Profiles:** 4,478 (2,628 LinkedIn + 1,850 Booth)
**Total Connections:** 2,650
**Total Messages:** 5,014

---

## New Tables Added (v1.0.0)

### Core Annotation Tables

1. **profile_notes** - User notes on profiles with full-text search
   - Rich text notes (Markdown/HTML support)
   - Pinned notes, color tags, note types
   - FTS5 full-text search index
   - Soft delete for sync support

2. **profile_interactions** - Track all touchpoints
   - Calls, emails, meetings, coffee chats, events
   - Follow-up tracking with dates and completion status
   - Duration tracking, outcomes, summaries
   - Location data for in-person meetings

3. **tags** + **profile_tags** - Flexible categorization
   - User-defined tags with categories and colors
   - Auto-incrementing usage counts
   - Many-to-many profile associations
   - Tag cloud analytics

### Supporting Tables

4. **app_metadata** - Key-value settings store (14 pre-populated settings)
5. **sync_queue** - Offline-first sync tracking
6. **profile_activity_log** - Audit trail and analytics
7. **search_history** - Search autocomplete data
8. **schema_migrations** - Version control

### Views (6 Analytical Views)

- `v_profile_notes_enriched` - Notes joined with profile data
- `v_recent_interactions` - Last 100 interactions with context
- `v_follow_ups_pending` - Active follow-ups sorted by urgency
- `v_tag_cloud` - Tag usage statistics
- `v_profile_summary` - Profile with annotation counts and metadata
- `v_sync_status` - Real-time sync dashboard

---

## Quick Migration

### 1. Backup Database

```bash
cp /Users/andrewmavliev/job-search-automation/myNET.db \
   /Users/andrewmavliev/job-search-automation/myNET_backup_$(date +%Y%m%d_%H%M%S).db
```

### 2. Apply Migration

```bash
cd /Users/andrewmavliev/mynet-mobile/database/

sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db < schema_extensions.sql
```

### 3. Test Migration

```bash
./test_migration.sh
```

Expected output: `✓ ALL TESTS PASSED!` (24/24 tests)

### 4. Verify

```bash
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db \
  "SELECT version, description, applied_at FROM schema_migrations;"
```

---

## Flutter Integration

### Install Dependencies

```yaml
# pubspec.yaml
dependencies:
  sqflite: ^2.3.0
  path: ^1.8.3
  sqflite_common_ffi: ^2.3.0  # For desktop/testing
```

### Quick Example

```dart
import 'package:sqflite/sqflite.dart';

// Insert a note
Future<int> addNote(String profileId, String content) async {
  final db = await openDatabase('myNET.db');

  return await db.insert('profile_notes', {
    'profile_id': profileId,
    'profile_type': 'linkedin',
    'content': content,
    'note_type': 'general',
  });
}

// Search notes
Future<List<Map<String, dynamic>>> searchNotes(String query) async {
  final db = await openDatabase('myNET.db');

  return await db.rawQuery('''
    SELECT pn.* FROM profile_notes pn
    JOIN profile_notes_fts fts ON pn.id = fts.rowid
    WHERE profile_notes_fts MATCH ?
    ORDER BY pn.updated_at DESC
  ''', [query]);
}

// Get profile summary with annotation counts
Future<Map<String, dynamic>?> getProfile(String id) async {
  final db = await openDatabase('myNET.db');

  final result = await db.query(
    'v_profile_summary',
    where: 'profile_id = ? AND profile_type = ?',
    whereArgs: [id, 'linkedin'],
  );

  return result.isNotEmpty ? result.first : null;
}
```

**See `FLUTTER_QUICK_REFERENCE.md` for 50+ ready-to-use code snippets.**

---

## Key Features

### 1. Offline-First Architecture

- All annotation data stored locally in SQLite
- Sync queue tracks pending changes
- Soft deletes preserve data for sync
- Conflict resolution with version tracking

### 2. Full-Text Search

- FTS5 index on note titles and content
- Instant search across thousands of notes
- Porter stemming and Unicode support
- Auto-synchronized via triggers

### 3. Follow-Up Management

- Track follow-up dates and completion status
- Pending follow-ups view with urgency sorting
- Overdue calculation (days past due date)
- Follow-up reminders integration-ready

### 4. Tag System

- Flexible categorization (industry, skill, priority, custom)
- Color-coded tags for visual organization
- Tag cloud analytics (usage counts)
- Auto-incrementing usage counts via triggers

### 5. Activity Logging

- Track profile views, searches, interactions
- Analytics-ready event data
- Device and user attribution
- Privacy controls

### 6. Performance Optimized

- 20+ strategic indexes for sub-10ms queries
- FTS5 for instant text search
- View-based aggregations
- Partial indexes for sync operations
- Query planner optimized

---

## Schema Design Principles

### 1. Non-Intrusive Migration

- No changes to existing tables
- All new tables use separate namespace
- Foreign keys reference existing profile IDs
- Views bridge new and existing data

### 2. Profile Type Flexibility

```sql
CHECK(profile_type IN ('linkedin', 'booth', 'connection'))
```

Supports all existing profile types:
- LinkedIn profiles (2,628)
- Booth profiles (1,850)
- Generic connections (2,650)

### 3. Soft Deletes

```sql
is_deleted BOOLEAN DEFAULT 0
```

All user-generated data uses soft deletes for:
- Sync conflict resolution
- Offline operation support
- Undo functionality
- Audit trail preservation

### 4. Auto-Timestamping

```sql
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
```

Triggers auto-update `updated_at` on changes:
- Version tracking for sync
- Conflict detection
- Activity timeline reconstruction

### 5. Version Control

```sql
version INTEGER DEFAULT 1,  -- Increment on each update
```

Used for optimistic locking and conflict resolution in sync.

---

## Performance Characteristics

### Query Performance (Target < 10ms)

| Operation | Query Time | Index Used |
|-----------|-----------|------------|
| Get profile notes | < 1 ms | `idx_notes_profile` |
| Search notes (FTS) | 5-20 ms | `profile_notes_fts` |
| Recent interactions | < 2 ms | `idx_interactions_date` |
| Pending follow-ups | 2-5 ms | `idx_interactions_follow_up` |
| Profile summary | 10-30 ms | Multiple subqueries |
| Tag filter | 3-8 ms | `idx_profile_tags_tag` |

### Storage Growth (1 Year Projection)

| Usage Level | Database Size | Index Overhead |
|-------------|---------------|----------------|
| Light | 13 MB | +0.3 MB |
| Medium | 15 MB | +0.4 MB |
| Heavy | 20 MB | +0.6 MB |

**Current:** 12 MB (baseline)

---

## Maintenance

### Weekly

```bash
# Update query planner statistics
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db "ANALYZE;"
```

### Monthly

```bash
# Database integrity check
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db "PRAGMA integrity_check;"

# Optimize query performance
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db "PRAGMA optimize;"
```

### Quarterly

```bash
# Reclaim deleted space
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db "VACUUM;"

# Rebuild FTS index (if search is slow)
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db \
  "INSERT INTO profile_notes_fts(profile_notes_fts) VALUES('rebuild');"
```

---

## Rollback

If you need to undo the migration:

```bash
# Restore from backup
cp /Users/andrewmavliev/job-search-automation/myNET_backup_YYYYMMDD_HHMMSS.db \
   /Users/andrewmavliev/job-search-automation/myNET.db
```

Or drop new tables manually (see `MIGRATION_GUIDE.md` for details).

---

## Common Use Cases

### Use Case 1: Add Meeting Note

```dart
final noteId = await db.insert('profile_notes', {
  'profile_id': 'ACwAAACF9tMBvY...',
  'profile_type': 'linkedin',
  'title': 'Coffee Chat - Q1 2025',
  'content': 'Discussed fintech trends, promised intro to Sarah at Stripe.',
  'note_type': 'meeting',
  'is_pinned': true,
});

final interactionId = await db.insert('profile_interactions', {
  'profile_id': 'ACwAAACF9tMBvY...',
  'profile_type': 'linkedin',
  'interaction_type': 'coffee',
  'interaction_date': DateTime.now().toIso8601String(),
  'subject': 'Coffee Chat',
  'outcome': 'positive',
  'follow_up_date': DateTime.now().add(Duration(days: 7)).toIso8601String(),
  'location': 'Blue Bottle Coffee, SOMA',
});
```

### Use Case 2: Tag VIP Contacts

```dart
// Create VIP tag
final tagId = await db.insert('tags', {
  'tag_name': 'VIP',
  'tag_category': 'priority',
  'tag_color': '#FF0000',
});

// Tag 10 profiles
for (var profileId in vipProfileIds) {
  await db.insert('profile_tags', {
    'profile_id': profileId,
    'profile_type': 'linkedin',
    'tag_id': tagId,
  });
}

// Query VIPs
final vips = await db.rawQuery('''
  SELECT ps.* FROM v_profile_summary ps
  JOIN profile_tags pt ON ps.profile_id = pt.profile_id
  JOIN tags t ON pt.tag_id = t.id
  WHERE t.tag_name = 'VIP'
''');
```

### Use Case 3: Follow-Up Dashboard

```dart
// Get follow-ups due this week
final followUps = await db.query(
  'v_follow_ups_pending',
  where: 'follow_up_date BETWEEN date("now") AND date("now", "+7 days")',
  orderBy: 'follow_up_date ASC',
);

// Display in UI
for (var followUp in followUps) {
  print('${followUp["profile_name"]} - ${followUp["subject"]}');
  print('Due: ${followUp["follow_up_date"]} (${followUp["days_overdue"]} days)');
}
```

### Use Case 4: Search Everything

```dart
// Full-text search across all notes
final results = await db.rawQuery('''
  SELECT pn.*,
         lp.full_name,
         lp.current_company
  FROM profile_notes pn
  JOIN profile_notes_fts fts ON pn.id = fts.rowid
  LEFT JOIN linkedin_profiles lp ON pn.profile_id = lp.profile_id
  WHERE profile_notes_fts MATCH ?
  ORDER BY pn.updated_at DESC
  LIMIT 50
''', ['fintech OR blockchain OR crypto']);
```

---

## Documentation Files

### For Database Administrators

- **MIGRATION_GUIDE.md** - Complete migration walkthrough with pre/post checks
- **INDEX_RECOMMENDATIONS.md** - Performance tuning, index analysis, optimization tips

### For Flutter Developers

- **FLUTTER_QUICK_REFERENCE.md** - 50+ code snippets for common operations
- **schema_extensions.sql** - Reference for table structures and constraints

### For Testing

- **test_migration.sh** - 24 automated tests for migration validation

---

## Support & Resources

### Internal Files

```
/Users/andrewmavliev/mynet-mobile/database/
├── schema_extensions.sql          # Main migration SQL (26 KB)
├── MIGRATION_GUIDE.md             # Migration instructions (15 KB)
├── test_migration.sh              # Test suite (11 KB)
├── FLUTTER_QUICK_REFERENCE.md     # Code snippets (19 KB)
├── INDEX_RECOMMENDATIONS.md       # Performance guide (16 KB)
└── README.md                      # This file
```

### Database Files

```
/Users/andrewmavliev/job-search-automation/
├── myNET.db                       # Production database (12 MB)
├── myNET_backup_*.db              # Backups (created as needed)
└── booth_network_schema.sql       # Original schema reference
```

---

## Next Steps

1. ✅ Review schema design (this document)
2. ⬜ Backup production database
3. ⬜ Apply migration: `sqlite3 myNET.db < schema_extensions.sql`
4. ⬜ Run tests: `./test_migration.sh`
5. ⬜ Integrate with Flutter app using `FLUTTER_QUICK_REFERENCE.md`
6. ⬜ Implement sync logic (offline-first)
7. ⬜ Build UI for notes, interactions, tags
8. ⬜ Set up automated ANALYZE (weekly maintenance)

---

## Version History

| Version | Date | Description |
|---------|------|-------------|
| 1.0.0 | 2025-12-19 | Initial schema extensions release |

---

## Contact & Feedback

For questions, issues, or suggestions about this schema design:

1. Review `MIGRATION_GUIDE.md` for common issues
2. Check `INDEX_RECOMMENDATIONS.md` for performance questions
3. Consult `FLUTTER_QUICK_REFERENCE.md` for code examples

---

**Schema Version:** 1.0.0
**Database Compatibility:** SQLite 3.24+ (FTS5 required)
**Last Updated:** 2025-12-19
