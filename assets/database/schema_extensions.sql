-- ============================================================================
-- myNET Mobile App - Database Schema Extensions
-- ============================================================================
-- Version: 1.0.0
-- Created: 2025-12-19
-- Purpose: Offline-first mobile annotations and tracking for LinkedIn/Booth profiles
-- Database: myNET.db (12MB, 2,628 LinkedIn profiles, 1,850 Booth profiles, 2,650 connections)
-- ============================================================================

-- Schema Version Control
-- ============================================================================

CREATE TABLE IF NOT EXISTS schema_migrations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    version TEXT UNIQUE NOT NULL,
    description TEXT NOT NULL,
    applied_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    checksum TEXT,  -- MD5/SHA256 of migration SQL for integrity
    status TEXT DEFAULT 'applied' CHECK(status IN ('applied', 'rolled_back', 'failed'))
);

-- Initial migration record
INSERT OR IGNORE INTO schema_migrations (version, description, checksum)
VALUES ('1.0.0', 'Mobile app schema extensions - annotations and interactions', 'schema_v1_initial');


-- ============================================================================
-- Profile Notes - Rich text notes with search support
-- ============================================================================

CREATE TABLE IF NOT EXISTS profile_notes (
    -- Primary Key
    id INTEGER PRIMARY KEY AUTOINCREMENT,

    -- Profile Reference (supports both LinkedIn and Booth profiles)
    profile_id TEXT NOT NULL,  -- References linkedin_profiles.profile_id OR booth_profiles.booth_id
    profile_type TEXT NOT NULL CHECK(profile_type IN ('linkedin', 'booth', 'connection')),

    -- Note Content
    title TEXT,  -- Optional note title/subject
    content TEXT NOT NULL,  -- Rich text note body (Markdown/HTML)
    note_type TEXT CHECK(note_type IN ('general', 'meeting', 'research', 'follow_up', 'personal')) DEFAULT 'general',

    -- Organization
    is_pinned BOOLEAN DEFAULT 0,  -- Pin important notes to top
    color_tag TEXT,  -- Hex color for visual categorization (#FF5733)

    -- Sync & Metadata
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    synced_at TIMESTAMP,  -- Last sync to cloud/backend
    is_deleted BOOLEAN DEFAULT 0,  -- Soft delete for sync
    device_id TEXT,  -- Device that created this note

    -- Version Control (for conflict resolution)
    version INTEGER DEFAULT 1,  -- Increment on each update
    conflict_resolution_strategy TEXT DEFAULT 'last_write_wins',

    -- Constraints
    CHECK(length(content) <= 50000)  -- Limit note size to 50KB
);

-- Indexes for profile_notes
CREATE INDEX IF NOT EXISTS idx_notes_profile ON profile_notes(profile_id, profile_type);
CREATE INDEX IF NOT EXISTS idx_notes_type ON profile_notes(note_type);
CREATE INDEX IF NOT EXISTS idx_notes_pinned ON profile_notes(is_pinned, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_notes_updated ON profile_notes(updated_at DESC);
CREATE INDEX IF NOT EXISTS idx_notes_sync ON profile_notes(synced_at, is_deleted);

-- FTS5 Full-Text Search for Notes
CREATE VIRTUAL TABLE IF NOT EXISTS profile_notes_fts USING fts5(
    title,
    content,
    content='profile_notes',
    content_rowid='id',
    tokenize='porter unicode61'
);

-- Triggers to keep FTS index synchronized
CREATE TRIGGER IF NOT EXISTS trg_notes_fts_insert
AFTER INSERT ON profile_notes
FOR EACH ROW
BEGIN
    INSERT INTO profile_notes_fts(rowid, title, content)
    VALUES (NEW.id, NEW.title, NEW.content);
END;

CREATE TRIGGER IF NOT EXISTS trg_notes_fts_update
AFTER UPDATE ON profile_notes
FOR EACH ROW
WHEN NEW.title != OLD.title OR NEW.content != OLD.content
BEGIN
    UPDATE profile_notes_fts
    SET title = NEW.title, content = NEW.content
    WHERE rowid = NEW.id;
END;

CREATE TRIGGER IF NOT EXISTS trg_notes_fts_delete
AFTER DELETE ON profile_notes
FOR EACH ROW
BEGIN
    DELETE FROM profile_notes_fts WHERE rowid = OLD.id;
END;

-- Auto-update updated_at timestamp
CREATE TRIGGER IF NOT EXISTS trg_notes_updated
AFTER UPDATE ON profile_notes
FOR EACH ROW
WHEN NEW.updated_at = OLD.updated_at  -- Only if not manually set
BEGIN
    UPDATE profile_notes
    SET updated_at = CURRENT_TIMESTAMP,
        version = OLD.version + 1
    WHERE id = NEW.id;
END;


-- ============================================================================
-- Profile Interactions - Track all touchpoints (calls, emails, meetings)
-- ============================================================================

CREATE TABLE IF NOT EXISTS profile_interactions (
    -- Primary Key
    id INTEGER PRIMARY KEY AUTOINCREMENT,

    -- Profile Reference
    profile_id TEXT NOT NULL,
    profile_type TEXT NOT NULL CHECK(profile_type IN ('linkedin', 'booth', 'connection')),

    -- Interaction Details
    interaction_type TEXT NOT NULL CHECK(interaction_type IN (
        'call', 'email', 'meeting', 'coffee', 'event',
        'linkedin_message', 'text', 'introduction', 'referral', 'other'
    )),
    interaction_date TIMESTAMP NOT NULL,  -- When interaction occurred
    duration_minutes INTEGER,  -- Optional duration for calls/meetings

    -- Context
    subject TEXT,  -- Meeting subject, email subject, call topic
    summary TEXT,  -- Brief summary of interaction
    outcome TEXT CHECK(outcome IN ('positive', 'neutral', 'negative', 'follow_up_needed')),
    follow_up_date DATE,  -- When to follow up
    follow_up_completed BOOLEAN DEFAULT 0,

    -- Location (for in-person meetings)
    location TEXT,

    -- Attachments & Links
    attachment_paths TEXT,  -- JSON array of local file paths
    related_note_ids TEXT,  -- JSON array of profile_notes.id references

    -- Organization
    is_important BOOLEAN DEFAULT 0,  -- Flag important interactions
    tags TEXT,  -- JSON array of custom tags

    -- Sync & Metadata
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    synced_at TIMESTAMP,
    is_deleted BOOLEAN DEFAULT 0,
    device_id TEXT,
    version INTEGER DEFAULT 1
);

-- Indexes for profile_interactions
CREATE INDEX IF NOT EXISTS idx_interactions_profile ON profile_interactions(profile_id, profile_type);
CREATE INDEX IF NOT EXISTS idx_interactions_type ON profile_interactions(interaction_type);
CREATE INDEX IF NOT EXISTS idx_interactions_date ON profile_interactions(interaction_date DESC);
CREATE INDEX IF NOT EXISTS idx_interactions_follow_up ON profile_interactions(follow_up_date, follow_up_completed);
CREATE INDEX IF NOT EXISTS idx_interactions_important ON profile_interactions(is_important, interaction_date DESC);
CREATE INDEX IF NOT EXISTS idx_interactions_sync ON profile_interactions(synced_at, is_deleted);

-- Auto-update updated_at timestamp
CREATE TRIGGER IF NOT EXISTS trg_interactions_updated
AFTER UPDATE ON profile_interactions
FOR EACH ROW
WHEN NEW.updated_at = OLD.updated_at
BEGIN
    UPDATE profile_interactions
    SET updated_at = CURRENT_TIMESTAMP,
        version = OLD.version + 1
    WHERE id = NEW.id;
END;


-- ============================================================================
-- Profile Tags - Flexible categorization system
-- ============================================================================

CREATE TABLE IF NOT EXISTS tags (
    -- Primary Key
    id INTEGER PRIMARY KEY AUTOINCREMENT,

    -- Tag Definition
    tag_name TEXT UNIQUE NOT NULL,
    tag_category TEXT,  -- Optional grouping: 'industry', 'skill', 'priority', 'location', 'custom'
    tag_color TEXT,  -- Hex color for UI display

    -- Usage Tracking
    usage_count INTEGER DEFAULT 0,  -- Denormalized count for quick queries

    -- Metadata
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_system_tag BOOLEAN DEFAULT 0,  -- System tags vs user-created

    CHECK(length(tag_name) >= 2 AND length(tag_name) <= 50)
);

-- Many-to-Many: Profiles to Tags
CREATE TABLE IF NOT EXISTS profile_tags (
    -- Composite Primary Key
    id INTEGER PRIMARY KEY AUTOINCREMENT,

    -- References
    profile_id TEXT NOT NULL,
    profile_type TEXT NOT NULL CHECK(profile_type IN ('linkedin', 'booth', 'connection')),
    tag_id INTEGER NOT NULL,

    -- Context
    tagged_by TEXT,  -- User who added tag (for multi-user support)
    tagged_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    -- Sync
    synced_at TIMESTAMP,
    is_deleted BOOLEAN DEFAULT 0,

    -- Constraints
    FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE,
    UNIQUE(profile_id, profile_type, tag_id)
);

-- Indexes for tags
CREATE INDEX IF NOT EXISTS idx_tags_name ON tags(tag_name);
CREATE INDEX IF NOT EXISTS idx_tags_category ON tags(tag_category);
CREATE INDEX IF NOT EXISTS idx_tags_usage ON tags(usage_count DESC);

CREATE INDEX IF NOT EXISTS idx_profile_tags_profile ON profile_tags(profile_id, profile_type);
CREATE INDEX IF NOT EXISTS idx_profile_tags_tag ON profile_tags(tag_id);
CREATE INDEX IF NOT EXISTS idx_profile_tags_sync ON profile_tags(synced_at, is_deleted);

-- Trigger to update tag usage count
CREATE TRIGGER IF NOT EXISTS trg_profile_tags_insert
AFTER INSERT ON profile_tags
FOR EACH ROW
WHEN NEW.is_deleted = 0
BEGIN
    UPDATE tags
    SET usage_count = usage_count + 1,
        updated_at = CURRENT_TIMESTAMP
    WHERE id = NEW.tag_id;
END;

CREATE TRIGGER IF NOT EXISTS trg_profile_tags_delete
AFTER DELETE ON profile_tags
FOR EACH ROW
BEGIN
    UPDATE tags
    SET usage_count = CASE
        WHEN usage_count > 0 THEN usage_count - 1
        ELSE 0
    END,
    updated_at = CURRENT_TIMESTAMP
    WHERE id = OLD.tag_id;
END;

-- Soft delete handling
CREATE TRIGGER IF NOT EXISTS trg_profile_tags_soft_delete
AFTER UPDATE OF is_deleted ON profile_tags
FOR EACH ROW
WHEN NEW.is_deleted = 1 AND OLD.is_deleted = 0
BEGIN
    UPDATE tags
    SET usage_count = CASE
        WHEN usage_count > 0 THEN usage_count - 1
        ELSE 0
    END,
    updated_at = CURRENT_TIMESTAMP
    WHERE id = NEW.tag_id;
END;


-- ============================================================================
-- App Metadata & Settings - App configuration and sync state
-- ============================================================================

CREATE TABLE IF NOT EXISTS app_metadata (
    -- Key-Value Store
    key TEXT PRIMARY KEY NOT NULL,
    value TEXT,
    value_type TEXT CHECK(value_type IN ('string', 'integer', 'boolean', 'json', 'timestamp')) DEFAULT 'string',

    -- Metadata
    description TEXT,  -- Human-readable description
    category TEXT,  -- Group related settings: 'sync', 'ui', 'cache', 'feature_flags'

    -- Change Tracking
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by TEXT  -- Device/user that last updated
);

-- Auto-update updated_at timestamp
CREATE TRIGGER IF NOT EXISTS trg_app_metadata_updated
AFTER UPDATE ON app_metadata
FOR EACH ROW
WHEN NEW.updated_at = OLD.updated_at
BEGIN
    UPDATE app_metadata
    SET updated_at = CURRENT_TIMESTAMP
    WHERE key = NEW.key;
END;

-- Default app metadata values
INSERT OR IGNORE INTO app_metadata (key, value, value_type, category, description) VALUES
('schema_version', '1.0.0', 'string', 'system', 'Current database schema version'),
('last_full_sync', NULL, 'timestamp', 'sync', 'Last complete data synchronization'),
('last_incremental_sync', NULL, 'timestamp', 'sync', 'Last incremental sync'),
('sync_enabled', 'true', 'boolean', 'sync', 'Master sync toggle'),
('sync_wifi_only', 'true', 'boolean', 'sync', 'Restrict sync to WiFi connections'),
('device_id', NULL, 'string', 'system', 'Unique device identifier'),
('user_id', NULL, 'string', 'system', 'Current logged-in user'),
('offline_mode', 'false', 'boolean', 'system', 'Offline mode status'),
('cache_size_mb', '0', 'integer', 'cache', 'Current cache size in MB'),
('max_cache_size_mb', '500', 'integer', 'cache', 'Maximum allowed cache size'),
('profile_view_preference', 'card', 'string', 'ui', 'Default profile view: card/list/grid'),
('dark_mode', 'false', 'boolean', 'ui', 'Dark mode enabled'),
('notifications_enabled', 'true', 'boolean', 'ui', 'Push notifications enabled'),
('follow_up_reminders', 'true', 'boolean', 'ui', 'Follow-up reminder notifications');


-- ============================================================================
-- Sync Tracking - Track what needs to be synced
-- ============================================================================

CREATE TABLE IF NOT EXISTS sync_queue (
    -- Primary Key
    id INTEGER PRIMARY KEY AUTOINCREMENT,

    -- Entity to Sync
    table_name TEXT NOT NULL,  -- Which table: 'profile_notes', 'profile_interactions', etc.
    record_id INTEGER NOT NULL,  -- Primary key of the record
    operation TEXT NOT NULL CHECK(operation IN ('insert', 'update', 'delete')),

    -- Sync State
    status TEXT DEFAULT 'pending' CHECK(status IN ('pending', 'in_progress', 'completed', 'failed')),
    retry_count INTEGER DEFAULT 0,
    max_retries INTEGER DEFAULT 3,
    last_error TEXT,

    -- Priority & Timing
    priority INTEGER DEFAULT 5,  -- 1-10, higher = more urgent
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    attempted_at TIMESTAMP,
    completed_at TIMESTAMP,

    -- Conflict Resolution
    server_version INTEGER,  -- Server's version of this record
    conflict_detected BOOLEAN DEFAULT 0,
    conflict_resolution TEXT  -- How conflict was resolved
);

CREATE INDEX IF NOT EXISTS idx_sync_queue_status ON sync_queue(status, priority DESC, created_at);
CREATE INDEX IF NOT EXISTS idx_sync_queue_table ON sync_queue(table_name, record_id);
CREATE INDEX IF NOT EXISTS idx_sync_queue_retry ON sync_queue(retry_count, status);


-- ============================================================================
-- Profile Activity Log - Audit trail for profile changes
-- ============================================================================

CREATE TABLE IF NOT EXISTS profile_activity_log (
    -- Primary Key
    id INTEGER PRIMARY KEY AUTOINCREMENT,

    -- Profile Reference
    profile_id TEXT NOT NULL,
    profile_type TEXT NOT NULL CHECK(profile_type IN ('linkedin', 'booth', 'connection')),

    -- Activity Details
    activity_type TEXT NOT NULL,  -- 'viewed', 'edited', 'tagged', 'noted', 'interacted', 'shared'
    activity_data TEXT,  -- JSON blob with activity-specific data

    -- Context
    device_id TEXT,
    user_id TEXT,
    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    -- Privacy
    is_analytics BOOLEAN DEFAULT 1  -- Include in analytics reports
);

CREATE INDEX IF NOT EXISTS idx_activity_profile ON profile_activity_log(profile_id, profile_type);
CREATE INDEX IF NOT EXISTS idx_activity_type ON profile_activity_log(activity_type, timestamp DESC);
CREATE INDEX IF NOT EXISTS idx_activity_timestamp ON profile_activity_log(timestamp DESC);


-- ============================================================================
-- Search History - Track user searches for autocomplete and analytics
-- ============================================================================

CREATE TABLE IF NOT EXISTS search_history (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    search_query TEXT NOT NULL,
    search_type TEXT CHECK(search_type IN ('profile', 'company', 'tag', 'note', 'full_text')) DEFAULT 'profile',
    results_count INTEGER,
    selected_result_id TEXT,  -- If user clicked a result
    device_id TEXT,
    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_search_query ON search_history(search_query, timestamp DESC);
CREATE INDEX IF NOT EXISTS idx_search_timestamp ON search_history(timestamp DESC);


-- ============================================================================
-- Views - Convenience queries for mobile app
-- ============================================================================

-- View: Enriched Profile Notes with Profile Info
CREATE VIEW IF NOT EXISTS v_profile_notes_enriched AS
SELECT
    pn.id,
    pn.profile_id,
    pn.profile_type,
    pn.title,
    pn.content,
    pn.note_type,
    pn.is_pinned,
    pn.color_tag,
    pn.created_at,
    pn.updated_at,
    -- LinkedIn profile info
    lp.full_name AS linkedin_name,
    lp.headline AS linkedin_headline,
    lp.current_company AS linkedin_company,
    lp.profile_photo_url AS linkedin_photo,
    -- Booth profile info
    bp.full_name AS booth_name,
    bp.current_title AS booth_title,
    bp.current_company AS booth_company,
    bp.photo_url AS booth_photo,
    -- Connection info
    c.first_name || ' ' || c.last_name AS connection_name,
    c.company AS connection_company,
    c.position AS connection_position
FROM profile_notes pn
LEFT JOIN linkedin_profiles lp ON pn.profile_id = lp.profile_id AND pn.profile_type = 'linkedin'
LEFT JOIN booth_profiles bp ON pn.profile_id = bp.booth_id AND pn.profile_type = 'booth'
LEFT JOIN connections c ON pn.profile_id = c.id AND pn.profile_type = 'connection'
WHERE pn.is_deleted = 0
ORDER BY pn.is_pinned DESC, pn.updated_at DESC;

-- View: Recent Interactions Dashboard
CREATE VIEW IF NOT EXISTS v_recent_interactions AS
SELECT
    pi.id,
    pi.profile_id,
    pi.profile_type,
    pi.interaction_type,
    pi.interaction_date,
    pi.subject,
    pi.summary,
    pi.outcome,
    pi.follow_up_date,
    pi.follow_up_completed,
    pi.is_important,
    -- Profile context
    COALESCE(lp.full_name, bp.full_name, c.first_name || ' ' || c.last_name) AS profile_name,
    COALESCE(lp.current_company, bp.current_company, c.company) AS company,
    COALESCE(lp.profile_photo_url, bp.photo_url) AS photo_url
FROM profile_interactions pi
LEFT JOIN linkedin_profiles lp ON pi.profile_id = lp.profile_id AND pi.profile_type = 'linkedin'
LEFT JOIN booth_profiles bp ON pi.profile_id = bp.booth_id AND pi.profile_type = 'booth'
LEFT JOIN connections c ON pi.profile_id = c.id AND pi.profile_type = 'connection'
WHERE pi.is_deleted = 0
ORDER BY pi.interaction_date DESC
LIMIT 100;

-- View: Follow-Up Dashboard
CREATE VIEW IF NOT EXISTS v_follow_ups_pending AS
SELECT
    pi.id,
    pi.profile_id,
    pi.profile_type,
    pi.interaction_type,
    pi.interaction_date,
    pi.follow_up_date,
    pi.subject,
    pi.summary,
    COALESCE(lp.full_name, bp.full_name, c.first_name || ' ' || c.last_name) AS profile_name,
    COALESCE(lp.current_company, bp.current_company, c.company) AS company,
    -- Days overdue (negative = upcoming, positive = overdue)
    CAST(julianday('now') - julianday(pi.follow_up_date) AS INTEGER) AS days_overdue
FROM profile_interactions pi
LEFT JOIN linkedin_profiles lp ON pi.profile_id = lp.profile_id AND pi.profile_type = 'linkedin'
LEFT JOIN booth_profiles bp ON pi.profile_id = bp.booth_id AND pi.profile_type = 'booth'
LEFT JOIN connections c ON pi.profile_id = c.id AND pi.profile_type = 'connection'
WHERE pi.follow_up_date IS NOT NULL
  AND pi.follow_up_completed = 0
  AND pi.is_deleted = 0
ORDER BY pi.follow_up_date ASC;

-- View: Tag Cloud with Usage
CREATE VIEW IF NOT EXISTS v_tag_cloud AS
SELECT
    t.id,
    t.tag_name,
    t.tag_category,
    t.tag_color,
    t.usage_count,
    COUNT(DISTINCT pt.profile_id) AS active_profile_count
FROM tags t
LEFT JOIN profile_tags pt ON t.id = pt.tag_id AND pt.is_deleted = 0
GROUP BY t.id
ORDER BY t.usage_count DESC;

-- View: Profile Summary with Annotations
CREATE VIEW IF NOT EXISTS v_profile_summary AS
SELECT
    lp.profile_id,
    'linkedin' AS profile_type,
    lp.full_name,
    lp.headline,
    lp.current_company,
    lp.location,
    lp.profile_photo_url AS photo_url,
    lp.connection_degree,
    -- Annotation counts
    (SELECT COUNT(*) FROM profile_notes
     WHERE profile_id = lp.profile_id AND profile_type = 'linkedin' AND is_deleted = 0) AS notes_count,
    (SELECT COUNT(*) FROM profile_interactions
     WHERE profile_id = lp.profile_id AND profile_type = 'linkedin' AND is_deleted = 0) AS interactions_count,
    (SELECT COUNT(*) FROM profile_tags
     WHERE profile_id = lp.profile_id AND profile_type = 'linkedin' AND is_deleted = 0) AS tags_count,
    -- Last interaction
    (SELECT MAX(interaction_date) FROM profile_interactions
     WHERE profile_id = lp.profile_id AND profile_type = 'linkedin' AND is_deleted = 0) AS last_interaction_date,
    -- Has pending follow-ups
    (SELECT COUNT(*) > 0 FROM profile_interactions
     WHERE profile_id = lp.profile_id AND profile_type = 'linkedin'
     AND follow_up_date IS NOT NULL AND follow_up_completed = 0 AND is_deleted = 0) AS has_pending_follow_up
FROM linkedin_profiles lp
WHERE lp.is_active = 1

UNION ALL

SELECT
    bp.booth_id AS profile_id,
    'booth' AS profile_type,
    bp.full_name,
    bp.headline,
    bp.current_company,
    bp.location,
    bp.photo_url,
    NULL AS connection_degree,
    (SELECT COUNT(*) FROM profile_notes
     WHERE profile_id = bp.booth_id AND profile_type = 'booth' AND is_deleted = 0) AS notes_count,
    (SELECT COUNT(*) FROM profile_interactions
     WHERE profile_id = bp.booth_id AND profile_type = 'booth' AND is_deleted = 0) AS interactions_count,
    (SELECT COUNT(*) FROM profile_tags
     WHERE profile_id = bp.booth_id AND profile_type = 'booth' AND is_deleted = 0) AS tags_count,
    (SELECT MAX(interaction_date) FROM profile_interactions
     WHERE profile_id = bp.booth_id AND profile_type = 'booth' AND is_deleted = 0) AS last_interaction_date,
    (SELECT COUNT(*) > 0 FROM profile_interactions
     WHERE profile_id = bp.booth_id AND profile_type = 'booth'
     AND follow_up_date IS NOT NULL AND follow_up_completed = 0 AND is_deleted = 0) AS has_pending_follow_up
FROM booth_profiles bp
WHERE bp.is_active = 1;

-- View: Sync Status Dashboard
CREATE VIEW IF NOT EXISTS v_sync_status AS
SELECT
    (SELECT COUNT(*) FROM sync_queue WHERE status = 'pending') AS pending_sync_count,
    (SELECT COUNT(*) FROM sync_queue WHERE status = 'failed') AS failed_sync_count,
    (SELECT MAX(created_at) FROM sync_queue WHERE status = 'completed') AS last_successful_sync,
    (SELECT COUNT(*) FROM profile_notes WHERE synced_at IS NULL OR synced_at < updated_at) AS notes_to_sync,
    (SELECT COUNT(*) FROM profile_interactions WHERE synced_at IS NULL OR synced_at < updated_at) AS interactions_to_sync,
    (SELECT COUNT(*) FROM profile_tags WHERE synced_at IS NULL) AS tags_to_sync,
    (SELECT value FROM app_metadata WHERE key = 'last_full_sync') AS last_full_sync,
    (SELECT value FROM app_metadata WHERE key = 'offline_mode') AS offline_mode;


-- ============================================================================
-- Performance Optimization Recommendations
-- ============================================================================

-- These indexes should improve mobile app query performance significantly:
-- 1. Profile lookup by ID + type (covers most profile queries)
-- 2. Date-based queries (recent notes, interactions, follow-ups)
-- 3. Sync status queries (what needs to be synced)
-- 4. Full-text search on notes (instant search)
-- 5. Tag filtering and autocomplete

-- ANALYZE command to update query planner statistics
-- Run this periodically in the app (e.g., weekly or after bulk imports)
ANALYZE;

-- ============================================================================
-- Data Integrity Checks
-- ============================================================================

-- Check for orphaned notes (profile_id doesn't exist in any profile table)
-- Run this query periodically to ensure data consistency:
--
-- SELECT pn.id, pn.profile_id, pn.profile_type, pn.title
-- FROM profile_notes pn
-- LEFT JOIN linkedin_profiles lp ON pn.profile_id = lp.profile_id AND pn.profile_type = 'linkedin'
-- LEFT JOIN booth_profiles bp ON pn.profile_id = bp.booth_id AND pn.profile_type = 'booth'
-- LEFT JOIN connections c ON pn.profile_id = CAST(c.id AS TEXT) AND pn.profile_type = 'connection'
-- WHERE lp.profile_id IS NULL AND bp.booth_id IS NULL AND c.id IS NULL;

-- ============================================================================
-- Migration & Rollback Strategy
-- ============================================================================

-- To apply this migration:
-- 1. Backup myNET.db before applying
-- 2. Run: sqlite3 myNET.db < schema_extensions.sql
-- 3. Verify: SELECT * FROM schema_migrations;
-- 4. Test app with new tables

-- To rollback (if needed):
-- DROP TABLE IF EXISTS profile_notes;
-- DROP TABLE IF EXISTS profile_notes_fts;
-- DROP TABLE IF EXISTS profile_interactions;
-- DROP TABLE IF EXISTS tags;
-- DROP TABLE IF EXISTS profile_tags;
-- DROP TABLE IF EXISTS app_metadata;
-- DROP TABLE IF EXISTS sync_queue;
-- DROP TABLE IF EXISTS profile_activity_log;
-- DROP TABLE IF EXISTS search_history;
-- DROP TABLE IF EXISTS schema_migrations;
-- -- Also drop all views and triggers created above

-- ============================================================================
-- Usage Examples for Mobile App Developers
-- ============================================================================

-- Example 1: Add a note to a LinkedIn profile
-- INSERT INTO profile_notes (profile_id, profile_type, title, content, note_type)
-- VALUES ('ACwAAACF9tMBvY...', 'linkedin', 'Coffee Chat Follow-up',
--         'Great conversation about fintech trends. Promised to intro to Sarah at Stripe.',
--         'follow_up');

-- Example 2: Log a phone call interaction
-- INSERT INTO profile_interactions
-- (profile_id, profile_type, interaction_type, interaction_date, duration_minutes, subject, summary, outcome, follow_up_date)
-- VALUES ('ACwAAACF9tMBvY...', 'linkedin', 'call', datetime('now'), 30,
--         'Q1 Product Roadmap Discussion',
--         'Discussed new features for mobile app. John interested in beta testing.',
--         'positive', date('now', '+7 days'));

-- Example 3: Add tags to a profile
-- INSERT INTO tags (tag_name, tag_category, tag_color) VALUES ('VIP', 'priority', '#FF0000');
-- INSERT INTO profile_tags (profile_id, profile_type, tag_id)
-- VALUES ('ACwAAACF9tMBvY...', 'linkedin',
--         (SELECT id FROM tags WHERE tag_name = 'VIP'));

-- Example 4: Search notes
-- SELECT * FROM profile_notes_fts WHERE profile_notes_fts MATCH 'fintech OR blockchain'
-- ORDER BY rank LIMIT 20;

-- Example 5: Get pending follow-ups for this week
-- SELECT * FROM v_follow_ups_pending
-- WHERE follow_up_date BETWEEN date('now') AND date('now', '+7 days')
-- ORDER BY follow_up_date;

-- Example 6: Get profile summary with all annotations
-- SELECT * FROM v_profile_summary
-- WHERE profile_id = 'ACwAAACF9tMBvY...' AND profile_type = 'linkedin';

-- ============================================================================
-- End of Schema Extensions
-- ============================================================================
