import 'package:flutter/material.dart';

import '../models/exam.dart';
import '../widgets/detail_data.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final exam = ModalRoute.of(context)!.settings.arguments as Exam;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("${exam.subject} exam"),
        centerTitle: true,
      ),
      body: DetailData(exam: exam),
    );
  }
}
