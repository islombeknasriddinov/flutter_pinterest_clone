import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/common/enum.dart';
import 'package:flutter_pinterestclone/main.dart';

class Message {
  final String messageText;
  final Color messageTextColor;
  final Color backgroundColor;

  final IconData? icon;
  final Color? iconColor;

  final Priority messagePriority;
  final VoidCallback? onTapResetMessage;

  Message.error({required this.messageText, this.onTapResetMessage})
      : messageTextColor = PinterestAppColor.instance.white,
        backgroundColor = PinterestAppColor.instance.red,
        messagePriority = Priority.HIGH,
        icon = Icons.warning_amber_rounded,
        iconColor = PinterestAppColor.instance.white;

  Message.success({required this.messageText, this.onTapResetMessage})
      : messageTextColor = PinterestAppColor.instance.white,
        backgroundColor = PinterestAppColor.instance.green,
        messagePriority = Priority.MEDIUM,
        icon = Icons.done_all_rounded,
        iconColor = Colors.deepOrange;

  Message.info({required this.messageText, this.onTapResetMessage})
      : messageTextColor = PinterestAppColor.instance.black,
        backgroundColor = PinterestAppColor.instance.white,
        messagePriority = Priority.LOW,
        icon = Icons.info_outline_rounded,
        iconColor = PinterestAppColor.instance.blue;

  Message.warning({required this.messageText, this.onTapResetMessage})
      : messageTextColor = PinterestAppColor.instance.white,
        backgroundColor = PinterestAppColor.instance.black,
        messagePriority = Priority.MEDIUM,
        icon = Icons.local_fire_department_rounded,
        iconColor = PinterestAppColor.instance.deepOrange;
}
