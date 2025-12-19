import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mynet_mobile/models/profile.dart';
import 'package:mynet_mobile/widgets/experience_tab.dart';
import 'package:mynet_mobile/widgets/education_tab.dart';
import 'package:mynet_mobile/widgets/skills_tab.dart';

void main() {
  group('ExperienceTab Tests', () {
    testWidgets('displays empty state when no experience',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExperienceTab(experience: []),
          ),
        ),
      );

      expect(find.text('No experience listed'), findsOneWidget);
      expect(find.byIcon(Icons.work_outline), findsOneWidget);
    });

    testWidgets('displays experience cards', (WidgetTester tester) async {
      final experiences = [
        Experience(
          id: '1',
          title: 'VP Engineering',
          company: 'TechCorp',
          startDate: DateTime(2020, 1, 1),
        ),
        Experience(
          id: '2',
          title: 'Director of Engineering',
          company: 'StartupX',
          startDate: DateTime(2017, 3, 1),
          endDate: DateTime(2019, 12, 31),
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExperienceTab(experience: experiences),
          ),
        ),
      );

      expect(find.text('VP Engineering'), findsOneWidget);
      expect(find.text('TechCorp'), findsOneWidget);
      expect(find.text('Director of Engineering'), findsOneWidget);
      expect(find.text('StartupX'), findsOneWidget);
    });

    testWidgets('displays current badge for current positions',
        (WidgetTester tester) async {
      final experiences = [
        Experience(
          id: '1',
          title: 'VP Engineering',
          company: 'TechCorp',
          startDate: DateTime(2020, 1, 1),
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExperienceTab(experience: experiences),
          ),
        ),
      );

      expect(find.text('Current'), findsOneWidget);
    });

    testWidgets('displays expandable description',
        (WidgetTester tester) async {
      final longDescription =
          'This is a very long description that exceeds 150 characters. ' *
              3;
      final experiences = [
        Experience(
          id: '1',
          title: 'VP Engineering',
          company: 'TechCorp',
          startDate: DateTime(2020, 1, 1),
          description: longDescription,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExperienceTab(experience: experiences),
          ),
        ),
      );

      // Check for show more button
      expect(find.text('Show more'), findsOneWidget);

      // Tap to expand
      await tester.tap(find.text('Show more'));
      await tester.pumpAndSettle();

      // Check for show less button
      expect(find.text('Show less'), findsOneWidget);
    });
  });

  group('EducationTab Tests', () {
    testWidgets('displays empty state when no education',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EducationTab(education: [], skills: []),
          ),
        ),
      );

      expect(find.text('No education listed'), findsOneWidget);
      expect(find.byIcon(Icons.school), findsOneWidget);
    });

    testWidgets('displays education cards', (WidgetTester tester) async {
      final education = [
        const Education(
          id: '1',
          school: 'Stanford University',
          degree: 'MS',
          fieldOfStudy: 'Computer Science',
          startYear: 2011,
          endYear: 2013,
        ),
        const Education(
          id: '2',
          school: 'MIT',
          degree: 'BS',
          fieldOfStudy: 'Electrical Engineering',
          startYear: 2007,
          endYear: 2011,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EducationTab(education: education, skills: const []),
          ),
        ),
      );

      expect(find.text('Stanford University'), findsOneWidget);
      expect(find.text('MS Computer Science'), findsOneWidget);
      expect(find.text('MIT'), findsOneWidget);
      expect(find.text('BS Electrical Engineering'), findsOneWidget);
    });

    testWidgets('displays grade if available', (WidgetTester tester) async {
      final education = [
        const Education(
          id: '1',
          school: 'Stanford University',
          degree: 'MS',
          fieldOfStudy: 'Computer Science',
          startYear: 2011,
          endYear: 2013,
          grade: '3.9 GPA',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EducationTab(education: education, skills: const []),
          ),
        ),
      );

      expect(find.text('3.9 GPA'), findsOneWidget);
    });
  });

  group('SkillsTab Tests', () {
    testWidgets('displays empty state when no skills',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SkillsTab(skills: []),
          ),
        ),
      );

      expect(find.text('No skills listed'), findsOneWidget);
      expect(find.byIcon(Icons.stars_outlined), findsOneWidget);
    });

    testWidgets('displays skill chips', (WidgetTester tester) async {
      const skills = [
        Skill(
          id: '1',
          name: 'Engineering Leadership',
          endorsements: 45,
          isTopSkill: true,
        ),
        Skill(
          id: '2',
          name: 'Python',
          endorsements: 28,
          isTopSkill: false,
        ),
      ];

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SkillsTab(skills: skills),
          ),
        ),
      );

      expect(find.text('Engineering Leadership'), findsOneWidget);
      expect(find.text('Python'), findsOneWidget);
    });

    testWidgets('displays top skills section separately',
        (WidgetTester tester) async {
      const skills = [
        Skill(
          id: '1',
          name: 'Engineering Leadership',
          endorsements: 45,
          isTopSkill: true,
        ),
        Skill(
          id: '2',
          name: 'Python',
          endorsements: 28,
          isTopSkill: false,
        ),
      ];

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SkillsTab(skills: skills),
          ),
        ),
      );

      expect(find.text('Top Skills'), findsOneWidget);
      expect(find.text('Skills'), findsOneWidget);
    });

    testWidgets('displays endorsement counts', (WidgetTester tester) async {
      const skills = [
        Skill(
          id: '1',
          name: 'Engineering Leadership',
          endorsements: 45,
          isTopSkill: true,
        ),
      ];

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SkillsTab(skills: skills),
          ),
        ),
      );

      expect(find.text('45'), findsOneWidget);
    });

    testWidgets('tapping skill shows snackbar', (WidgetTester tester) async {
      const skills = [
        Skill(
          id: '1',
          name: 'Engineering Leadership',
          endorsements: 45,
          isTopSkill: true,
        ),
      ];

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SkillsTab(skills: skills),
          ),
        ),
      );

      await tester.tap(find.text('Engineering Leadership'));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}
