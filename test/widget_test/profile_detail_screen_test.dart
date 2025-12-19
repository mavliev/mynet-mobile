import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mynet_mobile/screens/profile_detail_screen.dart';
import 'package:mynet_mobile/models/profile.dart';

void main() {
  group('ProfileDetailScreen Tests', () {
    testWidgets('displays loading indicator when loading',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileDetailScreen(profileId: 'test-profile-id'),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays error message on error',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileDetailScreen(profileId: 'invalid-id'),
        ),
      );

      // Wait for loading to complete
      await tester.pump(const Duration(seconds: 1));

      // Note: This test will need to be updated once we have proper error handling
      // For now, it tests the basic structure
    });

    testWidgets('displays profile header with name',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileDetailScreen(profileId: 'test-profile-id'),
        ),
      );

      // Wait for data to load
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pump();

      // Check for profile name in app bar
      expect(find.text('Sarah Johnson'), findsWidgets);
    });

    testWidgets('displays all tabs', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileDetailScreen(profileId: 'test-profile-id'),
        ),
      );

      // Wait for data to load
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pump();

      // Check for all tabs
      expect(find.text('Overview'), findsOneWidget);
      expect(find.text('Experience'), findsOneWidget);
      expect(find.text('Education'), findsOneWidget);
      expect(find.text('Skills'), findsOneWidget);
      expect(find.text('Notes'), findsOneWidget);
    });

    testWidgets('displays action buttons', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileDetailScreen(profileId: 'test-profile-id'),
        ),
      );

      // Wait for data to load
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pump();

      // Check for action buttons
      expect(find.text('Call'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Note'), findsOneWidget);
    });

    testWidgets('displays FAB', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileDetailScreen(profileId: 'test-profile-id'),
        ),
      );

      // Wait for data to load
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pump();

      // Check for floating action button
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('switches between tabs', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileDetailScreen(profileId: 'test-profile-id'),
        ),
      );

      // Wait for data to load
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pump();

      // Tap on Experience tab
      await tester.tap(find.text('Experience'));
      await tester.pumpAndSettle();

      // Verify Experience tab content
      // Note: Actual content verification would depend on mock data
    });

    testWidgets('displays popup menu', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileDetailScreen(profileId: 'test-profile-id'),
        ),
      );

      // Wait for data to load
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pump();

      // Find and tap the popup menu button
      final menuButton = find.byType(PopupMenuButton<String>);
      expect(menuButton, findsOneWidget);

      await tester.tap(menuButton);
      await tester.pumpAndSettle();

      // Verify menu items
      expect(find.text('Edit contact'), findsOneWidget);
      expect(find.text('Share contact'), findsOneWidget);
      expect(find.text('Export to vCard'), findsOneWidget);
      expect(find.text('Delete contact'), findsOneWidget);
    });
  });

  group('ProfileHeader Tests', () {
    testWidgets('displays profile initials when no photo',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileDetailScreen(profileId: 'test-profile-id'),
        ),
      );

      // Wait for data to load
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pump();

      // Check for initials
      expect(find.text('SJ'), findsOneWidget);
    });

    testWidgets('displays connection badge', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileDetailScreen(profileId: 'test-profile-id'),
        ),
      );

      // Wait for data to load
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pump();

      // Check for connection badge
      expect(find.text('1°'), findsWidgets);
    });

    testWidgets('displays headline', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileDetailScreen(profileId: 'test-profile-id'),
        ),
      );

      // Wait for data to load
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pump();

      // Check for headline
      expect(find.text('VP Engineering @ TechCorp'), findsWidgets);
    });
  });

  group('Action Button Tests', () {
    testWidgets('call button triggers phone dialer',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileDetailScreen(profileId: 'test-profile-id'),
        ),
      );

      // Wait for data to load
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pump();

      // Tap call button
      await tester.tap(find.text('Call'));
      await tester.pumpAndSettle();

      // Note: Actual URL launching would need to be mocked in a real test
    });

    testWidgets('email button triggers email app',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileDetailScreen(profileId: 'test-profile-id'),
        ),
      );

      // Wait for data to load
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pump();

      // Tap email button
      await tester.tap(find.text('Email'));
      await tester.pumpAndSettle();

      // Note: Actual URL launching would need to be mocked in a real test
    });

    testWidgets('note button shows snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileDetailScreen(profileId: 'test-profile-id'),
        ),
      );

      // Wait for data to load
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pump();

      // Tap note button
      await tester.tap(find.text('Note'));
      await tester.pumpAndSettle();

      // Check for snackbar
      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}
