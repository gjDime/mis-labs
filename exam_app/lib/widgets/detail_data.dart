import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/exam.dart';

class DetailData extends StatelessWidget {
  final Exam exam;

  const DetailData({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Exam Information',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _infoRow(Icon(Icons.subject), 'Subject', exam.subject),
          _infoRow(
            Icon(Icons.date_range),
            'Date',
            DateFormat('dd:MM:yyyy HH:mm').format(exam.time),
          ),
          _infoRow(Icon(Icons.meeting_room), 'Rooms', exam.rooms.join(', ')),
          _infoRow(Icon(Icons.timelapse), 'Time left', _timeLeft(exam.time)),
        ],
      ),
    );
  }

  String _timeLeft(DateTime time) {
    final duration = time.difference(DateTime.now());
  
    final days = duration.inDays;
    final hours = duration.inHours % 24;

    return '$days Дена $hours Часа';
  }

  Widget _infoRow(Icon icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: Colors.grey.shade700),
          ),
          color: Colors.grey.shade900,
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: icon,
                  ),
                  Text(
                    label,
                    style: const TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ],
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
