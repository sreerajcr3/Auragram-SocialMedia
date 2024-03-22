import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Date extends StatelessWidget {
  final String date;
  const Date({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(date);

    DateFormat formattedDate = DateFormat.yMMMd();
    String finaldate = formattedDate.format(dateTime);

    return Text(
      finaldate,
      style: TextStyle(color: Colors.blueGrey, fontSize: 12),
    );
  }
}