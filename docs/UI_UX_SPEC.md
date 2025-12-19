# myNET Mobile CRM - UI/UX Specification

**Version:** 1.0
**Last Updated:** 2025-12-19
**Design System:** Material Design 3

---

## Table of Contents

1. [Design Philosophy](#design-philosophy)
2. [Design System](#design-system)
3. [Screen Specifications](#screen-specifications)
4. [Navigation Flow](#navigation-flow)
5. [Interaction Patterns](#interaction-patterns)
6. [Component Library](#component-library)
7. [Accessibility](#accessibility)
8. [Responsive Behavior](#responsive-behavior)

---

## Design Philosophy

### Core Principles

**1. CRM-Focused Workflow**
- Guide users through: **Search → Research → Engage**
- Prioritize contact discovery and relationship tracking
- Make common actions (call, email, note) prominent
- Surface relationship context at every touchpoint

**2. Information Density**
- Show maximum useful data without overwhelming
- Use progressive disclosure (overview → details)
- Employ visual hierarchy (typography, spacing, color)
- Leverage Material Design elevation and surfaces

**3. Mobile-First Design**
- Optimize for one-handed use (44dp minimum touch targets)
- Position primary actions in thumb zone (bottom 2/3 of screen)
- Use gestures where appropriate (swipe, long-press)
- Minimize text input; maximize selection

**4. Network Intelligence**
- Highlight connection strength and mutual connections
- Enable easy navigation between related profiles
- Show relationship timeline and interaction history
- Suggest next actions based on context

---

## Design System

### Color Palette

#### Primary Colors
```
Primary:           #1976D2 (Material Blue 700)
Primary Light:     #63A4FF
Primary Dark:      #004BA0
On Primary:        #FFFFFF

Secondary:         #4CAF50 (Material Green 500)
Secondary Light:   #80E27E
Secondary Dark:    #087F23
On Secondary:      #000000
```

#### Surface Colors
```
Surface:           #FAFAFA (Light Grey 50)
Surface Variant:   #E0E0E0 (Grey 300)
Background:        #FFFFFF
On Background:     #212121

Outline:           #BDBDBD (Grey 400)
Outline Variant:   #E0E0E0 (Grey 300)
```

#### Semantic Colors
```
Error:             #D32F2F (Material Red 700)
Error Light:       #EF5350
On Error:          #FFFFFF

Warning:           #F57C00 (Orange 700)
Success:           #388E3C (Green 700)
Info:              #1976D2 (Blue 700)
```

#### Connection Degree Colors
```
1st Degree:        #4CAF50 (Green 500)
2nd Degree:        #2196F3 (Blue 500)
3rd Degree:        #9E9E9E (Grey 500)
```

### Typography

**Type Scale (Material Design 3)**

```
Display Large:
  Font: Roboto
  Size: 57sp
  Weight: 400 (Regular)
  Line Height: 64sp
  Use: Large headers (rare)

Headline Large:
  Font: Roboto
  Size: 32sp
  Weight: 400 (Regular)
  Line Height: 40sp
  Use: Screen titles

Headline Medium:
  Font: Roboto
  Size: 28sp
  Weight: 400 (Regular)
  Line Height: 36sp
  Use: Section headers

Title Large:
  Font: Roboto Medium
  Size: 22sp
  Weight: 500 (Medium)
  Line Height: 28sp
  Use: Card titles, profile names

Title Medium:
  Font: Roboto Medium
  Size: 16sp
  Weight: 500 (Medium)
  Line Height: 24sp
  Use: Subtitles, company names

Body Large:
  Font: Roboto
  Size: 16sp
  Weight: 400 (Regular)
  Line Height: 24sp
  Use: Primary content

Body Medium:
  Font: Roboto
  Size: 14sp
  Weight: 400 (Regular)
  Line Height: 20sp
  Use: Secondary content

Label Large:
  Font: Roboto Medium
  Size: 14sp
  Weight: 500 (Medium)
  Line Height: 20sp
  Use: Buttons, chips

Label Medium:
  Font: Roboto Medium
  Size: 12sp
  Weight: 500 (Medium)
  Line Height: 16sp
  Use: Tab labels, badges

Label Small:
  Font: Roboto Medium
  Size: 11sp
  Weight: 500 (Medium)
  Line Height: 16sp
  Use: Captions, timestamps
```

### Spacing System

**8dp Grid System**

```
Space 1:    4dp   (Tight spacing)
Space 2:    8dp   (Default minimum)
Space 3:   12dp   (Comfortable)
Space 4:   16dp   (Standard padding)
Space 5:   24dp   (Section spacing)
Space 6:   32dp   (Large sections)
Space 7:   48dp   (Major divisions)
Space 8:   64dp   (Screen margins)
```

### Elevation

**Material Design 3 Elevation Levels**

```
Level 0:  0dp    (Background, no shadow)
Level 1:  1dp    (Cards at rest)
Level 2:  3dp    (Cards raised, FAB at rest)
Level 3:  6dp    (FAB raised, dialogs)
Level 4:  8dp    (Navigation drawer)
Level 5: 12dp    (Modal bottom sheet)
```

### Corner Radius

```
Extra Small:  4dp   (Chips, small buttons)
Small:        8dp   (Cards, text fields)
Medium:      12dp   (Large cards)
Large:       16dp   (Dialogs, bottom sheets)
Extra Large: 28dp   (FAB)
Full:       999dp   (Circular elements)
```

---

## Screen Specifications

### 1. Home/Search Screen

**Purpose:** Primary entry point for discovering and accessing contacts.

**Layout:**

```
┌─────────────────────────────────────┐
│  ☰  myNET            [≡] [👤]      │ Top App Bar (64dp)
├─────────────────────────────────────┤
│  🔍 Search contacts...              │ Search Bar (56dp)
├─────────────────────────────────────┤
│  [All] [1st] [2nd] [3rd] [+Filter] │ Filter Chips (40dp)
├─────────────────────────────────────┤
│  Sort: Recent ▼        [Grid/List]  │ Sort Bar (48dp)
├─────────────────────────────────────┤
│                                     │
│  ┌───────────────────────────────┐ │
│  │ 👤 Sarah Johnson           1° │ │ Contact Card
│  │ VP Engineering @ TechCorp     │ │ (88dp height)
│  │ 📍 San Francisco • 3d ago    │ │
│  └───────────────────────────────┘ │
│                                     │
│  ┌───────────────────────────────┐ │
│  │ 👤 Michael Chen            2° │ │
│  │ Product Manager @ StartupX    │ │
│  │ 📍 New York • 1w ago         │ │
│  └───────────────────────────────┘ │
│                                     │
│  ┌───────────────────────────────┐ │
│  │ 👤 Emily Rodriguez         1° │ │
│  │ CTO @ FinanceAI              │ │
│  │ 📍 Austin • 2w ago           │ │
│  └───────────────────────────────┘ │
│                                     │
│  ┌───────────────────────────────┐ │
│  │ 👤 David Park              3° │ │
│  │ Sr. Software Engineer         │ │
│  │ 📍 Seattle • 1m ago          │ │
│  └───────────────────────────────┘ │
│                                     │
│                                 ┌─┐ │
│                                 │+│ │ FAB (56dp)
│                                 └─┘ │
└─────────────────────────────────────┘
```

**Components:**

1. **Top App Bar (64dp)**
   - Leading icon: Menu (☰) - Opens navigation drawer
   - Title: "myNET" (Headline Medium)
   - Trailing icons:
     - Filter icon (≡) - Opens advanced filters
     - Profile icon (👤) - User account menu

2. **Search Bar (56dp)**
   - Leading icon: Search (🔍)
   - Hint text: "Search contacts..." (Body Large)
   - Trailing icon: Voice search (optional)
   - Background: Surface Variant
   - Corner radius: Small (8dp)
   - Margin: 16dp horizontal, 8dp vertical

3. **Filter Chips Row (40dp + 8dp padding)**
   - Horizontal scrollable
   - Chips: [All] [1st] [2nd] [3rd] [+Filter]
   - Selected chip: Primary color fill
   - Unselected: Outline variant
   - Height: 32dp
   - Corner radius: Extra Large (16dp)
   - Padding: 16dp horizontal

4. **Sort Bar (48dp)**
   - Left: "Sort: Recent ▼" dropdown
   - Right: View toggle (Grid/List icon)
   - Background: Surface
   - Divider below: Outline Variant

5. **Contact Card (88dp)**
   - Margin: 16dp horizontal, 8dp vertical
   - Padding: 16dp
   - Elevation: Level 1
   - Corner radius: Small (8dp)
   - Background: Surface
   - Ripple effect on tap

   **Card Structure:**
   ```
   Row 1: [Avatar 40dp] [Name (Title Large)] [Connection Badge]
   Row 2: [           ] [Headline (Body Medium)]
   Row 3: [           ] [Location + Last Contact (Label Medium, muted)]
   ```

   - Avatar: 40dp circle, Primary color placeholder
   - Connection badge: Small pill (1°/2°/3°), colored by degree
   - Last contact: Relative time (3d, 1w, 2w, 1m)

6. **Floating Action Button (56dp)**
   - Position: Bottom-right, 16dp margin
   - Icon: Plus (+)
   - Background: Secondary color
   - Elevation: Level 2 (rest), Level 3 (pressed)
   - Corner radius: Extra Large (28dp)
   - Action: Opens "Add Contact" menu

**Interaction States:**

- **Empty State:**
  ```
  ┌─────────────────────────────────────┐
  │                                     │
  │           📇                        │
  │                                     │
  │    No contacts yet                  │
  │    Tap + to add your first contact  │
  │                                     │
  │                                 ┌─┐ │
  │                                 │+│ │
  │                                 └─┘ │
  └─────────────────────────────────────┘
  ```

- **Search Active:**
  - Search bar expands, shows close (X) icon
  - Filter chips hide
  - Results update in real-time
  - Show recent searches below search bar

- **Loading State:**
  - Skeleton cards with shimmer effect
  - Preserve scroll position

**Gestures:**

- **Tap card:** Navigate to Profile Detail
- **Long-press card:** Show quick actions menu (Call, Email, Note)
- **Swipe card right:** Quick call
- **Swipe card left:** Quick email
- **Pull-to-refresh:** Sync contacts from server

---

### 2. Profile Detail Screen

**Purpose:** Comprehensive view of a single contact with all relationship data.

**Layout:**

```
┌─────────────────────────────────────┐
│  ← Sarah Johnson       ⋮            │ Top App Bar (64dp)
├─────────────────────────────────────┤
│                                     │
│         ╔═══════════╗               │ Header Section
│         ║           ║               │ (180dp)
│         ║   Photo   ║               │
│         ║  120x120  ║               │
│         ╚═══════════╝               │
│                                     │
│       Sarah Johnson                 │ Title Large
│   VP Engineering @ TechCorp     1°  │ Body Medium + Badge
│   📍 San Francisco, CA              │ Label Medium
├─────────────────────────────────────┤
│  [📞 Call] [✉ Email] [📝 Note]     │ Action Bar (64dp)
├─────────────────────────────────────┤
│  Overview  Experience  Notes  ▼     │ Tabs (48dp)
├─────────────────────────────────────┤
│                                     │ Tab Content
│  Connection Info                    │ (Scrollable)
│  ┌─────────────────────────────────┐│
│  │ Connected: Jan 15, 2024         ││
│  │ Mutual connections: 12          ││
│  │ Last contact: 3 days ago        ││
│  └─────────────────────────────────┘│
│                                     │
│  About                              │
│  ┌─────────────────────────────────┐│
│  │ Experienced engineering leader  ││
│  │ with 15+ years in tech...       ││
│  └─────────────────────────────────┘│
│                                     │
│  Contact Details                    │
│  ┌─────────────────────────────────┐│
│  │ 📧 sarah.j@techcorp.com        ││
│  │ 📱 +1 (555) 123-4567           ││
│  │ 🔗 linkedin.com/in/sarahj      ││
│  └─────────────────────────────────┘│
│                                     │
│  Tags                               │
│  [Engineering] [Leadership] [Bay Area]│
│                                     │
└─────────────────────────────────────┘
```

**Components:**

1. **Top App Bar (64dp)**
   - Leading icon: Back arrow (←)
   - Title: Contact name (Title Large)
   - Trailing icon: More menu (⋮)
     - Edit contact
     - Share contact
     - Delete contact
     - Export to vCard

2. **Header Section (180dp)**
   - Profile photo: 120dp circle, centered
   - Default: Initials on Primary color background
   - Tap to view full-size photo
   - Name: Title Large, centered, 8dp below photo
   - Headline: Body Medium, centered, 4dp below name
   - Connection badge: Inline with headline
   - Location: Label Medium, muted, centered, 4dp below

3. **Action Bar (64dp)**
   - Three equal-width buttons
   - Background: Surface Variant
   - Buttons:
     ```
     [📞 Call]    [✉ Email]    [📝 Note]
     ```
   - Icon: 24dp, Primary color
   - Label: Label Large
   - Ripple effect
   - Dividers between buttons

4. **Tabs (48dp)**
   - Primary tabs: Overview, Experience, Notes
   - Overflow menu (▼) for additional tabs
   - Active tab: Primary color indicator (2dp thick)
   - Inactive: On Surface color
   - Smooth scroll animation

5. **Tab Content Panels**

   **Overview Tab:**
   ```
   - Connection Info Card (surface elevation 1)
     • Connected date
     • Mutual connections (tappable)
     • Last contact (relative time)
     • Next action suggested

   - About Card
     • Bio/Summary text
     • Expandable if > 3 lines

   - Contact Details Card
     • Email (tappable → email client)
     • Phone (tappable → dialer)
     • LinkedIn (tappable → browser/app)
     • Other URLs

   - Tags Section
     • Horizontal wrap of tag chips
     • Tap to filter by tag
     • + button to add tags

   - Quick Stats
     • Total interactions
     • Notes count
     • Last interaction type
   ```

   **Experience Tab:**
   ```
   Timeline view (vertical)

   ┌─────────────────────────────────┐
   │ ● VP Engineering               │
   │   TechCorp                     │
   │   Jan 2020 - Present           │
   │   San Francisco, CA            │
   │                                │
   │ ○ Director of Engineering      │
   │   StartupX                     │
   │   Mar 2017 - Dec 2019          │
   │   New York, NY                 │
   │                                │
   │ ○ Sr. Engineering Manager      │
   │   BigCo Inc                    │
   │   Jun 2013 - Feb 2017          │
   │   Austin, TX                   │
   └─────────────────────────────────┘

   Education Section

   ┌─────────────────────────────────┐
   │ 🎓 MS Computer Science         │
   │    Stanford University         │
   │    2011 - 2013                 │
   │                                │
   │ 🎓 BS Electrical Engineering   │
   │    MIT                         │
   │    2007 - 2011                 │
   └─────────────────────────────────┘

   Skills Section

   [Engineering Leadership]
   [System Architecture]
   [Team Building]
   [Python] [Java] [AWS]
   ```

   **Notes Tab:**
   ```
   ┌─────────────────────────────────┐
   │  [+ Add Note]           🔍 ▼   │ Header with search/filter
   ├─────────────────────────────────┤
   │                                 │
   │  📝 Coffee meeting              │ Note Card
   │  Dec 15, 2024 • Meeting        │ (Elevation 1)
   │                                 │
   │  Had a great conversation about │
   │  their new AI platform. Interested│
   │  in potential collaboration...  │
   │                                 │
   │  #engineering #collaboration    │
   │                          [Edit] │
   ├─────────────────────────────────┤
   │                                 │
   │  📞 Phone call                  │
   │  Dec 10, 2024 • Call           │
   │                                 │
   │  Discussed Q1 hiring plans.    │
   │  Looking for senior engineers.  │
   │                                 │
   │  #hiring #engineering          │
   │                          [Edit] │
   ├─────────────────────────────────┤
   │                                 │
   │  ✉ Email exchange              │
   │  Dec 1, 2024 • Email           │
   │                                 │
   │  Shared portfolio and resume.  │
   │  Awaiting feedback.            │
   │                                 │
   │  #job-search                   │
   │                          [Edit] │
   └─────────────────────────────────┘
   ```

**Cards Styling:**

- All content cards:
  - Margin: 16dp horizontal, 8dp vertical
  - Padding: 16dp
  - Elevation: Level 1
  - Corner radius: Small (8dp)
  - Background: Surface

- Section headers:
  - Typography: Title Medium
  - Color: On Background
  - Margin: 16dp horizontal, 16dp top, 8dp bottom

**Interaction States:**

- **Loading:** Skeleton UI for header and cards
- **Error:** Error card with retry button
- **No data:** Empty state per tab with CTA

**Gestures:**

- **Pull-to-refresh:** Sync contact from LinkedIn
- **Swipe note left:** Delete note
- **Swipe note right:** Edit note
- **Long-press text:** Copy to clipboard

---

### 3. Add Note/Interaction Screen

**Purpose:** Capture interaction details and notes about contacts.

**Layout:**

```
┌─────────────────────────────────────┐
│  ✕  Add Note                   ✓    │ Top App Bar (64dp)
├─────────────────────────────────────┤
│                                     │
│  Interaction with Sarah Johnson     │ Context Header
│                                     │ (56dp)
├─────────────────────────────────────┤
│                                     │
│  Interaction Type                   │ Label (16dp)
│  ┌─────────────────────────────────┐│
│  │ Meeting              ▼          ││ Dropdown (56dp)
│  └─────────────────────────────────┘│
│                                     │
│  Date & Time                        │ Label (16dp)
│  ┌──────────────────┬──────────────┐│
│  │ Dec 19, 2024     │  2:30 PM    ││ Date/Time (56dp)
│  └──────────────────┴──────────────┘│
│                                     │
│  Location (optional)                │ Label (16dp)
│  ┌─────────────────────────────────┐│
│  │ Coffee shop                     ││ Text Field (56dp)
│  └─────────────────────────────────┘│
│                                     │
│  Notes                              │ Label (16dp)
│  ┌─────────────────────────────────┐│
│  │ Had a productive discussion     ││
│  │ about their new AI platform.    ││ Text Area
│  │ They're interested in potential ││ (Multi-line)
│  │ collaboration opportunities...  ││
│  │                                 ││
│  │                                 ││
│  └─────────────────────────────────┘│
│                                     │
│  Tags                               │ Label (16dp)
│  ┌─────────────────────────────────┐│
│  │ [engineering] [ai] [+]         ││ Tag Input (40dp)
│  └─────────────────────────────────┘│
│                                     │
│  Reminders (optional)               │ Label (16dp)
│  ┌─────────────────────────────────┐│
│  │ ☐ Follow up in 1 week          ││ Checkbox (48dp)
│  └─────────────────────────────────┘│
│                                     │
│  [    Cancel    ] [     Save     ]  │ Action Buttons
│                                     │ (52dp)
└─────────────────────────────────────┘
```

**Components:**

1. **Top App Bar (64dp)**
   - Leading icon: Close (✕) - Dismiss with confirmation
   - Title: "Add Note" or "Edit Note" (Title Large)
   - Trailing icon: Checkmark (✓) - Save note

2. **Context Header (56dp)**
   - Background: Surface Variant
   - Text: "Interaction with [Contact Name]" (Body Medium)
   - Avatar: 32dp circle, left aligned
   - Padding: 16dp

3. **Form Fields (Standard spacing: 24dp between)**

   **Interaction Type Dropdown (56dp)**
   - Options:
     ```
     Meeting
     Phone Call
     Email
     Video Call
     Coffee/Lunch
     Conference
     Other
     ```
   - Default: Meeting
   - Material Design 3 filled dropdown
   - Background: Surface Variant
   - Corner radius: Small (4dp top)

   **Date & Time Pickers (56dp each)**
   - Two-column layout (60/40 split)
   - Date picker: Material calendar dialog
   - Time picker: Material clock dialog
   - Default: Current date/time
   - Format: "MMM DD, YYYY" and "h:mm AM/PM"

   **Location Field (56dp, optional)**
   - Material filled text field
   - Hint: "Where did you meet?"
   - Auto-suggest from previous locations
   - Optional field (light grey label)

   **Notes Text Area (Expandable)**
   - Material filled text field (multi-line)
   - Min height: 120dp
   - Max height: 240dp (then scroll)
   - Hint: "What did you discuss?"
   - Character count: 0/1000 (Label Small, bottom-right)
   - Auto-save draft every 30 seconds

   **Tags Input (40dp + wrap)**
   - Chip group (horizontal wrap)
   - Existing tags as chips
   - [+] button to add new tag
   - Tap chip to remove
   - Auto-suggest from existing tags
   - Max 5 tags

   **Reminders Checkbox (48dp)**
   - Material checkbox + label
   - Options:
     ```
     ☐ Follow up in 1 week
     ☐ Follow up in 1 month
     ☐ Custom reminder
     ```
   - If checked, show date picker for custom

4. **Action Buttons (52dp)**
   - Two buttons, equal width
   - Cancel: Outlined button, On Surface color
   - Save: Filled button, Primary color
   - Margin: 16dp all sides
   - Height: 40dp
   - Corner radius: Full (20dp)

**Validation:**

- Required fields: Interaction Type, Date, Notes (min 10 chars)
- Show error state on invalid fields
- Disable Save button until valid
- Error text: Error color, Label Medium, below field

**Interaction States:**

- **Empty State:**
  - All fields cleared
  - Cursor in Notes field
  - Current date/time pre-filled

- **Saving State:**
  - Save button shows progress indicator
  - Disable all fields
  - On success: Navigate back with snackbar "Note saved"
  - On error: Show error snackbar, re-enable fields

- **Discard Changes:**
  - If user taps Close (✕) with unsaved changes
  - Show confirmation dialog:
    ```
    Discard changes?
    Your note has not been saved.

    [Cancel] [Discard]
    ```

**Auto-Complete:**

- Tags: Show dropdown of existing tags as user types
- Location: Show recent locations
- Max 5 suggestions, dismiss on select or blur

**Gestures:**

- **Swipe down:** Dismiss keyboard
- **Swipe chip left:** Remove tag

---

### 4. Advanced Filter Screen (Bottom Sheet)

**Purpose:** Provide comprehensive filtering and search options.

**Layout:**

```
┌─────────────────────────────────────┐
│         ━━━                         │ Drag Handle
├─────────────────────────────────────┤
│  Filters                        ✕   │ Header (64dp)
├─────────────────────────────────────┤
│                                     │
│  Connection Degree                  │ Section
│  ◉ All  ○ 1st  ○ 2nd  ○ 3rd       │ Radio Group
│                                     │
│  Company                            │ Section
│  ┌─────────────────────────────────┐│
│  │ Search companies...             ││ Search Field
│  └─────────────────────────────────┘│
│  ☐ TechCorp (12)                   │
│  ☐ StartupX (8)                    │ Checkboxes
│  ☐ BigCo Inc (5)                   │
│  [Show all companies]               │
│                                     │
│  Location                           │ Section
│  ┌─────────────────────────────────┐│
│  │ Search locations...             ││
│  └─────────────────────────────────┘│
│  ☐ San Francisco (15)              │
│  ☐ New York (10)                   │
│  ☐ Austin (7)                      │
│                                     │
│  Last Contact                       │ Section
│  ◉ Any time                        │
│  ○ Last week                       │ Radio Group
│  ○ Last month                      │
│  ○ Last 3 months                   │
│  ○ Last year                       │
│  ○ Custom range                    │
│                                     │
│  Tags                               │ Section
│  [Engineering] [Leadership]         │ Chip Group
│  [Bay Area] [+]                    │
│                                     │
│  [   Clear All   ] [    Apply    ] │ Actions (64dp)
└─────────────────────────────────────┘
```

**Behavior:**

- Opens as modal bottom sheet (elevation 5)
- Drag handle for pull-down to dismiss
- Filters apply on "Apply" tap
- "Clear All" resets to default state
- Filter count badge on Home screen filter icon
- Persist filter state across sessions

---

### 5. Add Contact Screen (Bottom Sheet)

**Purpose:** Quick entry point for adding new contacts.

**Layout:**

```
┌─────────────────────────────────────┐
│         ━━━                         │ Drag Handle
├─────────────────────────────────────┤
│  Add Contact                    ✕   │ Header (64dp)
├─────────────────────────────────────┤
│                                     │
│  [Import from LinkedIn]             │ Primary Action
│                                     │ (56dp button)
│             or                      │
│                                     │
│  Name *                             │
│  ┌─────────────────────────────────┐│
│  │ First                Last       ││ Two-column (56dp)
│  └─────────────────────────────────┘│
│                                     │
│  Email                              │
│  ┌─────────────────────────────────┐│
│  │ email@example.com              ││ Text Field (56dp)
│  └─────────────────────────────────┘│
│                                     │
│  Company                            │
│  ┌─────────────────────────────────┐│
│  │ Company name                   ││ Text Field (56dp)
│  └─────────────────────────────────┘│
│                                     │
│  [   Cancel   ] [  Add Contact  ]  │ Actions (64dp)
└─────────────────────────────────────┘
```

**Behavior:**

- Opens from FAB tap on Home screen
- "Import from LinkedIn" opens LinkedIn auth flow
- Manual entry requires Name only (other fields optional)
- On add: Navigate to new Profile Detail screen
- Show success snackbar "Contact added"

---

### 6. Navigation Drawer

**Purpose:** App-wide navigation and settings access.

**Layout:**

```
┌─────────────────────────────────────┐
│                                     │
│  ┌─────────────────────────────────┐│
│  │       👤                        ││ Header (180dp)
│  │   Andrew Mavliev                ││
│  │   andrew.m@email.com            ││
│  └─────────────────────────────────┘│
│                                     │
│  🏠 Home                            │ Nav Item (56dp)
│  👥 Contacts                        │
│  🏢 Companies                       │
│  🏷  Tags                           │
│  📊 Analytics                       │
│                                     │
│  ─────────────────────────────────  │ Divider
│                                     │
│  ⚙  Settings                       │
│  ℹ  About                          │
│  📱 Send Feedback                  │
│                                     │
└─────────────────────────────────────┘
```

**Components:**

- Header: User profile (editable on tap)
- Navigation items: Icon + Label, ripple effect
- Active item: Primary color background (12% opacity)
- Divider between main nav and secondary actions
- Width: 304dp (standard Material drawer)

---

## Navigation Flow

### Primary User Flows

**Flow 1: Search Contact → View Profile → Add Note**

```
Home Screen
    ↓ (Tap search)
Search Bar Active
    ↓ (Type query)
Filtered Results
    ↓ (Tap contact card)
Profile Detail Screen
    ↓ (Tap "Add Note" button)
Add Note Screen
    ↓ (Fill form, tap Save)
Profile Detail (Notes Tab)
    ↓ (Auto-navigate back)
```

**Flow 2: Browse → Quick Action**

```
Home Screen
    ↓ (Long-press contact card)
Quick Actions Menu
    ├─→ Call    → Phone Dialer
    ├─→ Email   → Email Client
    └─→ Note    → Add Note Screen
```

**Flow 3: Add Contact → Enrich Profile**

```
Home Screen
    ↓ (Tap FAB)
Add Contact Bottom Sheet
    ↓ (Choose option)
    ├─→ Import from LinkedIn → LinkedIn Auth → Profile Detail
    └─→ Manual Entry → Form → Profile Detail (edit mode)
```

**Flow 4: Filter & Sort**

```
Home Screen
    ↓ (Tap filter icon)
Advanced Filters Bottom Sheet
    ↓ (Select filters, tap Apply)
Home Screen (filtered results)
    ↓ (Tap sort dropdown)
Sort Menu
    ↓ (Select option)
Home Screen (sorted results)
```

### Navigation Patterns

**Tab Navigation:**
- Used in Profile Detail for content organization
- Swipe gesture enabled for horizontal navigation
- Smooth scroll animation

**Bottom Sheet Navigation:**
- Used for contextual actions (Add Contact, Filters)
- Modal overlay with scrim
- Swipe down or tap outside to dismiss

**Stack Navigation:**
- Primary pattern for screen-to-screen navigation
- Back button behavior: Pop current screen
- Deep linking support for direct profile access

**Drawer Navigation:**
- Global app navigation
- Swipe from left edge or tap menu icon
- Overlay with scrim

---

## Interaction Patterns

### Touch Targets

**Minimum Sizes (Material Design 3):**
- Buttons: 48dp × 48dp
- Icons: 24dp icon in 48dp touch target
- List items: 48dp minimum height
- Cards: 88dp minimum height

**Thumb Zones (Right-handed optimization):**
```
┌─────────────────────────────────────┐
│           Hard to Reach             │ Top 1/3
│                                     │
├─────────────────────────────────────┤
│                                     │
│           Easy to Reach             │ Middle 1/3
│        (Primary actions here)       │
│                                     │
├─────────────────────────────────────┤
│                                     │
│        Natural Thumb Zone           │ Bottom 1/3
│      (FAB, nav bar, actions)        │
│                                     │
└─────────────────────────────────────┘
```

### Gestures

**Standard Gestures:**

| Gesture | Context | Action |
|---------|---------|--------|
| Tap | Contact card | Open profile detail |
| Long-press | Contact card | Show quick actions menu |
| Swipe right | Contact card | Quick call |
| Swipe left | Contact card | Quick email |
| Swipe down | Add Note screen | Dismiss keyboard |
| Pull-to-refresh | Home screen | Sync contacts |
| Pull-to-refresh | Profile screen | Sync single contact |
| Swipe left | Note card | Delete note |
| Swipe right | Note card | Edit note |
| Pinch-zoom | Profile photo | Zoom/pan image |

**Gesture Feedback:**

- Visual: Ripple effect (Material ripple)
- Haptic: Light tap for actions, medium for confirmations
- Animation: Follow Material motion principles
- Undo: Snackbar with undo for destructive swipes

### Feedback & Confirmation

**Snackbars (Elevation 6, 48-64dp height):**

```
Success: "Note saved"
Error: "Failed to save note. Retry?"
Info: "Contact synced from LinkedIn"
Warning: "No internet connection"

Position: Bottom, 16dp margin
Duration: 4 seconds
Action: Optional (Undo, Retry)
```

**Dialogs (Elevation 3):**

```
Confirmation Dialogs:
┌─────────────────────────────────────┐
│  Delete contact?                    │
│                                     │
│  This action cannot be undone.      │
│                                     │
│            [Cancel] [Delete]        │
└─────────────────────────────────────┘

Alert Dialogs:
┌─────────────────────────────────────┐
│  Sync Failed                        │
│                                     │
│  Unable to connect to server.       │
│  Please check your connection.      │
│                                     │
│                    [OK]             │
└─────────────────────────────────────┘
```

**Progress Indicators:**

- Circular (indeterminate): General loading
- Linear (determinate): File upload, sync progress
- Skeleton UI: Content loading (cards, text blocks)

### Animation

**Material Motion Principles:**

1. **Informative:** Guide user attention
2. **Focused:** Direct to single point
3. **Expressive:** Reflect brand personality

**Transition Specs:**

```
Screen Transitions:
- Duration: 300ms
- Easing: Standard curve (cubic-bezier)
- Pattern: Shared element transition for photos

FAB Transitions:
- Duration: 200ms
- Scale: 0 → 1 (enter), 1 → 0 (exit)
- Rotation: 0° → 45° (close icon)

Bottom Sheet:
- Duration: 250ms
- Easing: Deceleration curve
- Motion: Slide up from bottom

Cards:
- Stagger: 50ms delay per card
- Fade in: 150ms
- Translate: 24dp vertical offset
```

### State Management

**Loading States:**

```
Skeleton UI for:
- Contact cards
- Profile header
- Experience timeline
- Notes list

Shimmer effect:
- Linear gradient animation
- 1000ms duration
- Left-to-right sweep
```

**Empty States:**

```
Components:
1. Icon (48dp, Primary color, 24% opacity)
2. Headline (Title Medium)
3. Body text (Body Medium, muted)
4. Action button (optional)

Examples:
- No contacts: "Get started by adding contacts"
- No notes: "Add your first note to track this relationship"
- No search results: "No contacts match your search"
```

**Error States:**

```
Components:
1. Error icon (48dp, Error color)
2. Error message (Body Large)
3. Retry button (Outlined button)

Examples:
- Network error: "Unable to connect. Tap to retry."
- Sync failed: "Sync failed. Check your connection."
- Load failed: "Failed to load contact. Tap to retry."
```

---

## Component Library

### Buttons

**Filled Button (Primary action):**
```
Background: Primary color
Text: On Primary color
Height: 40dp
Padding: 24dp horizontal, 10dp vertical
Corner radius: Full (20dp)
Elevation: Level 0 (rest), Level 1 (hover)
Typography: Label Large
```

**Outlined Button (Secondary action):**
```
Background: Transparent
Outline: Primary color, 1dp
Text: Primary color
Height: 40dp
Padding: 24dp horizontal, 10dp vertical
Corner radius: Full (20dp)
Typography: Label Large
```

**Text Button (Tertiary action):**
```
Background: Transparent
Text: Primary color
Height: 40dp
Padding: 12dp horizontal, 10dp vertical
Corner radius: Full (20dp)
Typography: Label Large
```

**Floating Action Button (FAB):**
```
Background: Secondary color
Icon: On Secondary color, 24dp
Size: 56dp × 56dp
Corner radius: Extra Large (28dp)
Elevation: Level 2 (rest), Level 3 (hover)
```

### Text Fields

**Filled Text Field:**
```
Background: Surface Variant
Text: On Surface
Label: On Surface Variant
Height: 56dp
Padding: 16dp horizontal
Corner radius: Small (4dp top)
Border: None (rest), Primary 2dp bottom (focused)
Typography: Body Large
```

**Outlined Text Field:**
```
Background: Transparent
Text: On Surface
Label: On Surface Variant
Border: Outline, 1dp (rest), Primary 2dp (focused)
Height: 56dp
Padding: 16dp horizontal
Corner radius: Small (4dp)
Typography: Body Large
```

### Cards

**Elevated Card:**
```
Background: Surface
Elevation: Level 1
Corner radius: Small (8dp)
Padding: 16dp
Border: None
```

**Filled Card:**
```
Background: Surface Variant
Elevation: Level 0
Corner radius: Small (8dp)
Padding: 16dp
Border: None
```

**Outlined Card:**
```
Background: Surface
Elevation: Level 0
Border: Outline, 1dp
Corner radius: Small (8dp)
Padding: 16dp
```

### Chips

**Filter Chip:**
```
Background: Surface (unselected), Primary (selected)
Text: On Surface (unselected), On Primary (selected)
Height: 32dp
Padding: 16dp horizontal
Corner radius: Extra Large (16dp)
Border: Outline, 1dp (unselected)
```

**Input Chip:**
```
Background: Surface Variant
Text: On Surface
Trailing icon: Close (X), 18dp
Height: 32dp
Padding: 12dp horizontal
Corner radius: Extra Large (16dp)
```

**Suggestion Chip:**
```
Background: Surface
Text: On Surface
Border: Outline, 1dp
Height: 32dp
Padding: 16dp horizontal
Corner radius: Extra Large (16dp)
```

### Lists

**Single-line List Item:**
```
Height: 56dp
Padding: 16dp horizontal
Leading: Icon or avatar, 40dp
Headline: Body Large
Trailing: Icon or meta text
```

**Two-line List Item:**
```
Height: 72dp
Padding: 16dp horizontal
Leading: Icon or avatar, 40dp
Headline: Body Large
Supporting text: Body Medium
Trailing: Icon or meta text
```

**Three-line List Item:**
```
Height: 88dp
Padding: 16dp horizontal
Leading: Icon or avatar, 40dp
Headline: Body Large
Supporting text: Body Medium (2 lines, ellipsis)
Trailing: Icon or meta text
```

### Dialogs

**Alert Dialog:**
```
Width: 280dp
Corner radius: Large (16dp)
Elevation: Level 3
Padding: 24dp
Title: Headline Medium
Body: Body Medium
Actions: Right-aligned buttons, 8dp gap
```

**Full-Screen Dialog:**
```
Width: 100%
Height: 100%
Top bar: Close (X), Title, Action
Content: Scrollable
Actions: Inline in top bar
```

### Bottom Sheets

**Modal Bottom Sheet:**
```
Width: 100%
Max height: 90% viewport
Corner radius: Large (16dp, top corners)
Elevation: Level 5
Drag handle: 32dp × 4dp, centered, 8dp margin
Scrim: Black, 32% opacity
```

**Standard Bottom Sheet:**
```
Width: 100%
Height: Auto (content-based)
Corner radius: Large (16dp, top corners)
Elevation: Level 1
Persistent: Remains visible
```

### Navigation Components

**Top App Bar (Small):**
```
Height: 64dp
Elevation: Level 0 (scroll 0), Level 2 (scrolled)
Padding: 16dp horizontal
Leading: Icon, 48dp touch target
Title: Title Large
Trailing: Icons, 48dp touch targets, 4dp gap
```

**Navigation Drawer:**
```
Width: 304dp
Elevation: Level 4
Background: Surface
Header: 180dp
Nav item: 56dp height, 16dp horizontal padding
Active indicator: Primary, 12% opacity, full width
```

**Bottom Navigation Bar:**
```
Height: 80dp
Elevation: Level 2
Background: Surface
Items: 3-5 items, equal width
Active: Primary color icon + label
Inactive: On Surface Variant icon + label
Icon: 24dp
Label: Label Medium
```

**Tab Bar:**
```
Height: 48dp
Background: Surface
Indicator: Primary, 2dp thick
Active tab: Primary color text
Inactive tab: On Surface Variant text
Typography: Label Large
```

---

## Accessibility

### WCAG 2.1 AA Compliance

**Color Contrast:**

```
Text Contrast Ratios:
- Large text (18sp+): 3:1 minimum
- Normal text (<18sp): 4.5:1 minimum
- UI components: 3:1 minimum

Compliant Pairings:
✓ Primary (#1976D2) on Surface (#FFFFFF): 4.6:1
✓ On Background (#212121) on Surface (#FFFFFF): 16.1:1
✓ Secondary (#4CAF50) on Surface (#FFFFFF): 3.6:1
✓ Error (#D32F2F) on Surface (#FFFFFF): 5.4:1
```

**Touch Targets:**

- Minimum: 48dp × 48dp (WCAG 2.5.5)
- Spacing: 8dp minimum between targets
- Active area: Visual size may be smaller, but touch area must be 48dp

**Text Scaling:**

- Support up to 200% font scaling
- Maintain layout integrity
- Use relative units (sp for text, dp for spacing)
- Test at 100%, 150%, 200% scales

### Screen Reader Support

**Content Descriptions:**

```kotlin
// Contact card
contentDescription = "Sarah Johnson, VP Engineering at TechCorp,
                      1st degree connection, last contact 3 days ago"

// Action buttons
contentDescription = "Call Sarah Johnson"
contentDescription = "Email Sarah Johnson"
contentDescription = "Add note about Sarah Johnson"

// FAB
contentDescription = "Add new contact"

// Filter chip
contentDescription = "Filter by 1st degree connections, selected"
```

**Semantic Headers:**

```xml
<!-- Use heading semantics -->
<TextView
    android:text="Connection Info"
    android:accessibilityHeading="true" />
```

**Focus Order:**

- Logical top-to-bottom, left-to-right
- Skip decorative elements
- Group related content
- Announce dynamic changes (live regions)

### Keyboard Navigation

**Tab Order:**

1. Top app bar (menu, title, actions)
2. Search bar
3. Filter chips (left to right)
4. Sort dropdown
5. Contact cards (top to bottom)
6. FAB

**Keyboard Shortcuts (Android TV, Chrome OS):**

```
Enter:   Activate focused element
Escape:  Close dialog/bottom sheet
Tab:     Move focus forward
Shift+Tab: Move focus backward
Arrow keys: Navigate within lists
/: Focus search bar
N: New contact (FAB)
```

### Motion & Animation

**Reduced Motion Preference:**

```kotlin
// Respect system preference
if (Settings.Global.getFloat(
    contentResolver,
    Settings.Global.TRANSITION_ANIMATION_SCALE, 1f
) == 0f) {
    // Disable or reduce animations
    transitionDuration = 0
} else {
    transitionDuration = 300
}
```

**Alternative to Motion:**

- Instant state changes for critical info
- Maintain spatial relationships
- Use color/opacity changes instead of movement

### Color Blindness

**Deuteranopia/Protanopia (Red-Green):**
- Don't rely solely on red/green for status
- Use icons + color (e.g., checkmark + green)
- Connection degrees: Use badges with text (1°, 2°, 3°)

**Tritanopia (Blue-Yellow):**
- Maintain sufficient contrast
- Use texture/pattern in addition to color

**Colorblind-Safe Palette:**
```
Primary:   #1976D2 (Blue - safe)
Secondary: #4CAF50 (Green - use with icon)
Error:     #D32F2F (Red - use with icon)
Success:   #388E3C (Green - use with icon)
Warning:   #F57C00 (Orange - safe)
```

---

## Responsive Behavior

### Screen Size Breakpoints

**Compact (Phone):**
```
Width: 0-599dp
- Single column layout
- Bottom navigation or drawer
- Stacked action buttons
- Modal bottom sheets
```

**Medium (Tablet Portrait, Foldable):**
```
Width: 600-839dp
- Two-column layout (list + detail)
- Navigation rail (side navigation)
- Side-by-side action buttons
- Standard bottom sheets (max 90% height)
```

**Expanded (Tablet Landscape, Desktop):**
```
Width: 840dp+
- Three-column layout (nav + list + detail)
- Navigation rail + detail pane
- Floating bottom sheets
- Modal dialogs instead of full-screen
```

### Adaptive Layouts

**Home Screen (Compact → Medium → Expanded):**

```
Compact (Phone):
┌─────────────────┐
│  Top Bar        │
│  Search         │
│  Filters        │
│  ┌───────────┐  │
│  │ Contact   │  │
│  │ Contact   │  │
│  │ Contact   │  │
│  └───────────┘  │
│           [FAB] │
└─────────────────┘

Medium (Tablet Portrait):
┌─────────────────────────────┐
│ Top Bar                     │
├────────┬────────────────────┤
│  Nav   │  Search            │
│  Rail  │  Filters           │
│        │  ┌──────────────┐  │
│ [Home] │  │ Contact      │  │
│ [Comp] │  │ Contact      │  │
│ [Tags] │  │ Contact      │  │
│        │  └──────────────┘  │
│        │            [FAB]   │
└────────┴────────────────────┘

Expanded (Tablet Landscape):
┌─────────────────────────────────────────────┐
│ Top Bar                                     │
├────┬───────────────┬────────────────────────┤
│Nav │ Contact List  │  Profile Detail        │
│Rail│ Search        │  ┌──────────────────┐  │
│    │ Filters       │  │   Profile Info   │  │
│[H] │ ┌──────────┐  │  │   [Actions]      │  │
│[C] │ │Contact   │  │  │   Tabs           │  │
│[T] │ │Contact   │  │  │   Content        │  │
│    │ └──────────┘  │  └──────────────────┘  │
│    │         [FAB] │                        │
└────┴───────────────┴────────────────────────┘
```

### Orientation Handling

**Portrait → Landscape:**

- Persist scroll position
- Maintain selected contact
- Adapt layout (single → multi-pane)
- Reorganize action buttons (stacked → horizontal)

**Landscape Optimizations:**

- Use horizontal space for detail panels
- Show more columns in lists
- Expand cards to show more info
- Use side-by-side forms (two columns)

### Foldable Device Support

**Unfolded (Large Screen):**
```
┌─────────────────────────────────┐
│ Contact List │ Profile Detail   │
│              │                  │
│              │                  │
└─────────────────────────────────┘
```

**Folded (Small Screen):**
```
┌──────────────┐
│ Contact List │
│              │
│              │
└──────────────┘
(Tap to open detail)
```

**Hinge Awareness:**
```
┌──────────────┬─────────────────┐
│ Contact List │ Profile Detail  │
│              │                 │
│              │                 │
└──────────────┴─────────────────┘
        ↑ Hinge position
```

### Text Scaling

**Dynamic Type Support:**

| Scale | Use Case | Adjustments |
|-------|----------|-------------|
| 100% | Default | Standard layout |
| 150% | Accessibility | Increase spacing 1.5x, multi-line labels |
| 200% | Maximum | Single column, stack actions, increase card height |

**Text Truncation:**

- Use ellipsis (…) for overflow
- Show full text on tap or tooltip
- Prefer wrapping for critical info (names, headlines)
- Maximum lines: Title (2), Body (3), Notes (5)

---

## Implementation Notes

### Material Design 3 Components

**Use Official Libraries:**
```gradle
dependencies {
    implementation "com.google.android.material:material:1.11.0"
    implementation "androidx.compose.material3:material3:1.2.0"
}
```

**Theme Configuration:**
```xml
<!-- res/values/themes.xml -->
<style name="Theme.MyNET" parent="Theme.Material3.Light">
    <item name="colorPrimary">@color/md_theme_light_primary</item>
    <item name="colorOnPrimary">@color/md_theme_light_onPrimary</item>
    <item name="colorSecondary">@color/md_theme_light_secondary</item>
    <item name="colorOnSecondary">@color/md_theme_light_onSecondary</item>
    <item name="colorSurface">@color/md_theme_light_surface</item>
    <item name="colorOnSurface">@color/md_theme_light_onSurface</item>
    <!-- ... -->
</style>
```

### Performance Considerations

**List Optimization:**
```kotlin
// Use RecyclerView with ListAdapter for efficient updates
class ContactAdapter : ListAdapter<Contact, ContactViewHolder>(ContactDiffCallback())

// Implement DiffUtil for minimal updates
class ContactDiffCallback : DiffUtil.ItemCallback<Contact>() {
    override fun areItemsTheSame(old: Contact, new: Contact) = old.id == new.id
    override fun areContentsTheSame(old: Contact, new: Contact) = old == new
}
```

**Image Loading:**
```kotlin
// Use Coil or Glide for efficient image loading
Coil.load(imageUrl) {
    crossfade(true)
    placeholder(R.drawable.avatar_placeholder)
    transformations(CircleCropTransformation())
    size(120, 120) // Match display size
}
```

**Database Queries:**
```kotlin
// Use paging for large lists
val contacts: Flow<PagingData<Contact>> = Pager(
    config = PagingConfig(pageSize = 20),
    pagingSourceFactory = { contactDao.getContactsPagingSource() }
).flow
```

### Dark Mode Support

**Color Palette (Dark Theme):**
```
Primary:           #90CAF9 (Blue 200)
On Primary:        #003258
Secondary:         #81C784 (Green 300)
On Secondary:      #00330E
Surface:           #1C1B1F
On Surface:        #E6E1E5
Background:        #1C1B1F
```

**Automatic Theme Switching:**
```kotlin
// Follow system theme
AppCompatDelegate.setDefaultNightMode(
    AppCompatDelegate.MODE_NIGHT_FOLLOW_SYSTEM
)
```

**Theme-Aware Assets:**
```
res/
  drawable/
    ic_logo.xml (default)
  drawable-night/
    ic_logo.xml (dark variant)
```

---

## Design Deliverables Checklist

### Phase 1: Core Screens (MVP)
- [✓] Home/Search Screen
- [✓] Profile Detail Screen
- [✓] Add Note/Interaction Screen
- [✓] Advanced Filter Screen
- [✓] Add Contact Screen

### Phase 2: Supporting Screens
- [ ] Settings Screen
- [ ] Company Detail Screen
- [ ] Tag Management Screen
- [ ] Analytics Dashboard
- [ ] Search Results Screen

### Phase 3: Onboarding & Empty States
- [ ] Welcome/Onboarding Flow
- [ ] Empty States (all screens)
- [ ] Error States (all screens)
- [ ] Loading States (all screens)

### Phase 4: Polish & Refinement
- [ ] Micro-interactions
- [ ] Animation specifications
- [ ] Sound/haptic feedback
- [ ] Accessibility audit

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2024-12-19 | Initial comprehensive specification |

---

## References

- [Material Design 3](https://m3.material.io/)
- [Material Design Components](https://material.io/components)
- [Android Design Guidelines](https://developer.android.com/design)
- [WCAG 2.1 Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)
- [Android Accessibility](https://developer.android.com/guide/topics/ui/accessibility)

---

**Document Owner:** Product Design Team
**Last Review:** 2024-12-19
**Next Review:** Q1 2025
