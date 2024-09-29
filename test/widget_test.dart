// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/services/models.dart';

void main() {
  getTopics().then((topics) {
    if (topics.isEmpty) {
      return;
    }
    var topic = topics.firstWhere((val) => val.id == "angular");
    expect(topic.id, "angular"); // redundant
    expect(topic.img, "angular.png");
    if (topic.quizzes.isEmpty) {
      return;
    }
    var quiz = topic.quizzes.firstWhere((val) => val.id == "angular-basics");
    getQuiz(quiz.id).then((value) {
      expect(value.description,
          "Angular is a platform for building large-scale JavaScript applications ");
    }).catchError((e) {
      print("Error: $e");
    });
    
  }).catchError((e) {
    print("Error: $e");
  });
}

Future<List<Topic>> getTopics() async {
  var ref = FirebaseFirestore.instance.collection('topics');
  var snapshot = await ref.get();
  var data = snapshot.docs.map((s) => s.data());
  var topics = data.map((d) => Topic.fromJson(d));
  return topics.toList();
}

Future<Quiz> getQuiz(String quizId) async {
  var ref = FirebaseFirestore.instance.collection('quizzes').doc(quizId);
  var snapshot = await ref.get();
  return Quiz.fromJson(snapshot.data() ?? {});
}
