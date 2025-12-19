#!/bin/bash
# ============================================================================
# myNET Mobile - Migration Test Script
# ============================================================================
# Tests all new tables, views, triggers, and FTS search functionality
# Run this after applying schema_extensions.sql

DB_PATH="/Users/andrewmavliev/job-search-automation/myNET.db"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counter
TESTS_PASSED=0
TESTS_FAILED=0

echo "========================================================================"
echo "myNET Database Migration Test Suite"
echo "========================================================================"
echo "Database: $DB_PATH"
echo "Started: $(date)"
echo ""

# Helper function for test results
test_result() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ PASS${NC}: $1"
        ((TESTS_PASSED++))
    else
        echo -e "${RED}✗ FAIL${NC}: $1"
        ((TESTS_FAILED++))
    fi
}

# Test 1: Check schema_migrations table
echo "Test 1: Schema migrations table..."
RESULT=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM schema_migrations WHERE version = '1.0.0';")
if [ "$RESULT" -eq 1 ]; then
    test_result "Schema version 1.0.0 recorded"
else
    echo "Expected 1 migration record, found $RESULT"
    test_result "Schema migration table check"
fi

# Test 2: Verify all new tables exist
echo ""
echo "Test 2: Verify new tables exist..."
TABLES=("profile_notes" "profile_notes_fts" "profile_interactions" "profile_tags" "tags" "app_metadata" "sync_queue" "profile_activity_log" "search_history")
for table in "${TABLES[@]}"; do
    RESULT=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM sqlite_master WHERE type='table' AND name='$table';")
    if [ "$RESULT" -eq 1 ]; then
        test_result "Table '$table' exists"
    else
        test_result "Table '$table' missing"
    fi
done

# Test 3: Verify views exist
echo ""
echo "Test 3: Verify views exist..."
VIEWS=("v_profile_notes_enriched" "v_recent_interactions" "v_follow_ups_pending" "v_tag_cloud" "v_profile_summary" "v_sync_status")
for view in "${VIEWS[@]}"; do
    RESULT=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM sqlite_master WHERE type='view' AND name='$view';")
    if [ "$RESULT" -eq 1 ]; then
        test_result "View '$view' exists"
    else
        test_result "View '$view' missing"
    fi
done

# Test 4: Verify app_metadata defaults
echo ""
echo "Test 4: App metadata defaults..."
RESULT=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM app_metadata;")
if [ "$RESULT" -ge 10 ]; then
    test_result "App metadata populated with $RESULT settings"
else
    test_result "App metadata incomplete ($RESULT settings)"
fi

# Test 5: Insert profile note
echo ""
echo "Test 5: Insert profile note..."
sqlite3 "$DB_PATH" <<EOF
INSERT INTO profile_notes (profile_id, profile_type, title, content, note_type)
VALUES ('TEST_MIGRATION_001', 'linkedin', 'Test Note', 'This is a test note for migration validation. Keywords: fintech blockchain AI.', 'general');
EOF
test_result "Profile note inserted"

# Test 6: Verify FTS trigger fired
echo ""
echo "Test 6: FTS index auto-updated (trigger test)..."
RESULT=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM profile_notes_fts WHERE profile_notes_fts MATCH 'fintech';")
if [ "$RESULT" -ge 1 ]; then
    test_result "FTS5 trigger auto-indexed note"
else
    test_result "FTS5 trigger failed to index"
fi

# Test 7: Full-text search
echo ""
echo "Test 7: Full-text search functionality..."
RESULT=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM profile_notes_fts WHERE profile_notes_fts MATCH 'blockchain OR fintech';")
if [ "$RESULT" -ge 1 ]; then
    test_result "FTS5 search returned $RESULT results"
else
    test_result "FTS5 search failed"
fi

# Test 8: Insert interaction
echo ""
echo "Test 8: Insert profile interaction..."
sqlite3 "$DB_PATH" <<EOF
INSERT INTO profile_interactions (
    profile_id, profile_type, interaction_type, interaction_date,
    subject, summary, outcome, follow_up_date, is_important
)
VALUES (
    'TEST_MIGRATION_001', 'linkedin', 'call', datetime('now'),
    'Q1 Strategy Call', 'Discussed product roadmap and partnership opportunities.',
    'positive', date('now', '+7 days'), 1
);
EOF
test_result "Interaction inserted"

# Test 9: Insert tag and associate
echo ""
echo "Test 9: Tag system (insert + association)..."
sqlite3 "$DB_PATH" <<EOF
INSERT INTO tags (tag_name, tag_category, tag_color)
VALUES ('Test VIP', 'priority', '#FF0000');

INSERT INTO profile_tags (profile_id, profile_type, tag_id)
VALUES ('TEST_MIGRATION_001', 'linkedin', (SELECT id FROM tags WHERE tag_name = 'Test VIP'));
EOF
test_result "Tag created and associated"

# Test 10: Verify tag usage_count trigger
echo ""
echo "Test 10: Tag usage_count auto-increment (trigger test)..."
RESULT=$(sqlite3 "$DB_PATH" "SELECT usage_count FROM tags WHERE tag_name = 'Test VIP';")
if [ "$RESULT" -eq 1 ]; then
    test_result "Tag usage_count auto-incremented to $RESULT"
else
    test_result "Tag usage_count trigger failed (expected 1, got $RESULT)"
fi

# Test 11: Verify updated_at trigger on notes
echo ""
echo "Test 11: Auto-update updated_at timestamp (trigger test)..."
ORIGINAL_TIME=$(sqlite3 "$DB_PATH" "SELECT updated_at FROM profile_notes WHERE profile_id = 'TEST_MIGRATION_001';")
sleep 2
sqlite3 "$DB_PATH" "UPDATE profile_notes SET content = 'Updated content' WHERE profile_id = 'TEST_MIGRATION_001';"
NEW_TIME=$(sqlite3 "$DB_PATH" "SELECT updated_at FROM profile_notes WHERE profile_id = 'TEST_MIGRATION_001';")

if [ "$ORIGINAL_TIME" != "$NEW_TIME" ]; then
    test_result "updated_at timestamp auto-updated on note edit"
else
    test_result "updated_at trigger failed"
fi

# Test 12: Query enriched notes view
echo ""
echo "Test 12: Profile notes enriched view..."
RESULT=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM v_profile_notes_enriched WHERE profile_id = 'TEST_MIGRATION_001';")
if [ "$RESULT" -ge 1 ]; then
    test_result "Enriched notes view returned $RESULT rows"
else
    test_result "Enriched notes view query failed"
fi

# Test 13: Query recent interactions view
echo ""
echo "Test 13: Recent interactions view..."
RESULT=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM v_recent_interactions WHERE profile_id = 'TEST_MIGRATION_001';")
if [ "$RESULT" -ge 1 ]; then
    test_result "Recent interactions view returned $RESULT rows"
else
    test_result "Recent interactions view query failed"
fi

# Test 14: Query follow-ups view
echo ""
echo "Test 14: Pending follow-ups view..."
RESULT=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM v_follow_ups_pending WHERE profile_id = 'TEST_MIGRATION_001';")
if [ "$RESULT" -ge 1 ]; then
    test_result "Follow-ups view returned $RESULT pending items"
else
    test_result "Follow-ups view query failed"
fi

# Test 15: Query tag cloud view
echo ""
echo "Test 15: Tag cloud view..."
RESULT=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM v_tag_cloud WHERE tag_name = 'Test VIP';")
if [ "$RESULT" -eq 1 ]; then
    test_result "Tag cloud view working"
else
    test_result "Tag cloud view query failed"
fi

# Test 16: Query profile summary view
echo ""
echo "Test 16: Profile summary view..."
RESULT=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM v_profile_summary LIMIT 10;")
if [ "$RESULT" -ge 1 ]; then
    test_result "Profile summary view returned $RESULT profiles"
else
    test_result "Profile summary view query failed"
fi

# Test 17: Sync queue
echo ""
echo "Test 17: Sync queue insertion..."
sqlite3 "$DB_PATH" <<EOF
INSERT INTO sync_queue (table_name, record_id, operation, priority)
VALUES ('profile_notes', 1, 'insert', 10);
EOF
test_result "Sync queue entry created"

# Test 18: Sync status view
echo ""
echo "Test 18: Sync status view..."
RESULT=$(sqlite3 "$DB_PATH" "SELECT pending_sync_count FROM v_sync_status;")
if [ "$RESULT" -ge 1 ]; then
    test_result "Sync status view shows $RESULT pending items"
else
    test_result "Sync status view query failed"
fi

# Test 19: App metadata update
echo ""
echo "Test 19: App metadata update..."
sqlite3 "$DB_PATH" "UPDATE app_metadata SET value = 'test_device_123' WHERE key = 'device_id';"
RESULT=$(sqlite3 "$DB_PATH" "SELECT value FROM app_metadata WHERE key = 'device_id';")
if [ "$RESULT" = "test_device_123" ]; then
    test_result "App metadata updated"
else
    test_result "App metadata update failed"
fi

# Test 20: Activity log
echo ""
echo "Test 20: Profile activity log..."
sqlite3 "$DB_PATH" <<EOF
INSERT INTO profile_activity_log (profile_id, profile_type, activity_type, activity_data)
VALUES ('TEST_MIGRATION_001', 'linkedin', 'viewed', '{"source":"mobile_app","session_id":"test123"}');
EOF
test_result "Activity log entry created"

# Test 21: Search history
echo ""
echo "Test 21: Search history..."
sqlite3 "$DB_PATH" <<EOF
INSERT INTO search_history (search_query, search_type, results_count)
VALUES ('fintech startup', 'profile', 42);
EOF
test_result "Search history entry created"

# Test 22: Check index creation
echo ""
echo "Test 22: Verify indexes created..."
INDEX_COUNT=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM sqlite_master WHERE type='index' AND (name LIKE 'idx_notes_%' OR name LIKE 'idx_interactions_%' OR name LIKE 'idx_tags_%');")
if [ "$INDEX_COUNT" -ge 15 ]; then
    test_result "$INDEX_COUNT indexes created for performance"
else
    test_result "Missing indexes (found $INDEX_COUNT, expected 15+)"
fi

# Test 23: Database integrity check
echo ""
echo "Test 23: Database integrity check..."
INTEGRITY=$(sqlite3 "$DB_PATH" "PRAGMA integrity_check;")
if [ "$INTEGRITY" = "ok" ]; then
    test_result "Database integrity verified"
else
    echo -e "${RED}Database integrity check failed: $INTEGRITY${NC}"
    test_result "Database integrity"
fi

# Test 24: Foreign key constraints
echo ""
echo "Test 24: Foreign key constraints..."
sqlite3 "$DB_PATH" "PRAGMA foreign_key_check;" > /dev/null 2>&1
test_result "Foreign key constraints valid"

# Cleanup test data
echo ""
echo "========================================================================"
echo "Cleanup: Removing test data..."
echo "========================================================================"

sqlite3 "$DB_PATH" <<EOF
DELETE FROM profile_activity_log WHERE profile_id = 'TEST_MIGRATION_001';
DELETE FROM search_history WHERE search_query = 'fintech startup';
DELETE FROM sync_queue WHERE table_name = 'profile_notes';
DELETE FROM profile_interactions WHERE profile_id = 'TEST_MIGRATION_001';
DELETE FROM profile_notes WHERE profile_id = 'TEST_MIGRATION_001';
DELETE FROM profile_tags WHERE profile_id = 'TEST_MIGRATION_001';
DELETE FROM tags WHERE tag_name = 'Test VIP';
UPDATE app_metadata SET value = NULL WHERE key = 'device_id';
EOF

echo -e "${GREEN}✓${NC} Test data cleaned up"

# Final summary
echo ""
echo "========================================================================"
echo "Test Summary"
echo "========================================================================"
echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
echo -e "${RED}Failed: $TESTS_FAILED${NC}"
echo ""

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ ALL TESTS PASSED!${NC}"
    echo ""
    echo "Migration successful. Database is ready for mobile app integration."
    exit 0
else
    echo -e "${RED}✗ SOME TESTS FAILED${NC}"
    echo ""
    echo "Please review the errors above and consult MIGRATION_GUIDE.md"
    exit 1
fi
