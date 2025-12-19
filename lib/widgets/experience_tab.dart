import 'package:flutter/material.dart';
import '../models/profile.dart';

/// Experience tab with timeline layout
class ExperienceTab extends StatelessWidget {
  final List<Experience> experience;

  const ExperienceTab({
    super.key,
    required this.experience,
  });

  @override
  Widget build(BuildContext context) {
    if (experience.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Experience Timeline
        _buildSectionHeader(context, 'Work Experience'),
        const SizedBox(height: 16),
        _buildExperienceTimeline(context),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.work_outline,
            size: 64,
            color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No experience listed',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildExperienceTimeline(BuildContext context) {
    return Column(
      children: experience.asMap().entries.map((entry) {
        final index = entry.key;
        final exp = entry.value;
        final isLast = index == experience.length - 1;

        return _buildExperienceCard(context, exp, isLast);
      }).toList(),
    );
  }

  Widget _buildExperienceCard(
    BuildContext context,
    Experience exp,
    bool isLast,
  ) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline
          Column(
            children: [
              // Timeline dot
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: exp.isCurrent
                      ? Theme.of(context).primaryColor
                      : Colors.grey[400],
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
              // Timeline line
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.grey[300],
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),

          // Card content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 24),
              child: _buildExperienceContent(context, exp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceContent(BuildContext context, Experience exp) {
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
            // Position title
            Text(
              exp.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),

            // Company with logo placeholder
            Row(
              children: [
                // Company logo placeholder
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: exp.companyLogoUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            exp.companyLogoUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.business,
                                size: 20,
                                color: Colors.grey[400],
                              );
                            },
                          ),
                        )
                      : Icon(
                          Icons.business,
                          size: 20,
                          color: Colors.grey[400],
                        ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    exp.company,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                if (exp.isCurrent)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Current',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),

            // Date range and duration
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  exp.dateRange,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(width: 8),
                Text(
                  '(${exp.duration})',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),

            // Location
            if (exp.location != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    exp.location!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ],

            // Description (expandable)
            if (exp.description != null) ...[
              const SizedBox(height: 12),
              _ExpandableText(text: exp.description!),
            ],
          ],
        ),
      ),
    );
  }
}

/// Expandable text widget for descriptions
class _ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;

  const _ExpandableText({
    required this.text,
    this.maxLines = 3,
  });

  @override
  State<_ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<_ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: Theme.of(context).textTheme.bodyMedium,
          maxLines: _isExpanded ? null : widget.maxLines,
          overflow: _isExpanded ? null : TextOverflow.ellipsis,
        ),
        if (widget.text.length > 150) ...[
          const SizedBox(height: 4),
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(
              _isExpanded ? 'Show less' : 'Show more',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
