import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/profile.dart';
import 'package:timeago/timeago.dart' as timeago;

/// Profile header widget with photo, name, headline, and connection info
class ProfileHeader extends StatelessWidget {
  final Profile profile;
  final String? heroTag;

  const ProfileHeader({
    super.key,
    required this.profile,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          // Profile photo
          _buildProfilePhoto(context),
          const SizedBox(height: 12),

          // Name
          Text(
            profile.fullName,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // Headline and connection degree
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  profile.headline ?? '',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              _buildConnectionBadge(context),
            ],
          ),

          // Location
          if (profile.location != null) ...[
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on,
                    size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  profile.location!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ],

          // Connection info
          const SizedBox(height: 16),
          _buildConnectionInfo(context),

          // LinkedIn profile link
          if (profile.linkedinUrl != null) ...[
            const SizedBox(height: 12),
            _buildLinkedInButton(context),
          ],
        ],
      ),
    );
  }

  Widget _buildProfilePhoto(BuildContext context) {
    final photoWidget = Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 3,
        ),
      ),
      child: ClipOval(
        child: profile.photoUrl != null
            ? CachedNetworkImage(
                imageUrl: profile.photoUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => _buildInitialsAvatar(context),
              )
            : _buildInitialsAvatar(context),
      ),
    );

    if (heroTag != null) {
      return Hero(
        tag: heroTag!,
        child: photoWidget,
      );
    }

    return photoWidget;
  }

  Widget _buildInitialsAvatar(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Text(
          profile.initials,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildConnectionBadge(BuildContext context) {
    Color badgeColor;
    switch (profile.connectionDegree) {
      case 1:
        badgeColor = const Color(0xFF4CAF50); // Green
        break;
      case 2:
        badgeColor = const Color(0xFF2196F3); // Blue
        break;
      case 3:
        badgeColor = const Color(0xFF9E9E9E); // Grey
        break;
      default:
        badgeColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        profile.connectionBadge,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildConnectionInfo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Connected date
        if (profile.connectedDate != null)
          _buildInfoChip(
            context,
            icon: Icons.link,
            label: 'Connected ${timeago.format(profile.connectedDate!)}',
          ),

        // Mutual connections
        if (profile.mutualConnections > 0)
          _buildInfoChip(
            context,
            icon: Icons.people,
            label: '${profile.mutualConnections} mutual',
          ),

        // Last contact
        if (profile.lastContactDate != null)
          _buildInfoChip(
            context,
            icon: Icons.schedule,
            label: 'Last contact ${timeago.format(profile.lastContactDate!)}',
          ),
      ],
    );
  }

  Widget _buildInfoChip(
    BuildContext context, {
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey[700]),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkedInButton(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => _openLinkedIn(),
      icon: const Icon(Icons.link, size: 18),
      label: const Text('View LinkedIn Profile'),
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF0077B5), // LinkedIn blue
        side: const BorderSide(color: Color(0xFF0077B5)),
      ),
    );
  }

  void _openLinkedIn() async {
    if (profile.linkedinUrl == null) return;

    final uri = Uri.parse(profile.linkedinUrl!);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
