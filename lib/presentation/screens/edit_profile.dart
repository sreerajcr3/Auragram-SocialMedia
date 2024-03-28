import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              radius: 70,
            ),
          ),
          // TextformField(labelText: labelText, controller: controller, valueText: valueText)
        ],
      ),
    );
  }
}
