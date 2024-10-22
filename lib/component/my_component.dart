import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/common/snack_bar.dart';
import 'package:flutter_pinterestclone/screen/base/state_builder/my_state.dart';
import 'package:flutter_pinterestclone/screen/base/state_builder/state_builder.dart';
import 'package:flutter_pinterestclone/screen/base/state_builder/viewmodel_builder.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';
import 'package:flutter_pinterestclone/view_model/view_model_provider.dart';

abstract class MyComponentWidget extends StatelessWidget implements MyState {}

abstract class MyComponent<Vm extends MyViewModel, V extends View> extends MyComponentWidget implements View {
  BuildContext? _context;
  Vm? _viewModel;
  bool _refreshable = false;
  TickerProvider? _tickerProvider;

  Vm? get viewModel => _viewModel;

  MyViewModel? get myViewModel => _viewModel;

  @override
  BuildContext getContext() => _context!;

  @override
  TickerProvider getVsync() => _tickerProvider!;

  @override
  void setContext(BuildContext context) {
    _context = context;
  }

  void setRefreshable(bool refresh) {
    _refreshable = refresh;
  }

  @override
  void setVsync(TickerProvider tickerProvider) {
    _tickerProvider = tickerProvider;
  }

  Future<void> onRefresh() async {}

  @override
  void onCreate() {
    if (_viewModel == null) {
      _viewModel = ViewModelProvider.of(this).get(V) as Vm?;
      _viewModel?.onCreate();
      _viewModel?.addListener(_viewModelListener);
    }
  }

  void _viewModelListener() {
    if (_viewModel?.message != null) {
      MySnackBar.showMessageSnackBar(getContext(), _viewModel!.message!);
    }
  }

  @override
  void didUpdateWidgets(covariant MyComponent oldWidget) {
    this._context = oldWidget._context;
    this._viewModel = oldWidget._viewModel as Vm?;
    this._refreshable = oldWidget._refreshable;
    this._tickerProvider = oldWidget._tickerProvider;
  }

  @override
  void initListeners() {
    viewModel?.initListeners();
  }

  @override
  void onDestroy() {
    viewModel?.removeListener(_viewModelListener);
    viewModel?.onDestroy();
  }

  @override
  Widget build(BuildContext context) {
    return MyStateBuilder.component(() => this);
  }

  @override
  Widget onBuildWidget(BuildContext context) {
    return ViewModelBuilder<Vm>(
      viewModel: viewModel!,
      builder: (_, model, child) {
        Widget bodyWidget = onBuildBodyWidget(context);

        if (_refreshable == true) {
            bodyWidget = RefreshIndicator(
              onRefresh: onRefresh,
              child: bodyWidget,
            );
          }

          return bodyWidget;
      },
    );
  }

  Widget onBuildBodyWidget(BuildContext context);
}
