import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/common/typedef.dart';
import 'package:flutter_pinterestclone/screen/base/state_builder/my_state.dart';

class MyStateBuilder extends StatefulWidget {
  final OnBuildMyState state;

  MyStateBuilder.build(this.state, {super.key});

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
