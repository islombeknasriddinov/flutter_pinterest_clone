import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/screen/base/state_builder/state_builder.dart';
import 'package:flutter_pinterestclone/screen/my_screen.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';
import 'package:flutter_pinterestclone/view_model/view_model_provider.dart';
import 'package:flutter_pinterestclone/widget/circular_bottom_indicator.dart';
import 'package:flutter_pinterestclone/widget/circular_indicator_widget.dart';
import 'package:flutter_pinterestclone/widget/error_message_widget.dart';
import 'package:provider/provider.dart';

abstract class MyComponent<Vm extends MyViewModel, V extends View> extends StatelessWidget
    implements MyScreen {
  BuildContext? _context;
  Vm? _viewModel;
  bool _refreshable = false;
  bool _scrollable = false;
  bool _hasCircularBottomIndicatorEnable = false;
  bool _withSafeArea = true;
  Color? _backgroundColor;
  TickerProvider? _tickerProvider;

  @override
  Vm? get viewModel => _viewModel;

  @override
  MyViewModel? get myViewModel => _viewModel;

  @override
  BuildContext getContext() => _context!;

  @override
  T? getArgument<T extends MyArgument>() {
    final myArgument = (ModalRoute.of(getContext())?.settings.arguments as MyArgument);

    return myArgument.arg()[myArgument.argKey] as T;
  }

  @override
  TickerProvider getVsync() => _tickerProvider!;

  @override
  void setContext(BuildContext context) {
    _context = context;
  }

  @override
  void setRefreshable(bool refresh) {
    _refreshable = refresh;
  }

  @override
  void setScrollable(bool scrollable) {
    _scrollable = scrollable;
  }

  @override
  void setCircularBottomIndicator(bool value) {
    _hasCircularBottomIndicatorEnable = value;
  }

  @override
  void setBackgroundColor(Color color) {
    _backgroundColor = color;
  }

  @override
  void setVsync(TickerProvider tickerProvider) {
    _tickerProvider = tickerProvider;
  }

  @override
  void setWithSafeArea(bool value) {
    _withSafeArea = value;
  }

  @override
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
    this._scrollable = oldWidget._scrollable;
    this._hasCircularBottomIndicatorEnable = oldWidget._hasCircularBottomIndicatorEnable;
    this._backgroundColor = oldWidget._backgroundColor;
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
  PreferredSizeWidget? buildAppBarWidget(BuildContext context) {
    return null;
  }

  @override
  Widget onBuild(BuildContext context) {
    Widget body = ChangeNotifierProvider<Vm>.value(
      value: viewModel!,
      child: Consumer<Vm>(
        builder: (_, model, child) {
          Widget bodyWidget = onBuildBodyWidget(context);
          bodyWidget = Expanded(flex: 1, child: bodyWidget);
          if (_scrollable == true) {
            bodyWidget = SingleChildScrollView(child: bodyWidget);
          }

          bodyWidget = Stack(
            children: [
              Column(
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
          );

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

    if (_withSafeArea) {
      body = SafeArea(child: body);
    }

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: buildAppBarWidget(context),
      persistentFooterButtons: buildPersistentFooterWidgets(context),
      body: body,
    );
  }

  @override
  Widget onBuildBodyWidget(BuildContext context);

  @override
  List<Widget>? buildPersistentFooterWidgets(BuildContext context) {
    return null;
  }
}
