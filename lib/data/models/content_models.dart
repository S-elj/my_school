import 'package:cloud_firestore/cloud_firestore.dart';

enum ContentType { video, document, presentation, qcm, questionAnswer }

class Course {
  final String id;
  final String title;
  final String description;
  final String subject;
  final String gradeLevel;
  final List<Content> contents;
  final DateTime createdAt;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.subject,
    required this.gradeLevel,
    required this.contents,
    required this.createdAt,
  });

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      subject: map['subject'],
      gradeLevel: map['gradeLevel'],
      contents: (map['contents'] as List)
          .map((content) => Content.fromMap(content))
          .toList(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}

class Content {
  final String id;
  final String title;
  final ContentType type;
  final String url;
  final String? description;
  final Duration? duration; // Pour les vidéos

  Content({
    required this.id,
    required this.title,
    required this.type,
    required this.url,
    this.description,
    this.duration,
  });

  factory Content.fromMap(Map<String, dynamic> map) {
    return Content(
      id: map['id'],
      title: map['title'],
      type: ContentType.values.firstWhere((e) => e.toString() == map['type']),
      url: map['url'],
      description: map['description'],
      duration: map['duration'] != null
          ? Duration(seconds: map['duration'])
          : null,
    );
  }
}

class Exercise {
  final String id;
  final String title;
  final String subject;
  final String gradeLevel;
  final ExerciseType type;
  final List<Question> questions;

  Exercise({
    required this.id,
    required this.title,
    required this.subject,
    required this.gradeLevel,
    required this.type,
    required this.questions,
  });
}

enum ExerciseType { qcm, questionAnswer }

class Question {
  final String id;
  final String question;
  final List<String> options; // Pour les QCM
  final String correctAnswer;
  final String? explanation;

  Question({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.explanation,
  });
}

class ActivityHistory {
  final String id;
  final String contentId;
  final String contentTitle;
  final ContentType contentType;
  final DateTime startTime;
  final DateTime? endTime;
  final double? progress;
  final int? score;

  ActivityHistory({
    required this.id,
    required this.contentId,
    required this.contentTitle,
    required this.contentType,
    required this.startTime,
    this.endTime,
    this.progress,
    this.score,
  });
}