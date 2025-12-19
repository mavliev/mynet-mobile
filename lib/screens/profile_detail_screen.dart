import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_header.dart';
import '../widgets/overview_tab.dart';
import '../widgets/experience_tab.dart';
import '../widgets/education_tab.dart';
import '../widgets/skills_tab.dart';
import '../widgets/notes_tab.dart';

/// Profile Detail Screen with tabbed layout
class ProfileDetailScreen extends ConsumerStatefulWidget {
  final String profileId;
  final String? heroTag;

  const ProfileDetailScreen({
    super.key,
    required this.profileId,
    this.heroTag,
  });

  @override
  ConsumerState<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends ConsumerState<ProfileDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(linkedInProfileProvider(widget.profileId));

    return Scaffold(
      body: profileAsync.when(
        data: (profile) {
          if (profile == null) {
            return const Center(
              child: Text('Profile not found'),
            );
          }

          return _buildProfileContent(profile);
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(linkedInProfileProvider(widget.profileId));
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildProfileContent(profile) {
    return CustomScrollView(
      slivers: [
        // App Bar with back button and menu
        SliverAppBar(
          pinned: true,
          expandedHeight: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(profile.fullName),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) => _handleMenuAction(value),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('Edit contact'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'share',
                  child: Row(
                    children: [
                      Icon(Icons.share),
                      SizedBox(width: 8),
                      Text('Share contact'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'export',
                  child: Row(
                    children: [
                      Icon(Icons.download),
                      SizedBox(width: 8),
                      Text('Export to vCard'),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Delete contact',
                          style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),

        // Profile Header
        SliverToBoxAdapter(
          child: ProfileHeader(
            profile: profile,
            heroTag: widget.heroTag,
          ),
        ),

        // Action Buttons
        SliverToBoxAdapter(
          child: _buildActionBar(profile),
        ),

        // Tab Bar
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
            TabBar(
              controller: _tabController,
              isScrollable: false,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Theme.of(context).primaryColor,
              indicatorWeight: 2,
              tabs: const [
                Tab(text: 'Overview'),
                Tab(text: 'Experience'),
                Tab(text: 'Education'),
                Tab(text: 'Skills'),
                Tab(text: 'Notes'),
              ],
            ),
          ),
        ),

        // Tab Content
        SliverFillRemaining(
          child: TabBarView(
            controller: _tabController,
            children: [
              OverviewTab(profile: profile),
              const ExperienceTab(experience: []),
              const EducationTab(
                education: [],
                skills: [],
              ),
              const SkillsTab(skills: []),
              const NotesTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionBar(profile) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
          bottom: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildActionButton(
              icon: Icons.phone,
              label: 'Call',
              onTap: () => _makeCall(profile.phone),
            ),
          ),
          VerticalDivider(color: Colors.grey[300], width: 1),
          Expanded(
            child: _buildActionButton(
              icon: Icons.email,
              label: 'Email',
              onTap: () => _sendEmail(profile.email),
            ),
          ),
          VerticalDivider(color: Colors.grey[300], width: 1),
          Expanded(
            child: _buildActionButton(
              icon: Icons.note_add,
              label: 'Note',
              onTap: () => _addNote(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Theme.of(context).primaryColor, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: _addNote,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: const Icon(Icons.add),
    );
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'edit':
        _editProfile();
        break;
      case 'share':
        _shareProfile();
        break;
      case 'export':
        _exportProfile();
        break;
      case 'delete':
        _deleteProfile();
        break;
    }
  }

  void _makeCall(String? phone) async {
    if (phone == null || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No phone number available')),
      );
      return;
    }

    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch phone app')),
        );
      }
    }
  }

  void _sendEmail(String? email) async {
    if (email == null || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No email address available')),
      );
      return;
    }

    final uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch email app')),
        );
      }
    }
  }

  void _addNote() {
    // TODO: Navigate to Add Note screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add Note feature coming soon')),
    );
  }

  void _editProfile() {
    // TODO: Navigate to Edit Profile screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit Profile feature coming soon')),
    );
  }

  void _shareProfile() {
    // TODO: Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share Profile feature coming soon')),
    );
  }

  void _exportProfile() {
    // TODO: Implement vCard export
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Export to vCard feature coming soon')),
    );
  }

  void _deleteProfile() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete contact?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement delete functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Delete feature coming soon')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

/// Delegate for pinned tab bar
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
