// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:it_schedule/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Sign Up Testing', (WidgetTester tester) async {
    final email = find.byKey(const ValueKey("email"));
    final pass = find.byKey(const ValueKey("password"));
    final confirm = find.byKey(const ValueKey("confirm_pass"));
    // final sign_up = find.byKey(const ValueKey("sign_up"));

    await tester.pumpWidget(MaterialApp(home: MainPage()));
    await tester.enterText(email, "123@test.com");
    await tester.enterText(pass, "password");
    await tester.enterText(confirm, "password");
    await tester.pump();

    expect(find.text("123@test.com"), findsOneWidget);
  });

  testWidgets('Login Testing', (WidgetTester tester) async {
    final login = find.byKey(const ValueKey("login_btn"));
    final emailLogin = find.byKey(const ValueKey("email_login"));
    final passwordLogin = find.byKey(const ValueKey("password_login"));
    final accountLogin = find.byKey(const ValueKey("_sign_in"));

    await tester.pumpWidget(MaterialApp(home: MainPage()));
    await tester.tap(login);
    await tester.enterText(emailLogin, "123@test.com");
    await tester.enterText(passwordLogin, "password");
    await tester.tap(accountLogin);
    await tester.pump();

    expect(find.text("123@test.com"), findsOneWidget);
  });

  testWidgets('Student Login', (WidgetTester tester) async {
    final login = find.byKey(const ValueKey("login_btn"));
    final emailLogin = find.byKey(const ValueKey("email_login"));
    final passwordLogin = find.byKey(const ValueKey("password_login"));
    final accountLogin = find.byKey(const ValueKey("_sign_in"));

    await tester.pumpWidget(MaterialApp(home: MainPage()));
    await tester.tap(login);
    await tester.enterText(emailLogin, "student@test.com");
    await tester.enterText(passwordLogin, "password");
    await tester.tap(accountLogin);
    await tester.pump();

    expect(find.text("Month"), findsOneWidget);
  });

  testWidgets('Manager Login', (WidgetTester tester) async {
    final login = find.byKey(const ValueKey("login_btn"));
    final emailLogin = find.byKey(const ValueKey("email_login"));
    final passwordLogin = find.byKey(const ValueKey("password_login"));
    final accountLogin = find.byKey(const ValueKey("_sign_in"));

    await tester.pumpWidget(MaterialApp(home: MainPage()));
    await tester.tap(login);
    await tester.enterText(emailLogin, "admin@test.com");
    await tester.enterText(passwordLogin, "password");
    await tester.tap(accountLogin);
    await tester.pump();

    expect(find.text("Edinburg"), findsOneWidget);
  });

  testWidgets('Manager Edit Shift', (WidgetTester tester) async {
    final login = find.byKey(const ValueKey("login_btn"));
    final emailLogin = find.byKey(const ValueKey("email_login"));
    final passwordLogin = find.byKey(const ValueKey("password_login"));
    final accountLogin = find.byKey(const ValueKey("_sign_in"));

    await tester.pumpWidget(MaterialApp(home: MainPage()));
    await tester.tap(login);
    await tester.enterText(emailLogin, "admin@test.com");
    await tester.enterText(passwordLogin, "password");
    await tester.tap(accountLogin);
    await tester.pump();
  });
}
