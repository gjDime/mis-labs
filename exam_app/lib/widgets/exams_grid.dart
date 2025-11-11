import 'package:exam_app/widgets/exams_card.dart';
import 'package:flutter/material.dart';

import '../models/exam.dart';

class ExamsGrid extends StatefulWidget {
  final List<Exam> exams;

  const ExamsGrid({super.key, required this.exams});

  @override
  State<StatefulWidget> createState() => _ExamsGridState();
}

class _ExamsGridState extends State<ExamsGrid> {
  late final sortedExams = [...widget.exams]
    ..sort((a, b) => a.time.compareTo(b.time));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          childAspectRatio: 200 / 244,
        ),
        itemCount: widget.exams.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ExamCard(exam: sortedExams[index]);
        },
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [Badge(label: Text("Exams: ${widget.exams.length}"))],
      ),
    );
  }
}
