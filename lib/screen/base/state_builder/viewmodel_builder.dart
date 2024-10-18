import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef OnViewModelBuild<T extends ChangeNotifier> = Widget Function(
  BuildContext context,
  T value,
  Widget? child,
);

class ViewModelBuilder<T extends ChangeNotifier> extends StatelessWidget {
  final T viewModel;
  final OnViewModelBuild<T> builder;

  ViewModelBuilder({required this.viewModel, required this.builder});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(value: viewModel, child: Consumer<T>(builder: builder));
  }
}
