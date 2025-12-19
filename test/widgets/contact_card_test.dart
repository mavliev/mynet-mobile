import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toyounet/models/connection_degree.dart';
import 'package:toyounet/models/contact.dart';
import 'package:toyounet/widgets/contact_card.dart';

void main() {
  group('ContactCard Widget Tests', () {
    late Contact testContact;

    setUp(() {
      testContact = Contact(
        id: '1',
        firstName: 'Sarah',
        lastName: 'Johnson',
        headline: 'VP Engineering',
        company: 'TechCorp',
        location: 'San Francisco',
        connectionDegree: ConnectionDegree.first,
        lastInteractionDate: DateTime.now().subtract(const Duration(days: 3)),
        email: 'sarah.j@techcorp.com',
        phone: '+1 (555) 123-4567',
        tags: ['Engineering', 'Leadership'],
      );
    });

    testWidgets('displays contact name', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContactCard(contact: testContact),
          ),
        ),
      );

      expect(find.text('Sarah Johnson'), findsOneWidget);
    });

    testWidgets('displays contact headline', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContactCard(contact: testContact),
          ),
        ),
      );

      expect(find.text('VP Engineering'), findsOneWidget);
    });

    testWidgets('displays contact company', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContactCard(contact: testContact),
          ),
        ),
      );

      expect(find.text('TechCorp'), findsOneWidget);
    });

    testWidgets('displays connection degree badge', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContactCard(contact: testContact),
          ),
        ),
      );

      expect(find.text('1°'), findsOneWidget);
    });

    testWidgets('displays avatar with initials when no image', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContactCard(contact: testContact),
          ),
        ),
      );

      expect(find.text('SJ'), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContactCard(
              contact: testContact,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pump();

      expect(tapped, true);
    });

    testWidgets('calls onLongPress when long pressed', (WidgetTester tester) async {
      bool longPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContactCard(
              contact: testContact,
              onLongPress: () => longPressed = true,
            ),
          ),
        ),
      );

      await tester.longPress(find.byType(InkWell));
      await tester.pump();

      expect(longPressed, true);
    });

    testWidgets('handles contact without headline', (WidgetTester tester) async {
      final contactWithoutHeadline = testContact.copyWith(headline: null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContactCard(contact: contactWithoutHeadline),
          ),
        ),
      );

      expect(find.text('VP Engineering'), findsNothing);
      expect(find.text('Sarah Johnson'), findsOneWidget);
    });

    testWidgets('handles contact without company', (WidgetTester tester) async {
      final contactWithoutCompany = testContact.copyWith(company: null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContactCard(contact: contactWithoutCompany),
          ),
        ),
      );

      expect(find.text('TechCorp'), findsNothing);
      expect(find.text('Sarah Johnson'), findsOneWidget);
    });

    testWidgets('displays time since last interaction', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContactCard(contact: testContact),
          ),
        ),
      );

      // Just verify some time text is present
      expect(find.textContaining('ago'), findsAtLeastNWidgets(1));
    });
  });
}
