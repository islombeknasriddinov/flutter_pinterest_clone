import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/common/enum.dart';

class Message {
  final String messageText;
  final Color messageTextColor;
  final Color backgroundColor;
  final Priority messagePriority;
  final VoidCallback? onTapResetMessage;

  Message.error({required this.messageText, this.onTapResetMessage})
      : messageTextColor = Colors.white,
        backgroundColor = Colors.red,
        messagePriority = Priority.HIGH;

  Message.success({required this.messageText, this.onTapResetMessage})
      : messageTextColor = Colors.white,
        backgroundColor = Colors.green,
        messagePriority = Priority.MEDIUM;

  Message.info({required this.messageText, this.onTapResetMessage})
      : messageTextColor = Colors.black54,
        backgroundColor = Colors.white,
        messagePriority = Priority.LOW;

  Message.warning({required this.messageText, this.onTapResetMessage})
      : messageTextColor = Colors.white,
        backgroundColor = Colors.orange,
        messagePriority = Priority.MEDIUM;
}
