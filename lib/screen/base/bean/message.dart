import 'dart:ui';

import 'package:flutter/material.dart';

class Message {
  final String messageText;
  final Color messageTextColor;
  final Color backgroundColor;

  Message.error({required this.messageText})
      : messageTextColor = Colors.white,
        backgroundColor = Colors.red;

  Message.success({required this.messageText})
      : messageTextColor = Colors.white,
        backgroundColor = Colors.green;

  Message.info({required this.messageText})
      : messageTextColor = Colors.black54,
        backgroundColor = Colors.white;

  Message.warning({required this.messageText})
      : messageTextColor = Colors.white,
        backgroundColor = Colors.orange;
}
