import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/main.dart';

void main() {
  testWidgets('Todos List', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.byElementType(CircularProgressIndicator), findsOneWidget);
  });
}
