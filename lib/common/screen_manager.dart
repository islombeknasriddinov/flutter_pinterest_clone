import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/screen/my_screen.dart';

class Bundle {}

class ScreenManager {
  static void replaceRoute<R>(BuildContext ctx, String content, {R? arg}) {
    Navigator.pushNamedAndRemoveUntil<R>(ctx, content, (_) => false, arguments: arg);
  }

  static void openRoute<R>(
    BuildContext ctx,
    String content, {
    MyArgument? arg,
    void Function(R result)? onPopResult,
  }) {
    Navigator.pushNamed<R>(ctx, content, arguments: arg);
  }

  static void popUpRoute(BuildContext context) => Navigator.pop(context);
}
