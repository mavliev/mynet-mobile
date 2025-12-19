import 'package:flutter/material.dart';
import '../models/contact.dart';
import '../theme/app_theme.dart';

/// A card displaying contact information with 88dp height
/// Supports tap to view profile, swipe right to call, swipe left to email
class ContactCard extends StatelessWidget {
  final Contact contact;
  final VoidCallback? onTap;
  final VoidCallback? onCall;
  final VoidCallback? onEmail;
  final VoidCallback? onLongPress;

  const ContactCard({
    super.key,
    required this.contact,
    this.onTap,
    this.onCall,
    this.onEmail,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('contact_${contact.id}'),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd && onCall != null) {
          // Swipe right to call
          onCall!();
          return false; // Don't actually dismiss
        } else if (direction == DismissDirection.endToStart && onEmail != null) {
          // Swipe left to email
          onEmail!();
          return false; // Don't actually dismiss
        }
        return false;
      },
      background: _buildSwipeBackground(
        context,
        alignment: Alignment.centerLeft,
        icon: Icons.phone,
        label: 'Call',
        color: AppTheme.success,
      ),
      secondaryBackground: _buildSwipeBackground(
        context,
        alignment: Alignment.centerRight,
        icon: Icons.email,
        label: 'Email',
        color: AppTheme.info,
      ),
      child: Card(
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
          child: Container(
            height: 88,
            padding: const EdgeInsets.all(AppTheme.space4),
            child: Row(
              children: [
                // Avatar
                _buildAvatar(context),
                const SizedBox(width: AppTheme.space3),
                // Contact info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Name and connection degree
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              contact.fullName,
                              style: Theme.of(context).textTheme.titleLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: AppTheme.space2),
                          _buildConnectionBadge(context),
                        ],
                      ),
                      const SizedBox(height: AppTheme.space1),
                      // Headline
                      if (contact.headline != null) ...[
                        Text(
                          contact.headline!,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: AppTheme.space1),
                      ],
                      // Company name
                      if (contact.company != null) ...[
                        Text(
                          contact.company!,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: AppTheme.space1),
                      ],
                      // Location and last contact
                      Row(
                        children: [
                          if (contact.location != null) ...[
                            Icon(
                              Icons.location_on,
                              size: 12,
                              color: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.color
                                  ?.withOpacity(0.6),
                            ),
                            const SizedBox(width: AppTheme.space1),
                            Text(
                              contact.location!,
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.color
                                        ?.withOpacity(0.6),
                                  ),
                            ),
                            const SizedBox(width: AppTheme.space2),
                          ],
                          Text(
                            '• ${contact.timeSinceLastInteraction}',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.color
                                      ?.withOpacity(0.6),
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return CircleAvatar(
      radius: AppTheme.avatarSize / 2,
      backgroundColor: contact.connectionDegree.color.withOpacity(0.2),
      foregroundColor: contact.connectionDegree.color,
      backgroundImage: contact.avatarUrl != null ? NetworkImage(contact.avatarUrl!) : null,
      child: contact.avatarUrl == null
          ? Text(
              contact.initials,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: contact.connectionDegree.color,
                    fontWeight: FontWeight.w600,
                  ),
            )
          : null,
    );
  }

  Widget _buildConnectionBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.space2,
        vertical: AppTheme.space1,
      ),
      decoration: BoxDecoration(
        color: contact.connectionDegree.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusExtraLarge),
        border: Border.all(
          color: contact.connectionDegree.color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        contact.connectionDegree.label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: contact.connectionDegree.color,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Widget _buildSwipeBackground(
    BuildContext context, {
    required Alignment alignment,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      alignment: alignment,
      color: color.withOpacity(0.1),
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.space5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: AppTheme.iconSize),
          const SizedBox(height: AppTheme.space1),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
