import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/common/enum.dart';
import 'package:flutter_pinterestclone/screen/base/bean/message.dart';

class MySnackBar {
  static List<Flushbar> mySnackBarHistory = [];

  static void showMessageSnackBar(BuildContext context, Message message) {
    Duration? duration;

    switch (message.messagePriority) {
      case Priority.LOW:
        duration = const Duration(seconds: 3);
        break;
      case Priority.MEDIUM:
        duration = const Duration(seconds: 6);
        break;
      case Priority.HIGH:
        break;
    }

    return _showSnackBar(
      context,
      message: message.messageText,
      messageTextColor: message.messageTextColor,
      backgroundColor: message.backgroundColor,
      icon: message.icon,
      iconColor: message.iconColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      duration: duration,
      onStatusChanges: (status) {
        if (status == FlushbarStatus.DISMISSED) {
          message.onTapResetMessage?.call();
        }
      },
    );
  }

  static void _showSnackBar(
    BuildContext context, {
    String? title,
    String? message,
    IconData? icon,
    Color? iconColor,
    Color? messageTextColor,
    Color? titleTextColor,
    bool dismissible = true,
    EdgeInsets padding = const EdgeInsets.all(16),
    EdgeInsets margin = const EdgeInsets.all(16),
    FlushbarDismissDirection dismissDirection = FlushbarDismissDirection.VERTICAL,
    FlushbarStatusCallback? onStatusChanges,
    Color backgroundColor = Colors.transparent,
    Duration? duration,
    BorderRadius? borderRadius,
    Color? borderColor,
    double borderWidth = 0,
  }) async {
    final snackBar = Flushbar(
      titleText: title?.isNotEmpty == true
          ? Text(
              title ?? "",
              style: TextStyle(color: titleTextColor),
            )
          : null,
      messageText: message?.isNotEmpty == true
          ? Text(
              message ?? "",
              style: TextStyle(color: messageTextColor, fontSize: 14),
              textAlign: TextAlign.start,
            )
          : null,
      icon: icon != null ? Icon(icon, color: iconColor) : null,
      shouldIconPulse: false,
      padding: padding,
      margin: margin,
      isDismissible: dismissible,
      dismissDirection: dismissDirection,
      onStatusChanged: onStatusChanges,
      duration: duration,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      borderColor: borderColor,
      borderWidth: borderWidth,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      forwardAnimationCurve: Curves.fastOutSlowIn,
      reverseAnimationCurve: Curves.easeOut,
    )..show(context);

    if (mySnackBarHistory.isNotEmpty) {
      mySnackBarHistory.first.dismiss();
      mySnackBarHistory.clear();
    }

    mySnackBarHistory.add(snackBar);
  }
}