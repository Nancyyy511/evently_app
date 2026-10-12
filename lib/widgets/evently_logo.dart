import 'package:evently_app/common/app_data.dart';
import 'package:flutter/material.dart';

class EventlyLogo extends StatelessWidget {
  const EventlyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(AppData.evently, width: 142, height: 26);
  }
}
