import 'package:flutter/material.dart';

class ScreenManager {
  static void replaceRoute<R>(BuildContext ctx, String content, {R? arg}) {
    Navigator.pushNamedAndRemoveUntil<R>(ctx, content, (_) => false, arguments: arg);
  }

  static void openRoute<R>(
    BuildContext ctx,
    String content, {
    R? arg,
    void Function(R result)? onPopResult,
  }) {
    Navigator.pushNamed<R>(ctx, content, arguments: arg);
  }
}
