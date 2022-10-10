// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:it_schedule/main.dart';
import 'package:it_schedule/widget/signup_widget.dart';

void main() {
  testWidgets('Sign Up Testing', (WidgetTester tester) async {
    final email = find.byKey(ValueKey("email"));
    final pass = find.byKey(ValueKey("password"));
    final confirm = find.byKey(ValueKey("confirm_pass"));
    final sign_up = find.byKey(ValueKey("sign_up"));

    await tester.pumpWidget(MaterialApp(home: MainPage()));
    await tester.enterText(email, "123@test.com");
    await tester.enterText(pass, "password");
    await tester.enterText(confirm, "password");
    await tester.pump();

    expect(find.text("123@test.com"), findsOneWidget);
  });

  testWidgets('Login Testing', (WidgetTester tester) async {
    final login = find.byKey(ValueKey("login_btn"));
    final email_login = find.byKey(ValueKey("email_login"));
    final password_login = find.byKey(ValueKey("password_login"));
    final account_login = find.byKey(ValueKey("_sign_in"));

    await tester.pumpWidget(MaterialApp(home: MainPage()));
    await tester.tap(login);
    await tester.enterText(email_login, "123@test.com");
    await tester.enterText(password_login, "password");
    await tester.tap(account_login);
    await tester.pump();

    expect(find.text("123@test.com"), findsOneWidget);
  });
}
