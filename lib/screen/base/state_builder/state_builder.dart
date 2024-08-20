import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/common/log.dart';
import 'package:flutter_pinterestclone/common/typedef.dart';
import 'package:flutter_pinterestclone/screen/my_screen.dart';

class MyStateBuilder extends StatefulWidget {
  final String routeName;
  final OnBuildScreen screen;

  MyStateBuilder(this.routeName, this.screen);

  @override
  State<MyStateBuilder> createState() => _MyStateBuilderState();
}

class _MyStateBuilderState extends State<MyStateBuilder>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late MyScreen screen;

  _MyStateBuilderState();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    screen = widget.screen.call();
    Logger.p("OpenedScreen: ${widget.routeName}\n");

    screen.setVsync(this);
  }

  @override
  Widget build(BuildContext context) {
    screen.setContext(context);

    screen.onCreate();
    screen.initListeners();

    return screen.onBuild(context);
  }

  @override
  void didUpdateWidget(covariant MyStateBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);

    screen.didUpdateWidgets(screen);
    screen.initListeners();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    screen.onDestroy();
    super.dispose();
  }
}
