import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/screen/base/state_builder/my_state.dart';
import 'package:flutter_pinterestclone/screen/base/state_builder/state_builder.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';
import 'package:flutter_pinterestclone/view_model/view_model_provider.dart';
import 'package:provider/provider.dart';

abstract class MyComponent<Vm extends MyViewModel, V extends View> extends StatelessWidget
    implements MyState, View {
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
    viewModel?.onDestroy();
  }

  @override
  Widget build(BuildContext context) {
    return MyStateBuilder("", () => this);
  }

  @override
  Widget onBuildWidget(BuildContext context) {
    return ChangeNotifierProvider<Vm>.value(
      value: viewModel!,
      child: Consumer<Vm>(
        builder: (_, model, child) {
          Widget bodyWidget = onBuildBodyWidget(context);
          //bodyWidget = Expanded(flex: 1, child: bodyWidget);

/*          bodyWidget = Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ErrorMessageWidget(
                    message: model.message,
                    onTap: () => model.resetMessage(),
                  ),
                  bodyWidget,
                ],
              ),
              !_hasCircularBottomIndicatorEnable
                  ? CircularIndicatorWidget(model.isLoading)
                  : CircularBottomIndicator(model.isLoading),
            ],
          );*/

          if (_refreshable == true) {
            bodyWidget = RefreshIndicator(
              onRefresh: onRefresh,
              child: bodyWidget,
            );
          }

          return bodyWidget;
        },
      ),
    );

/*

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: buildAppBarWidget(context),
      persistentFooterButtons: buildPersistentFooterWidgets(context),
      body: body,
    );*/
  }

  Widget onBuildBodyWidget(BuildContext context);
}
