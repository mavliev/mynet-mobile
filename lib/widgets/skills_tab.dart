import 'package:flutter/material.dart';
import '../models/profile.dart';

/// Skills tab with chip cloud layout
class SkillsTab extends StatelessWidget {
  final List<Skill> skills;

  const SkillsTab({
    super.key,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    if (skills.isEmpty) {
      return _buildEmptyState(context);
    }

    // Separate top skills from other skills
    final topSkills = skills.where((s) => s.isTopSkill).toList();
    final otherSkills = skills.where((s) => !s.isTopSkill).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Top Skills Section
        if (topSkills.isNotEmpty) ...[
          _buildSectionHeader(context, 'Top Skills'),
          const SizedBox(height: 16),
          _buildSkillsCloud(context, topSkills, isTopSkills: true),
          const SizedBox(height: 24),
        ],

        // Other Skills Section
        if (otherSkills.isNotEmpty) ...[
          _buildSectionHeader(context, 'Skills'),
          const SizedBox(height: 16),
          _buildSkillsCloud(context, otherSkills, isTopSkills: false),
        ],
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.stars_outlined,
            size: 64,
            color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No skills listed',
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

  Widget _buildSkillsCloud(
    BuildContext context,
    List<Skill> skills, {
    required bool isTopSkills,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: skills.map((skill) {
        return _buildSkillChip(context, skill, isTopSkills);
      }).toList(),
    );
  }

  Widget _buildSkillChip(
    BuildContext context,
    Skill skill,
    bool isTopSkill,
  ) {
    final backgroundColor = isTopSkill
        ? Theme.of(context).primaryColor
        : Theme.of(context).primaryColor.withValues(alpha: 0.1);

    final textColor = isTopSkill ? Colors.white : Theme.of(context).primaryColor;

    return InkWell(
      onTap: () => _onSkillTapped(context, skill),
      child: Chip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              skill.name,
              style: TextStyle(
                color: textColor,
                fontWeight: isTopSkill ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            if (skill.endorsements > 0) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isTopSkill
                      ? Colors.white.withValues(alpha: 0.3)
                      : Theme.of(context).primaryColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${skill.endorsements}',
                  style: TextStyle(
                    fontSize: 11,
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
        backgroundColor: backgroundColor,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  void _onSkillTapped(BuildContext context, Skill skill) {
    // TODO: Implement filter by skill functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Filter by "${skill.name}" - Coming soon'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
