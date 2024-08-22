import 'package:flutter/material.dart';

abstract class MyState {
  BuildContext? _context;
  TickerProvider? _tickerProvider;

  TickerProvider getVsync() => _tickerProvider!;

  BuildContext getContext() => _context!;

  void setVsync(TickerProvider tickerProvider) {
    _tickerProvider = tickerProvider;
  }

  void setContext(BuildContext context) {
    _context = context;
  }

  @protected
  @mustCallSuper
  void onCreate() {}

  @protected
  @mustCallSuper
  void initListeners() {}

  @protected
  @mustCallSuper
  void didUpdateWidgets(covariant MyState oldWidget) {
    _context = oldWidget._context;
    _tickerProvider = oldWidget._tickerProvider;
  }

  Widget onBuildWidget(BuildContext context);

  @protected
  @mustCallSuper
  void onDestroy() {}
}
