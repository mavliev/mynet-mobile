import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mynet_mobile/main.dart' as app;

/// Integration test for the search flow
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Search Flow Integration Tests', () {
    testWidgets('complete search and filter flow', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Verify home screen is displayed
      expect(find.text('myNET'), findsOneWidget);

      // Verify initial contacts are displayed
      expect(find.text('Sarah Johnson'), findsOneWidget);
      expect(find.text('Michael Chen'), findsOneWidget);

      // Test search functionality
      final searchField = find.byType(TextField).first;
      await tester.tap(searchField);
      await tester.pumpAndSettle();

      // Enter search query
      await tester.enterText(searchField, 'Sarah');
      await tester.pumpAndSettle(const Duration(milliseconds: 500)); // Wait for debounce

      // Verify search results
      expect(find.text('Sarah Johnson'), findsOneWidget);
      expect(find.text('Michael Chen'), findsNothing);

      // Clear search
      final clearButton = find.byIcon(Icons.clear);
      await tester.tap(clearButton);
      await tester.pumpAndSettle();

      // Verify all contacts are shown again
      expect(find.text('Sarah Johnson'), findsOneWidget);
      expect(find.text('Michael Chen'), findsOneWidget);
    });

    testWidgets('filter by connection degree', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Tap on 1st degree filter chip
      final firstDegreeChip = find.text('1°');
      await tester.tap(firstDegreeChip);
      await tester.pumpAndSettle();

      // Verify only 1st degree connections are shown
      expect(find.text('Sarah Johnson'), findsOneWidget); // 1st degree
      expect(find.text('Michael Chen'), findsNothing); // 2nd degree

      // Tap again to deselect
      await tester.tap(firstDegreeChip);
      await tester.pumpAndSettle();

      // Verify all contacts are shown again
      expect(find.text('Sarah Johnson'), findsOneWidget);
      expect(find.text('Michael Chen'), findsOneWidget);
    });

    testWidgets('open and use advanced filters', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Open filter bottom sheet
      final filterButton = find.byIcon(Icons.filter_list);
      await tester.tap(filterButton);
      await tester.pumpAndSettle();

      // Verify bottom sheet is displayed
      expect(find.text('Filters'), findsOneWidget);

      // Select a company filter
      final techCorpCheckbox = find.text('TechCorp');
      await tester.tap(techCorpCheckbox);
      await tester.pumpAndSettle();

      // Apply filters
      final applyButton = find.text('Apply');
      await tester.tap(applyButton);
      await tester.pumpAndSettle();

      // Verify filtered results
      expect(find.text('Sarah Johnson'), findsOneWidget); // Works at TechCorp
      expect(find.text('Michael Chen'), findsNothing); // Works at StartupX

      // Verify filter badge is shown
      expect(find.text('1'), findsWidgets); // Filter count badge
    });

    testWidgets('pull to refresh', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Perform pull-to-refresh gesture
      await tester.fling(
        find.byType(ListView),
        const Offset(0, 300),
        1000,
      );
      await tester.pumpAndSettle();

      // Verify refresh indicator appears
      expect(find.byType(RefreshIndicator), findsOneWidget);

      // Wait for refresh to complete
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify success message
      expect(find.text('Contacts synced'), findsOneWidget);
    });

    testWidgets('tap contact card', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Tap on a contact card
      final sarahCard = find.text('Sarah Johnson');
      await tester.tap(sarahCard);
      await tester.pumpAndSettle();

      // Verify navigation action (placeholder message)
      expect(find.textContaining('Opening profile'), findsOneWidget);
    });

    testWidgets('long press contact card for quick actions', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Long press on a contact card
      final sarahCard = find.text('Sarah Johnson');
      await tester.longPress(sarahCard);
      await tester.pumpAndSettle();

      // Verify quick actions menu appears
      expect(find.text('Call'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Add Note'), findsOneWidget);

      // Tap Call action
      await tester.tap(find.text('Call'));
      await tester.pumpAndSettle();

      // Verify call action triggered
      expect(find.textContaining('Calling'), findsOneWidget);
    });

    testWidgets('sort contacts', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Tap on sort dropdown
      final sortDropdown = find.textContaining('Sort:');
      await tester.tap(sortDropdown);
      await tester.pumpAndSettle();

      // Select "Name (A-Z)" option
      final nameAscOption = find.text('Name (A-Z)');
      await tester.tap(nameAscOption);
      await tester.pumpAndSettle();

      // Verify sort option is selected
      expect(find.text('Sort: Name (A-Z)'), findsOneWidget);
    });

    testWidgets('tap FAB to add contact', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Tap FAB
      final fab = find.byType(FloatingActionButton);
      await tester.tap(fab);
      await tester.pumpAndSettle();

      // Verify add contact action (placeholder message)
      expect(find.text('Add Contact (not yet implemented)'), findsOneWidget);
    });

    testWidgets('empty state when no results', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Search for non-existent contact
      final searchField = find.byType(TextField).first;
      await tester.tap(searchField);
      await tester.pumpAndSettle();

      await tester.enterText(searchField, 'NonExistentContact');
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // Verify empty state is shown
      expect(find.text('No contacts match your search'), findsOneWidget);
      expect(find.byIcon(Icons.search_off), findsOneWidget);

      // Verify clear filters button
      final clearButton = find.text('Clear filters');
      expect(clearButton, findsOneWidget);

      // Tap clear filters
      await tester.tap(clearButton);
      await tester.pumpAndSettle();

      // Verify all contacts are shown again
      expect(find.text('Sarah Johnson'), findsOneWidget);
    });

    testWidgets('scroll through contact list', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify initial contacts are visible
      expect(find.text('Sarah Johnson'), findsOneWidget);

      // Scroll down
      await tester.drag(
        find.byType(ListView),
        const Offset(0, -300),
      );
      await tester.pumpAndSettle();

      // Verify scrolling worked (filter chips may hide)
      expect(find.byType(ListView), findsOneWidget);

      // Scroll back up
      await tester.drag(
        find.byType(ListView),
        const Offset(0, 300),
      );
      await tester.pumpAndSettle();

      // Verify filter chips reappear
      expect(find.text('1°'), findsOneWidget);
    });
  });
}
