import 'package:flutter/material.dart';
import 'package:restaurant_app/commons/style.dart';

class ErrorMessage extends StatelessWidget {
  final String message;

  const ErrorMessage(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: primaryTextStyle.copyWith(
          fontSize: 16,
          fontWeight: semiBold,
        ),
      ),
    );
  }
}
