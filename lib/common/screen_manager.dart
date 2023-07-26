import 'package:flutter/material.dart';

class ScreenManager {
  static void replaceRoute<R>(BuildContext ctx, String content, {R? arg}) {
    Navigator.pushNamedAndRemoveUntil(ctx, content, (_) => false, arguments: arg);
  }

  static void openRoute<R>(
    BuildContext ctx,
    String content, {
    void Function(R result)? onPopResult,
  }) {
    Navigator.pushNamed(ctx, content);
  }
}
