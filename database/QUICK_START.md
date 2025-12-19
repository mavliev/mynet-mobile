# myNET Mobile - Quick Start Guide

## 5-Minute Migration Guide

This is a condensed quick-start guide for applying the database schema extensions. For detailed information, see the comprehensive documentation files.

---

## Prerequisites

- [x] macOS or Linux
- [x] SQLite 3.24+ installed
- [x] myNET.db database at `/Users/andrewmavliev/job-search-automation/myNET.db`
- [x] 5 minutes of downtime for migration

---

## Step 1: Backup (30 seconds)

```bash
cd /Users/andrewmavliev/job-search-automation/

# Create timestamped backup
cp myNET.db myNET_backup_$(date +%Y%m%d_%H%M%S).db

# Verify backup created
ls -lh myNET_backup_*.db
```

Expected output: Backup file created (~12 MB)

---

## Step 2: Apply Migration (30 seconds)

```bash
cd /Users/andrewmavliev/mynet-mobile/database/

# Apply schema extensions
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db < schema_extensions.sql

# Verify migration applied
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db \
  "SELECT version, description FROM schema_migrations;"
```

Expected output:
```
1.0.0|Mobile app schema extensions - annotations and interactions
```

---

## Step 3: Test Migration (2 minutes)

```bash
cd /Users/andrewmavliev/mynet-mobile/database/

# Run automated test suite
./test_migration.sh
```

Expected output:
```
========================================================================
myNET Database Migration Test Suite
========================================================================

Test 1: Schema migrations table...
✓ PASS: Schema version 1.0.0 recorded

Test 2: Verify new tables exist...
✓ PASS: Table 'profile_notes' exists
✓ PASS: Table 'profile_notes_fts' exists
...

========================================================================
Test Summary
========================================================================
Passed: 24
Failed: 0

✓ ALL TESTS PASSED!

Migration successful. Database is ready for mobile app integration.
```

---

## Step 4: Verify Database (1 minute)

```bash
# Check database integrity
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db "PRAGMA integrity_check;"
# Expected: ok

# Count new tables
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db \
  "SELECT COUNT(*) FROM sqlite_master WHERE type='table' AND (name LIKE 'profile_%' OR name = 'tags' OR name = 'app_metadata');"
# Expected: 10

# Check database size
ls -lh /Users/andrewmavliev/job-search-automation/myNET.db
# Expected: ~12 MB (slight increase from baseline)
```

---

## Step 5: Quick Test Queries (1 minute)

```bash
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db
```

Then run these queries:

```sql
-- Check app settings
SELECT key, value FROM app_metadata LIMIT 5;

-- Check profile summary view (should return existing profiles)
SELECT COUNT(*) FROM v_profile_summary;
-- Expected: 4,478 (2,628 LinkedIn + 1,850 Booth)

-- Check sync status view
SELECT * FROM v_sync_status;

-- Exit
.quit
```

---

## Done!

Your database is now ready for mobile app integration.

### What Was Added

- **10 new tables** for notes, interactions, tags, and sync
- **6 new views** for analytics and dashboards
- **20+ indexes** for sub-10ms query performance
- **10+ triggers** for auto-updates and data integrity

### Database Stats (After Migration)

```
Size: ~12 MB (from 11.86 MB, +1.2% increase)
Tables: 45 (from 35, +10 new)
Profiles: 4,478 (unchanged)
Ready for: Offline-first mobile annotations
```

---

## Next Steps

### For Database Admins

1. Review [MIGRATION_GUIDE.md](/Users/andrewmavliev/mynet-mobile/database/MIGRATION_GUIDE.md) for maintenance schedule
2. Set up weekly ANALYZE job: `sqlite3 myNET.db "ANALYZE;"`
3. Monitor database size growth

### For Flutter Developers

1. Review [FLUTTER_QUICK_REFERENCE.md](/Users/andrewmavliev/mynet-mobile/database/FLUTTER_QUICK_REFERENCE.md)
2. Install sqflite package: `flutter pub add sqflite`
3. Copy code snippets from reference guide
4. Build note/interaction UI

### For Product/Engineering

1. Review [SCHEMA_SUMMARY.md](/Users/andrewmavliev/mynet-mobile/database/SCHEMA_SUMMARY.md) for architecture overview
2. Plan UI/UX for new features
3. Define sync strategy (cloud backend)

---

## Rollback (If Needed)

```bash
# Stop all apps using database first!

# Restore from backup
cp /Users/andrewmavliev/job-search-automation/myNET_backup_YYYYMMDD_HHMMSS.db \
   /Users/andrewmavliev/job-search-automation/myNET.db

# Verify rollback
sqlite3 /Users/andrewmavliev/job-search-automation/myNET.db \
  "SELECT COUNT(*) FROM sqlite_master WHERE type='table' AND name = 'profile_notes';"
# Expected: 0 (table doesn't exist after rollback)
```

---

## Troubleshooting

### Migration Fails

**Error:** `Error: table profile_notes already exists`

**Solution:** Migration was partially applied. Rollback and re-apply:
```bash
# Restore backup
cp myNET_backup_YYYYMMDD_HHMMSS.db myNET.db

# Re-apply migration
sqlite3 myNET.db < schema_extensions.sql
```

### Tests Fail

**Error:** Some tests show `✗ FAIL`

**Solution:** Check test output for specific error. Common issues:
- Database locked (close other apps using DB)
- Insufficient permissions (run with appropriate user)
- Corrupted database (restore from backup)

### FTS Search Not Working

**Error:** `no such module: fts5`

**Solution:** Upgrade SQLite to 3.24+:
```bash
# Check version
sqlite3 --version

# macOS with Homebrew
brew install sqlite3

# Verify FTS5 support
sqlite3 myNET.db "PRAGMA compile_options;" | grep FTS
```

---

## Support & Documentation

| Document | Purpose | Link |
|----------|---------|------|
| Quick Start | This guide | QUICK_START.md |
| Migration Guide | Detailed migration steps | MIGRATION_GUIDE.md |
| Schema Summary | Architecture overview | SCHEMA_SUMMARY.md |
| Flutter Reference | Code snippets | FLUTTER_QUICK_REFERENCE.md |
| Index Guide | Performance tuning | INDEX_RECOMMENDATIONS.md |
| Full Docs | Complete reference | README.md |

---

## Commands Cheat Sheet

```bash
# Backup database
cp myNET.db myNET_backup_$(date +%Y%m%d_%H%M%S).db

# Apply migration
sqlite3 myNET.db < schema_extensions.sql

# Test migration
./test_migration.sh

# Check integrity
sqlite3 myNET.db "PRAGMA integrity_check;"

# Update statistics (weekly)
sqlite3 myNET.db "ANALYZE;"

# Vacuum database (quarterly)
sqlite3 myNET.db "VACUUM;"

# Check database size
ls -lh myNET.db

# Rollback (restore backup)
cp myNET_backup_YYYYMMDD_HHMMSS.db myNET.db
```

---

## Success Checklist

- [ ] Backup created and verified
- [ ] Migration applied successfully
- [ ] All 24 tests passing
- [ ] Database integrity check passes
- [ ] Profile summary view returns correct count
- [ ] Database size increased by ~0.3-0.5 MB
- [ ] Ready to integrate with Flutter app

---

**Total Time:** 5 minutes
**Risk Level:** Very Low (additive migration, no data modification)
**Reversible:** Yes (via backup restoration)

**Status:** ✅ Ready for Production

---

*Quick Start Guide v1.0.0*
*Last Updated: 2025-12-19*
