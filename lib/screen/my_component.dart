import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/screen/base/state_builder/state_builder.dart';
import 'package:flutter_pinterestclone/screen/my_screen.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';

abstract class MyComponent<Vm extends MyViewModel, V extends View> extends StatelessWidget
    implements MyScreen {
  @override
  Widget build(BuildContext context) {
    return MyStateBuilder("", () => this);
  }
}

class MyHomeComponent extends MyComponent {}
