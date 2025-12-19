import 'package:flutter/material.dart';
import '../models/profile.dart';

/// Education tab with school cards and skills
class EducationTab extends StatelessWidget {
  final List<Education> education;
  final List<Skill> skills;

  const EducationTab({
    super.key,
    required this.education,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Education Section
        if (education.isNotEmpty) ...[
          _buildSectionHeader(context, 'Education'),
          const SizedBox(height: 16),
          ...education.map((edu) => _buildEducationCard(context, edu)),
        ] else
          _buildEmptyState(context, 'No education listed', Icons.school),
      ],
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

  Widget _buildEmptyState(
    BuildContext context,
    String message,
    IconData icon,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: Theme.of(context).primaryColor.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationCard(BuildContext context, Education edu) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // School with logo
            Row(
              children: [
                // School logo placeholder
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: edu.schoolLogoUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            edu.schoolLogoUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.school,
                                size: 28,
                                color: Colors.grey[400],
                              );
                            },
                          ),
                        )
                      : Icon(
                          Icons.school,
                          size: 28,
                          color: Colors.grey[400],
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        edu.school,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      if (edu.degreeText.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          edu.degreeText,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Years
            if (edu.years.isNotEmpty)
              Row(
                children: [
                  Icon(Icons.calendar_today,
                      size: 14, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    edu.years,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),

            // Grade
            if (edu.grade != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.grade, size: 14, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    edu.grade!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ],

            // Activities (expandable)
            if (edu.activities != null) ...[
              const SizedBox(height: 12),
              _ExpandableText(
                text: edu.activities!,
                title: 'Activities and societies',
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Expandable text widget with title
class _ExpandableText extends StatefulWidget {
  final String text;
  final String title;
  final int maxLines;

  const _ExpandableText({
    required this.text,
    required this.title,
    this.maxLines = 2,
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
          widget.title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          widget.text,
          style: Theme.of(context).textTheme.bodyMedium,
          maxLines: _isExpanded ? null : widget.maxLines,
          overflow: _isExpanded ? null : TextOverflow.ellipsis,
        ),
        if (widget.text.length > 100) ...[
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
                fontSize: 12,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
