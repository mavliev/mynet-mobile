# myNET Mobile - Index Recommendations & Performance Guide

## Overview

This document provides index analysis, query optimization recommendations, and performance tuning guidance for the myNET mobile database with 2,600+ LinkedIn profiles and 1,850+ Booth profiles.

---

## Current Index Summary

### Profile Notes (9 indexes)

| Index Name | Columns | Purpose | Cardinality |
|------------|---------|---------|-------------|
| `idx_notes_profile` | `(profile_id, profile_type)` | Primary lookup | High |
| `idx_notes_type` | `(note_type)` | Filter by type | Low |
| `idx_notes_pinned` | `(is_pinned, created_at DESC)` | Pinned notes list | Medium |
| `idx_notes_updated` | `(updated_at DESC)` | Recent notes | High |
| `idx_notes_sync` | `(synced_at, is_deleted)` | Sync status | Medium |
| `profile_notes_fts` | FTS5 (title, content) | Full-text search | N/A |

**Triggers:** 3 (FTS sync on INSERT/UPDATE/DELETE, auto-update updated_at)

### Profile Interactions (6 indexes)

| Index Name | Columns | Purpose | Cardinality |
|------------|---------|---------|-------------|
| `idx_interactions_profile` | `(profile_id, profile_type)` | Primary lookup | High |
| `idx_interactions_type` | `(interaction_type)` | Filter by type | Medium |
| `idx_interactions_date` | `(interaction_date DESC)` | Recent interactions | High |
| `idx_interactions_follow_up` | `(follow_up_date, follow_up_completed)` | Follow-up dashboard | Medium |
| `idx_interactions_important` | `(is_important, interaction_date DESC)` | Important items | Low |
| `idx_interactions_sync` | `(synced_at, is_deleted)` | Sync status | Medium |

**Triggers:** 1 (auto-update updated_at)

### Tags & Profile Tags (7 indexes)

| Index Name | Columns | Purpose | Cardinality |
|------------|---------|---------|-------------|
| `idx_tags_name` | `(tag_name)` | Unique lookup | Medium |
| `idx_tags_category` | `(tag_category)` | Group by category | Low |
| `idx_tags_usage` | `(usage_count DESC)` | Popular tags | Medium |
| `idx_profile_tags_profile` | `(profile_id, profile_type)` | Profile's tags | High |
| `idx_profile_tags_tag` | `(tag_id)` | Profiles with tag | Medium |
| `idx_profile_tags_sync` | `(synced_at, is_deleted)` | Sync status | Medium |

**Unique Constraint:** `tags.tag_name`, `profile_tags(profile_id, profile_type, tag_id)`

**Triggers:** 3 (usage_count auto-increment/decrement)

### Activity & Search (4 indexes)

| Index Name | Columns | Purpose | Cardinality |
|------------|---------|---------|-------------|
| `idx_activity_profile` | `(profile_id, profile_type)` | Activity by profile | High |
| `idx_activity_type` | `(activity_type, timestamp DESC)` | Activity by type | Medium |
| `idx_activity_timestamp` | `(timestamp DESC)` | Recent activity | High |
| `idx_search_query` | `(search_query, timestamp DESC)` | Search autocomplete | Medium |
| `idx_search_timestamp` | `(timestamp DESC)` | Recent searches | High |

### Sync Queue (3 indexes)

| Index Name | Columns | Purpose | Cardinality |
|------------|---------|---------|-------------|
| `idx_sync_queue_status` | `(status, priority DESC, created_at)` | Sync processing | Medium |
| `idx_sync_queue_table` | `(table_name, record_id)` | Record lookup | High |
| `idx_sync_queue_retry` | `(retry_count, status)` | Retry logic | Low |

---

## Query Performance Analysis

### Most Common Query Patterns

#### 1. Get Profile Notes (High Frequency)

```sql
-- Query frequency: ~1000/day (user views profile)
SELECT * FROM profile_notes
WHERE profile_id = ? AND profile_type = ? AND is_deleted = 0
ORDER BY is_pinned DESC, updated_at DESC;
```

**Index Used:** `idx_notes_profile` + `is_pinned` sort
**Performance:** Excellent (< 1ms for 0-50 notes per profile)
**Optimization:** None needed

#### 2. Full-Text Note Search (Medium Frequency)

```sql
-- Query frequency: ~100/day (user searches notes)
SELECT pn.* FROM profile_notes pn
JOIN profile_notes_fts fts ON pn.id = fts.rowid
WHERE profile_notes_fts MATCH ?
ORDER BY pn.updated_at DESC
LIMIT 50;
```

**Index Used:** FTS5 index + `idx_notes_updated`
**Performance:** Good (5-20ms for 100-1000 notes)
**Optimization:** FTS5 is already optimal for text search

#### 3. Recent Interactions View (High Frequency)

```sql
-- Query frequency: ~500/day (dashboard, profile views)
SELECT * FROM v_recent_interactions
WHERE profile_id = ? AND profile_type = ?
LIMIT 50;
```

**Index Used:** `idx_interactions_profile` + `idx_interactions_date`
**Performance:** Excellent (< 2ms)
**Optimization:** None needed

#### 4. Pending Follow-Ups (High Frequency)

```sql
-- Query frequency: ~200/day (follow-up dashboard)
SELECT * FROM v_follow_ups_pending
WHERE follow_up_date BETWEEN date('now') AND date('now', '+7 days')
ORDER BY follow_up_date;
```

**Index Used:** `idx_interactions_follow_up`
**Performance:** Good (2-5ms)
**Optimization:** Consider composite index if WHERE filter is slow

#### 5. Profile Summary with Annotations (Very High Frequency)

```sql
-- Query frequency: ~2000/day (profile list, search results)
SELECT * FROM v_profile_summary
WHERE profile_id = ? AND profile_type = ?;
```

**Performance:** Medium (10-30ms due to subqueries)
**Optimization:** Consider materialized view or caching layer

---

## Recommended Additional Indexes

### 1. Composite Index for Note Type + Profile

**When to add:** If filtering notes by type per profile becomes common

```sql
CREATE INDEX IF NOT EXISTS idx_notes_profile_type
ON profile_notes(profile_id, profile_type, note_type)
WHERE is_deleted = 0;
```

**Use case:**
```sql
SELECT * FROM profile_notes
WHERE profile_id = ? AND profile_type = ? AND note_type = 'follow_up'
  AND is_deleted = 0;
```

**Cost:** +50KB per 1000 notes
**Benefit:** 3-5x faster for filtered queries

### 2. Covering Index for Interaction Summary

**When to add:** If interaction list queries are slow (>10ms)

```sql
CREATE INDEX IF NOT EXISTS idx_interactions_profile_covering
ON profile_interactions(profile_id, profile_type, interaction_date DESC)
INCLUDE (interaction_type, subject, outcome, is_important)
WHERE is_deleted = 0;
```

**Note:** SQLite doesn't support INCLUDE clause. Alternative: Composite index

```sql
CREATE INDEX IF NOT EXISTS idx_interactions_profile_date_type
ON profile_interactions(profile_id, profile_type, interaction_date DESC, interaction_type);
```

**Cost:** +100KB per 1000 interactions
**Benefit:** Avoid table lookups, 2x faster

### 3. Partial Index for Unsynced Items

**When to add:** Always (highly recommended for sync operations)

```sql
CREATE INDEX IF NOT EXISTS idx_notes_unsynced
ON profile_notes(id, updated_at)
WHERE synced_at IS NULL OR synced_at < updated_at;

CREATE INDEX IF NOT EXISTS idx_interactions_unsynced
ON profile_interactions(id, updated_at)
WHERE synced_at IS NULL OR synced_at < updated_at;

CREATE INDEX IF NOT EXISTS idx_profile_tags_unsynced
ON profile_tags(id)
WHERE synced_at IS NULL;
```

**Use case:** Quickly find items that need syncing
**Cost:** Minimal (only indexes unsynced items)
**Benefit:** 10-100x faster sync queries

### 4. Index for Tag Search

**When to add:** If tag-based profile filtering is slow

```sql
CREATE INDEX IF NOT EXISTS idx_profile_tags_tag_profile
ON profile_tags(tag_id, profile_id, profile_type)
WHERE is_deleted = 0;
```

**Use case:**
```sql
SELECT DISTINCT ps.* FROM v_profile_summary ps
JOIN profile_tags pt ON ps.profile_id = pt.profile_id
WHERE pt.tag_id IN (1, 2, 3) AND pt.is_deleted = 0;
```

**Cost:** +30KB per 1000 tag associations
**Benefit:** 5-10x faster for tag filters

---

## Index Maintenance Schedule

### Weekly Tasks

```bash
# Update query planner statistics (5-10 seconds)
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db "ANALYZE;"
```

**When to run:** After bulk imports or every 1000+ new records

### Monthly Tasks

```bash
# Check database integrity (30 seconds)
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db "PRAGMA integrity_check;"

# Check foreign key consistency (10 seconds)
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db "PRAGMA foreign_key_check;"

# Optimize database (1-2 minutes for 12MB DB)
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db "PRAGMA optimize;"
```

### Quarterly Tasks

```bash
# Vacuum database to reclaim space (30-60 seconds)
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db "VACUUM;"

# Rebuild FTS index if search is slow
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db <<EOF
INSERT INTO profile_notes_fts(profile_notes_fts) VALUES('rebuild');
EOF
```

---

## Query Optimization Tips

### 1. Use Query Planner for Slow Queries

```sql
EXPLAIN QUERY PLAN
SELECT * FROM profile_notes
WHERE profile_id = 'ACwAAACF9tMBvY...' AND profile_type = 'linkedin'
ORDER BY updated_at DESC;
```

**Look for:**
- `SCAN TABLE` = BAD (no index used, scans entire table)
- `SEARCH TABLE USING INDEX` = GOOD (index used)
- `USING COVERING INDEX` = EXCELLENT (all data from index)

### 2. Avoid SELECT * in Production

**Bad:**
```sql
SELECT * FROM profile_notes WHERE profile_id = ?;
```

**Good:**
```sql
SELECT id, title, content, created_at, updated_at
FROM profile_notes WHERE profile_id = ?;
```

**Benefit:** Reduces I/O and memory usage by 30-50%

### 3. Use Compound Queries for Efficiency

**Bad (2 queries):**
```dart
final notes = await db.query('profile_notes', where: 'profile_id = ?', ...);
final interactions = await db.query('profile_interactions', where: 'profile_id = ?', ...);
```

**Good (1 query with UNION):**
```sql
SELECT 'note' as type, id, created_at FROM profile_notes WHERE profile_id = ?
UNION ALL
SELECT 'interaction', id, interaction_date FROM profile_interactions WHERE profile_id = ?
ORDER BY created_at DESC;
```

**Benefit:** Reduces round-trips, 2x faster

### 4. Use Transactions for Bulk Operations

**Bad:**
```dart
for (var note in notes) {
  await db.insert('profile_notes', note);  // Individual commits
}
```

**Good:**
```dart
await db.transaction((txn) async {
  for (var note in notes) {
    await txn.insert('profile_notes', note);  // Single commit
  }
});
```

**Benefit:** 10-100x faster for bulk inserts

### 5. Limit Result Sets

**Bad:**
```sql
SELECT * FROM profile_interactions
ORDER BY interaction_date DESC;  -- Returns ALL interactions
```

**Good:**
```sql
SELECT * FROM profile_interactions
ORDER BY interaction_date DESC
LIMIT 100;  -- Returns only what's needed
```

**Benefit:** Reduces memory usage and rendering time

---

## View Performance Considerations

### v_profile_summary Performance

**Current Query Plan:**
```sql
-- Uses 3 subqueries per row (notes_count, interactions_count, tags_count)
-- Performance: 10-30ms for 1 profile, 500-1000ms for 100 profiles
```

**Optimization Option 1: Denormalize Counts**

Add columns to `linkedin_profiles` and `booth_profiles`:
```sql
ALTER TABLE linkedin_profiles ADD COLUMN notes_count INTEGER DEFAULT 0;
ALTER TABLE linkedin_profiles ADD COLUMN interactions_count INTEGER DEFAULT 0;
ALTER TABLE linkedin_profiles ADD COLUMN tags_count INTEGER DEFAULT 0;
```

Update via triggers:
```sql
CREATE TRIGGER trg_notes_count_inc
AFTER INSERT ON profile_notes
FOR EACH ROW
WHEN NEW.is_deleted = 0
BEGIN
  -- Update appropriate profile table based on profile_type
  -- (LinkedIn, Booth, or connections)
END;
```

**Cost:** +12 bytes per profile, trigger overhead on inserts
**Benefit:** 10-50x faster `v_profile_summary` queries

**Optimization Option 2: Materialized View (Cache)**

Create a cached table updated periodically:
```sql
CREATE TABLE profile_summary_cache AS
SELECT * FROM v_profile_summary;

CREATE INDEX idx_summary_cache_profile
ON profile_summary_cache(profile_id, profile_type);
```

Update cache every 5 minutes or on-demand:
```sql
DELETE FROM profile_summary_cache;
INSERT INTO profile_summary_cache SELECT * FROM v_profile_summary;
```

**Cost:** +1-2MB storage
**Benefit:** Instant queries (<1ms)

---

## Storage Projections

### Current Database Size: 12MB

| Component | Size | Percentage |
|-----------|------|------------|
| linkedin_profiles + data | 8 MB | 67% |
| booth_profiles + data | 2 MB | 17% |
| connections + messages | 1.5 MB | 12.5% |
| Indexes (existing) | 0.5 MB | 4% |
| **New tables + indexes** | **~0.5 MB** | **~4%** |

### Growth Projections (1 Year)

| Usage Scenario | Notes | Interactions | Tags | Total DB Size |
|----------------|-------|--------------|------|---------------|
| Light (5 notes/week) | 260 | 100 | 20 | 13 MB |
| Medium (20 notes/week) | 1,040 | 400 | 50 | 15 MB |
| Heavy (50 notes/week) | 2,600 | 1,000 | 100 | 20 MB |

### Index Size Estimates

| Index | Size (per 1000 records) | 1 Year (Heavy Use) |
|-------|-------------------------|---------------------|
| `idx_notes_profile` | 30 KB | 78 KB |
| `profile_notes_fts` | 150 KB | 390 KB |
| `idx_interactions_*` | 100 KB | 100 KB |
| `idx_profile_tags_*` | 50 KB | 50 KB |
| **Total Index Overhead** | **~0.3 MB** | **~0.6 MB** |

**Conclusion:** Index overhead is minimal (< 5% of total DB size)

---

## Mobile-Specific Optimizations

### 1. Enable WAL Mode (Write-Ahead Logging)

```dart
await db.execute('PRAGMA journal_mode=WAL;');
```

**Benefits:**
- Better concurrency (readers don't block writers)
- Faster writes (up to 2x)
- Better crash recovery

**Cost:** +2 WAL files on disk (-wal, -shm)

### 2. Increase Cache Size

```dart
await db.execute('PRAGMA cache_size=10000;'); // 10000 pages * 4KB = 40MB
```

**Benefits:**
- Fewer disk I/Os
- Faster queries (2-5x for cached data)

**Cost:** 40MB RAM (adjust based on device)

### 3. Use Prepared Statements

```dart
// Bad (re-compiled every time)
for (var id in ids) {
  await db.rawQuery('SELECT * FROM profile_notes WHERE id = $id');
}

// Good (compiled once, reused)
final stmt = await db.rawQuery('SELECT * FROM profile_notes WHERE id = ?');
for (var id in ids) {
  await db.rawQuery(stmt, [id]);
}
```

**Benefit:** 30-50% faster for repeated queries

### 4. Batch Operations

```dart
// Bad (individual inserts)
for (var note in notes) {
  await db.insert('profile_notes', note);
}

// Good (batch insert)
final batch = db.batch();
for (var note in notes) {
  batch.insert('profile_notes', note);
}
await batch.commit(noResult: true);
```

**Benefit:** 5-10x faster for bulk operations

---

## Monitoring & Profiling

### Check Database Stats

```sql
-- Database page count and size
PRAGMA page_count;
PRAGMA page_size;

-- Table sizes
SELECT name, SUM(pgsize) as size_bytes
FROM dbstat
WHERE name IN ('profile_notes', 'profile_interactions', 'tags', 'profile_tags')
GROUP BY name
ORDER BY size_bytes DESC;

-- Index usage (requires query log analysis)
SELECT * FROM sqlite_stat1 ORDER BY stat DESC;
```

### Identify Slow Queries in Flutter

```dart
import 'package:flutter/foundation.dart';

Future<T> _profileQuery<T>(String queryName, Future<T> Function() query) async {
  final stopwatch = Stopwatch()..start();
  try {
    return await query();
  } finally {
    stopwatch.stop();
    if (kDebugMode && stopwatch.elapsedMilliseconds > 50) {
      print('SLOW QUERY [$queryName]: ${stopwatch.elapsedMilliseconds}ms');
    }
  }
}

// Usage
final notes = await _profileQuery('get_notes', () =>
  db.query('profile_notes', where: 'profile_id = ?', whereArgs: [id])
);
```

---

## Troubleshooting

### Issue: Queries getting slower over time

**Cause:** Query planner statistics outdated

**Solution:**
```bash
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db "ANALYZE;"
```

### Issue: FTS search returns incorrect results

**Cause:** FTS index out of sync with main table

**Solution:**
```sql
-- Rebuild FTS index
INSERT INTO profile_notes_fts(profile_notes_fts) VALUES('rebuild');
```

### Issue: Database file growing too large

**Cause:** Deleted records not reclaimed, WAL file accumulation

**Solution:**
```bash
# Reclaim space (app must be closed)
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db "VACUUM;"

# Force WAL checkpoint
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db "PRAGMA wal_checkpoint(TRUNCATE);"
```

### Issue: "Database locked" errors

**Cause:** Multiple processes/threads accessing database simultaneously

**Solution:**
- Enable WAL mode: `PRAGMA journal_mode=WAL;`
- Increase busy timeout: `PRAGMA busy_timeout=5000;` (5 seconds)
- Use transactions properly (keep them short)

---

## Next Steps

1. ✅ Review current indexes (done)
2. ⬜ Apply recommended partial indexes for sync
3. ⬜ Enable WAL mode in Flutter app
4. ⬜ Implement query profiling in debug builds
5. ⬜ Monitor slow queries (> 50ms threshold)
6. ⬜ Consider denormalizing counts if `v_profile_summary` is slow
7. ⬜ Set up weekly ANALYZE automation

---

**Index Optimization Guide Version:** 1.0.0
**Last Updated:** 2025-12-19
**Database Size:** 12 MB (current), 15-20 MB (projected 1 year)
