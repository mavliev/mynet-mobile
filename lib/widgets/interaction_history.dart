import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/interaction.dart';

/// Interaction history widget with timeline view
class InteractionHistory extends StatefulWidget {
  final List<Interaction> interactions;

  const InteractionHistory({
    super.key,
    required this.interactions,
  });

  @override
  State<InteractionHistory> createState() => _InteractionHistoryState();
}

class _InteractionHistoryState extends State<InteractionHistory> {
  final Map<String, bool> _expandedStates = {};

  @override
  Widget build(BuildContext context) {
    if (widget.interactions.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.interactions.length,
      itemBuilder: (context, index) {
        final interaction = widget.interactions[index];
        final isLast = index == widget.interactions.length - 1;
        return _buildInteractionItem(context, interaction, isLast);
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.timeline,
            size: 64,
            color: Theme.of(context).primaryColor.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No interactions yet',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionItem(
    BuildContext context,
    Interaction interaction,
    bool isLast,
  ) {
    final isExpanded = _expandedStates[interaction.id] ?? false;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline
          Column(
            children: [
              // Timeline icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(interaction.typeColor).withOpacity(0.2),
                ),
                child: Center(
                  child: Text(
                    interaction.typeIcon,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              // Timeline line
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.grey[300],
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),

          // Interaction content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 24),
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: Color(interaction.typeColor).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _expandedStates[interaction.id] = !isExpanded;
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                interaction.summary ??
                                    _getDefaultSummary(interaction.type),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            if (interaction.details != null)
                              Icon(
                                isExpanded
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                color: Colors.grey[600],
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),

                        // Timestamp
                        Text(
                          timeago.format(interaction.timestamp),
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                        ),

                        // Location
                        if (interaction.location != null) ...[
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  size: 14, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text(
                                interaction.location!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                              ),
                            ],
                          ),
                        ],

                        // Details (expandable)
                        if (isExpanded && interaction.details != null) ...[
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              interaction.details!,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getDefaultSummary(InteractionType type) {
    switch (type) {
      case InteractionType.call:
        return 'Phone call';
      case InteractionType.email:
        return 'Email exchange';
      case InteractionType.meeting:
        return 'Meeting';
      case InteractionType.message:
        return 'Message';
      case InteractionType.note:
        return 'Note';
    }
  }
}
