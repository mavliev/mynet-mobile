import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/profile.dart';
import '../providers/profile_provider.dart';

/// Overview tab showing connection info, about, contact details, and tags
class OverviewTab extends StatelessWidget {
  final Profile profile;

  const OverviewTab({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Connection Info Card
        _buildCard(
          context,
          title: 'Connection Info',
          child: _buildConnectionInfo(context),
        ),
        const SizedBox(height: 16),

        // About Card
        if (profile.about != null) ...[
          _buildCard(
            context,
            title: 'About',
            child: _buildAbout(context),
          ),
          const SizedBox(height: 16),
        ],

        // Contact Details Card
        _buildCard(
          context,
          title: 'Contact Details',
          child: _buildContactDetails(context),
        ),
        const SizedBox(height: 16),

        // Tags Section
        _buildCard(
          context,
          title: 'Tags',
          child: _buildTags(context),
        ),
        const SizedBox(height: 16),

        // Quick Stats Card
        _buildCard(
          context,
          title: 'Quick Stats',
          child: _buildQuickStats(context),
        ),
      ],
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildConnectionInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (profile.connectedDate != null)
          _buildInfoRow(
            context,
            icon: Icons.calendar_today,
            label: 'Connected',
            value: _formatDate(profile.connectedDate!),
          ),
        if (profile.mutualConnections > 0) ...[
          const SizedBox(height: 12),
          _buildInfoRow(
            context,
            icon: Icons.people,
            label: 'Mutual connections',
            value: '${profile.mutualConnections}',
            onTap: () {
              // TODO: Navigate to mutual connections
            },
          ),
        ],
        if (profile.lastContactDate != null) ...[
          const SizedBox(height: 12),
          _buildInfoRow(
            context,
            icon: Icons.schedule,
            label: 'Last contact',
            value: _formatDate(profile.lastContactDate!),
          ),
        ],
      ],
    );
  }

  Widget _buildAbout(BuildContext context) {
    return Text(
      profile.about!,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget _buildContactDetails(BuildContext context) {
    return Column(
      children: [
        if (profile.email != null)
          _buildContactRow(
            context,
            icon: Icons.email,
            label: profile.email!,
            onTap: () => _sendEmail(profile.email!),
            onLongPress: () => _copyToClipboard(context, profile.email!),
          ),
        if (profile.phone != null) ...[
          if (profile.email != null) const Divider(height: 24),
          _buildContactRow(
            context,
            icon: Icons.phone,
            label: profile.phone!,
            onTap: () => _makeCall(profile.phone!),
            onLongPress: () => _copyToClipboard(context, profile.phone!),
          ),
        ],
        if (profile.linkedinUrl != null) ...[
          if (profile.email != null || profile.phone != null)
            const Divider(height: 24),
          _buildContactRow(
            context,
            icon: Icons.link,
            label: 'LinkedIn Profile',
            onTap: () => _openUrl(profile.linkedinUrl!),
          ),
        ],
      ],
    );
  }

  Widget _buildTags(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...profile.tags.map((tag) => _buildTagChip(context, tag)),
            _buildAddTagButton(context),
          ],
        );
      },
    );
  }

  Widget _buildTagChip(BuildContext context, String tag) {
    return Chip(
      label: Text(tag),
      deleteIcon: const Icon(Icons.close, size: 18),
      onDeleted: () {
        context.read<ProfileProvider>().removeTag(tag);
      },
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
      labelStyle: TextStyle(
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildAddTagButton(BuildContext context) {
    return ActionChip(
      label: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add, size: 18),
          SizedBox(width: 4),
          Text('Add tag'),
        ],
      ),
      onPressed: () => _showAddTagDialog(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatColumn(
              context,
              label: 'Notes',
              value: '${provider.notes.length}',
              icon: Icons.note,
            ),
            _buildStatColumn(
              context,
              label: 'Interactions',
              value: '${provider.interactions.length}',
              icon: Icons.timeline,
            ),
            _buildStatColumn(
              context,
              label: 'Experience',
              value: '${profile.experience.length}',
              icon: Icons.work,
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatColumn(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          if (onTap != null)
            Icon(Icons.chevron_right, color: Colors.grey[400]),
        ],
      ),
    );
  }

  Widget _buildContactRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
  }) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Theme.of(context).primaryColor),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            if (onTap != null)
              Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  void _sendEmail(String email) async {
    final uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _makeCall(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  void _showAddTagDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Tag'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter tag name',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<ProfileProvider>().addTag(controller.text);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
