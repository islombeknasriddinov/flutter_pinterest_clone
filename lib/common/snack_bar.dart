import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class MySnackBar {
  static void showSnackBar(
    BuildContext context, {
    String? title,
    String? message,
    bool dismissible = true,
    EdgeInsets padding = const EdgeInsets.all(16),
    EdgeInsets margin = EdgeInsets.zero,
    FlushbarDismissDirection dismissDirection = FlushbarDismissDirection.VERTICAL,
    FlushbarStatusCallback? onStatusChanges,
    Color backgroundColor = Colors.transparent,
    BorderRadius? borderRadius,
    Color? borderColor,
    double borderWidth = 0,
  }) {
    Flushbar(
      titleText: title?.isNotEmpty == true ? Text(title ?? "") : null,
      messageText: message?.isNotEmpty == true ? Text(message ?? "") : null,
      padding: padding,
      margin: margin,
      isDismissible: dismissible,
      dismissDirection: dismissDirection,
      onStatusChanged: onStatusChanges,
      //duration: const Duration(milliseconds: 500),
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      borderColor: borderColor,
      borderWidth: borderWidth,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      //forwardAnimationCurve: Curves.easeOut,
    ).show(context);
  }
}