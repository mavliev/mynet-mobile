# myNET Mobile - Development Plan

## Project Overview
Flutter Android CRM application for managing LinkedIn network contacts from myNET.db database.

**Database**: myNET.db (2,628 LinkedIn profiles, 2,650 connections)
**Tech Stack**: Flutter 3.38.5 + Riverpod + SQLite + Cloud Sync
**Development**: Offline-first, local database with Dropbox/Drive sync

## Phase 1: Core MVP (Weeks 1-2)

### 1.1 Project Setup
- [x] Install Flutter SDK and Android Studio
- [x] Create GitHub repository
- [ ] Initialize Flutter project structure
- [ ] Set up Riverpod state management
- [ ] Configure SQLite integration
- [ ] Add .gitignore and project configuration

### 1.2 Database Layer
- [ ] Create database models (Profile, Experience, Education, Skill, Connection)
- [ ] Implement SQLite repository pattern
- [ ] Add database migration scripts
- [ ] Create schema for annotations (notes, interactions, tags)
- [ ] Implement database service providers

### 1.3 Search & List View
- [ ] Design contact list UI/UX
- [ ] Implement search functionality (name, company, position)
- [ ] Add filter capabilities (company, location, connection degree)
- [ ] Create contact list item widget
- [ ] Implement pagination for large datasets
- [ ] Add sort options (name, company, last interaction)

### 1.4 Profile Detail Screen
- [ ] Design profile detail screen layout
- [ ] Display core profile information (name, headline, photo)
- [ ] Show work experiences with timeline
- [ ] Display education history
- [ ] List skills with endorsement counts
- [ ] Show connection information

### 1.5 Interactions & Notes
- [ ] Design interaction tracking UI
- [ ] Create notes database table
- [ ] Implement add/edit/delete note functionality
- [ ] Add interaction logging (call, email, meeting, message)
- [ ] Display interaction history timeline
- [ ] Add tags for categorization

## Phase 2: Testing & Quality (Week 3)

### 2.1 Unit Tests
- [ ] Database repository tests
- [ ] Model serialization tests
- [ ] Business logic tests
- [ ] State management tests
- [ ] Search & filter logic tests

### 2.2 Widget Tests
- [ ] Contact list widget tests
- [ ] Profile detail screen tests
- [ ] Search bar widget tests
- [ ] Filter panel tests
- [ ] Note editor tests

### 2.3 Integration Tests
- [ ] End-to-end search flow
- [ ] Profile detail navigation
- [ ] Note creation and editing
- [ ] Filter and sort operations
- [ ] Database CRUD operations

### 2.4 Manual Testing
- [ ] Test on Android emulator
- [ ] Test on physical Android device
- [ ] Performance testing with 2,600+ profiles
- [ ] UI/UX usability testing

## Phase 3: Cloud Sync & Polish (Week 4)

### 3.1 Cloud Sync Integration
- [ ] Integrate Dropbox SDK
- [ ] Implement file upload/download
- [ ] Add sync status indicators
- [ ] Handle sync conflicts
- [ ] Implement offline mode detection
- [ ] Add manual sync trigger

### 3.2 Critical Improvements
- [ ] Optimize search performance
- [ ] Add loading states and shimmer effects
- [ ] Implement error handling and retry logic
- [ ] Add data validation
- [ ] Improve accessibility (screen readers, contrast)
- [ ] Performance profiling and optimization

### 3.3 UI/UX Polish
- [ ] Refine color scheme and theming
- [ ] Add smooth transitions and animations
- [ ] Implement pull-to-refresh
- [ ] Add empty states and error screens
- [ ] Create app icon and splash screen
- [ ] Add haptic feedback

## Phase 4: Nice-to-Have Features (Future)

### 4.1 Network Visualization
- [ ] Implement network graph visualization
- [ ] Show connection paths between profiles
- [ ] Cluster analysis by company/industry
- [ ] Interactive graph navigation

### 4.2 Advanced Search
- [ ] Boolean search operators
- [ ] Saved search queries
- [ ] Search history
- [ ] Advanced filters (skills, education, years of experience)

### 4.3 Analytics & Insights
- [ ] Network statistics dashboard
- [ ] Connection strength scoring
- [ ] Activity timeline
- [ ] Outreach tracking metrics

### 4.4 Multi-Database Support
- [ ] Add JAT.db integration (job applications)
- [ ] Add emails.db integration (email archive)
- [ ] Cross-reference connections with job applications
- [ ] Link email threads to profiles

## Database Schema Extensions

### New Tables for MVP

```sql
-- User annotations and notes
CREATE TABLE profile_notes (
    note_id INTEGER PRIMARY KEY AUTOINCREMENT,
    profile_id VARCHAR(50) NOT NULL,
    note_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (profile_id) REFERENCES linkedin_profiles(profile_id) ON DELETE CASCADE
);

-- Interaction tracking
CREATE TABLE profile_interactions (
    interaction_id INTEGER PRIMARY KEY AUTOINCREMENT,
    profile_id VARCHAR(50) NOT NULL,
    interaction_type VARCHAR(50) NOT NULL, -- 'call', 'email', 'meeting', 'message'
    interaction_date TIMESTAMP NOT NULL,
    subject TEXT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (profile_id) REFERENCES linkedin_profiles(profile_id) ON DELETE CASCADE
);

-- Tags for categorization
CREATE TABLE profile_tags (
    tag_id INTEGER PRIMARY KEY AUTOINCREMENT,
    profile_id VARCHAR(50) NOT NULL,
    tag_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (profile_id) REFERENCES linkedin_profiles(profile_id) ON DELETE CASCADE
);

-- Indexes
CREATE INDEX idx_notes_profile ON profile_notes(profile_id);
CREATE INDEX idx_interactions_profile ON profile_interactions(profile_id);
CREATE INDEX idx_interactions_date ON profile_interactions(interaction_date);
CREATE INDEX idx_tags_profile ON profile_tags(profile_id);
CREATE INDEX idx_tags_name ON profile_tags(tag_name);
```

## Technology Decisions

### State Management: Riverpod
- Compile-time safety
- Great DevTools support
- Recommended by Flutter team
- Scales well for complex apps

### Database: SQLite via sqflite package
- Local-first architecture
- Offline support by default
- Direct SQL access
- Existing myNET.db compatibility

### Cloud Sync: Dropbox SDK
- Simple file sync model
- No server infrastructure needed
- Works with existing cloud storage
- Conflict resolution built-in

### UI Framework: Material Design 3
- Modern, clean aesthetic
- Great for CRM/business apps
- Consistent with Android platform
- Rich component library

## Risk Mitigation

### Performance Risks
- **Risk**: Slow search with 2,600+ profiles
- **Mitigation**: Implement FTS5 full-text search, pagination, lazy loading

### Data Sync Risks
- **Risk**: Sync conflicts between devices
- **Mitigation**: Last-write-wins strategy, conflict resolution UI

### Database Schema Risks
- **Risk**: Schema changes break compatibility
- **Mitigation**: Version-based migrations, backup before migration

## Success Metrics

### MVP Success Criteria
1. Search returns results in < 500ms for any query
2. Profile detail screen loads in < 300ms
3. App works fully offline with local database
4. Zero crashes during 100 profile views
5. All unit tests pass with >80% coverage
6. UI passes accessibility audit

### Performance Targets
- App startup: < 2 seconds
- Search response: < 500ms
- Profile navigation: < 300ms
- Sync operation: < 10 seconds for typical changes
- Memory usage: < 200MB with full dataset loaded

## Next Steps

1. **You**: Review this plan and approve phases
2. **Me**: Initialize Flutter project structure
3. **Agents**: Delegate implementation tasks
   - UI/UX design agent: Create mockups
   - Database agent: Implement data layer
   - Code agent: Build MVP features
   - Test agent: Write comprehensive tests
4. **Both**: Iterate and test each phase
