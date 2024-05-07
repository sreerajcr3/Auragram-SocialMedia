import 'package:aura/core/colors/colors.dart';
import 'package:aura/domain/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OwnMessage extends StatefulWidget {
  final Chat chat;
  const OwnMessage({super.key, required this.chat});

  @override
  State<OwnMessage> createState() => _OwnMessageState();
}

class _OwnMessageState extends State<OwnMessage> {
  @override
  void initState() {
    print("chat time =${widget.chat.createdAt}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(widget.chat.createdAt);

    // Format the DateTime object
    final formattedTime = DateFormat('hh:mm a');
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
            minWidth: MediaQuery.of(context).size.width - 255),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: Colors.blueAccent,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 85, top: 10, bottom: 18),
                child: Text(
                  widget.chat.message,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      formattedTime.format(
                          DateTime.parse(widget.chat.createdAt).toLocal()),
                      style: TextStyle(fontSize: 12),
                    ),
                    Icon(Icons.done)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserMessage extends StatelessWidget {
  final Chat chat;

  const UserMessage({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final formattedTime = DateFormat('hh:mm a');
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: kGrey,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 60, top: 10, bottom: 20),
                child: Text(
                  chat.message,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Text(
                  formattedTime
                      .format(DateTime.parse(chat.createdAt).toLocal()),
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class DateDivider extends StatelessWidget {
  final DateTime date;

  const DateDivider({required this.date, super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isToday = date.year == now.year && date.month == now.month && date.day == now.day;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        isToday? 'Today' : DateFormat.yMMMd().format(date),
        style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold, color: Colors.black),
     ),
);
}
}