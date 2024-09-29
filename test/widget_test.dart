// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:my_first_app/main.dart';
import 'package:my_first_app/services/models.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const App());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });
  try {
    googleLogin();
  } catch (e) {
    print("Error in google login: $e");
  }
  try {
    anonLogin();
  } catch (e) {
    print("Error in anon login: $e");
  }
  getTopics().then((topics) {
    expect(topics.isNotEmpty, true);
  }).catchError((e) {
    print("Error when getting topics: $e");
  });
  
}

Future<void> googleLogin() async {
  try {
    final googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) return;

    final googleAuth = await googleUser.authentication;
    final authCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(authCredential);
  } on FirebaseAuthException catch (_) {
    rethrow;
    // handle error
  }
}

Future<void> anonLogin() async {
  try {
    await FirebaseAuth.instance.signInAnonymously();
  } on FirebaseAuthException {
    rethrow;
    // handle error
  }
}

Future<List<Topic>> getTopics() async {
  var ref = FirebaseFirestore.instance.collection('topics');
  var snapshot = await ref.get();
  var data = snapshot.docs.map((s) => s.data());
  var topics = data.map((d) => Topic.fromJson(d));
  return topics.toList();
}