import 'dart:ui';

import 'package:flutter/material.dart';

class Message {
  final String messageText;
  final Color messageTextColor;
  final Color backgroundColor;

  Message({
    required this.messageText,
    this.messageTextColor = Colors.white,
    this.backgroundColor = Colors.redAccent,
  });
}
