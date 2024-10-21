import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/common/log.dart';
import 'package:flutter_pinterestclone/common/typedef.dart';
import 'package:flutter_pinterestclone/screen/base/state_builder/my_state.dart';

class MyStateBuilder extends StatefulWidget {
  final String? routeName;
  final OnBuildMyState state;

  MyStateBuilder._(this.routeName, this.state);

  factory MyStateBuilder.screen(String routeName, OnBuildMyState screen) =>
      MyStateBuilder._(routeName, screen);

  factory MyStateBuilder.component(OnBuildMyState component) => MyStateBuilder._(null, component);

  @override
  State<MyStateBuilder> createState() => _MyStateBuilderState();
}

class _MyStateBuilderState extends State<MyStateBuilder>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late MyState state;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    state = widget.state.call();
    if (widget.routeName != null) {
      Logger.p("OpenedScreen: ${widget.routeName}\n");
    }

    state.setVsync(this);
  }

  @override
  Widget build(BuildContext context) {
    state.setContext(context);

    state.onCreate();
    state.initListeners();

    return state.onBuildWidget(context);
  }

  @override
  void didUpdateWidget(covariant MyStateBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);

    state.didUpdateWidgets(state);
    state.initListeners();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    state.onDestroy();
    super.dispose();
  }
}
