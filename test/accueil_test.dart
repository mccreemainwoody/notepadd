// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

//import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:notepadd/main.dart';

void main() {
  testWidgets('Le build de l\'acceuil réussit', (WidgetTester tester) async{
    await tester.pumpWidget(const NotepaddMainApp());
    expect(find.text('Notepad+++'), findsOneWidget);
    expect(find.text('Notes'), findsOneWidget);
    expect(find.text('Tâches'), findsOneWidget);
    expect(find.text('Calendrier'), findsOneWidget);
  });

  /*
  testWidgets('Le bouton Notes amène à l\'application Notes', (WidgetTester tester) async{
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Notes'));
    await tester.pumpAndSettle();
    expect(find.text('Notes'), findsOneWidget);
  });

  testWidgets('Le bouton Tâches amène à l\'application Tâches', (WidgetTester tester) async{
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Tâches'));
    await tester.pumpAndSettle();
    expect(find.text('Tâches'), findsOneWidget);
  });

  testWidgets('Le bouton Calendrier amène à l\'application Calendrier', (WidgetTester tester) async{
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Calendrier'));
    await tester.pumpAndSettle();
    expect(find.text('Calendrier'), findsOneWidget);
  });
   */
}
