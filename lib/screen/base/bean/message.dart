import 'dart:ui';

import 'package:flutter/material.dart';

class Message {
  final String messageText;
  final Color messageTextColor;
  final Color backgroundColor;

  Message.error({required this.messageText})
      : this.messageTextColor = Colors.white,
        this.backgroundColor = Colors.red;

  Message.success({required this.messageText})
      : this.messageTextColor = Colors.white,
        this.backgroundColor = Colors.green;

  Message.info({required this.messageText})
      : this.messageTextColor = Colors.black54,
        this.backgroundColor = Colors.white;

  Message.warning({required this.messageText})
      : this.messageTextColor = Colors.white,
        this.backgroundColor = Colors.orange;
}
