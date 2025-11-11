import 'package:exam_app/models/exam.dart';

final List<Exam> mockExams = [
  Exam(
    id: 1,
    subject: "Mathematics",
    time: DateTime(2025, 10, 15, 9, 0),
    rooms: ["A101", "A102"],
  ),
  Exam(
    id: 2,
    subject: "Physics",
    time: DateTime(2025, 10, 16, 14, 0),
    rooms: ["B201"],
  ),
  Exam(
    id: 3,
    subject: "Chemistry",
    time: DateTime(2025, 10, 17, 10, 30),
    rooms: ["C301", "C302"],
  ),
  Exam(
    id: 4,
    subject: "Biology",
    time: DateTime(2025, 10, 18, 13, 0),
    rooms: ["Lab1"],
  ),
  Exam(
    id: 5,
    subject: "English Literature",
    time: DateTime(2025, 10, 19, 9, 0),
    rooms: ["D101"],
  ),
  Exam(
    id: 6,
    subject: "History",
    time: DateTime(2025, 11, 20, 11, 0),
    rooms: ["E201"],
  ),
  Exam(
    id: 7,
    subject: "Geography",
    time: DateTime(2026, 3, 21, 15, 0),
    rooms: ["F101", "F102"],
  ),
  Exam(
    id: 8,
    subject: "Computer Science",
    time: DateTime(2026, 4, 22, 9, 30),
    rooms: ["Lab2", "Lab3"],
  ),
  Exam(
    id: 9,
    subject: "Economics",
    time: DateTime(2026, 5, 23, 14, 0),
    rooms: ["G301"],
  ),
  Exam(
    id: 10,
    subject: "Philosophy",
    time: DateTime(2026, 6, 24, 10, 0),
    rooms: ["H101"],
  ),
];