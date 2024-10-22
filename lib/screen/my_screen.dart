import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/common/snack_bar.dart';
import 'package:flutter_pinterestclone/screen/base/state_builder/my_state.dart';
import 'package:flutter_pinterestclone/screen/base/state_builder/viewmodel_builder.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';
import 'package:flutter_pinterestclone/view_model/view_model_provider.dart';
import 'package:flutter_pinterestclone/widget/circular_bottom_indicator.dart';
import 'package:flutter_pinterestclone/widget/circular_indicator_widget.dart';

abstract class MyArgument {
  String get argKey;

  Map<String, dynamic> arg() => {argKey: this};
}

abstract class MyScreen<Vm extends MyViewModel, V extends View> extends MyState implements View {
  Vm? _viewModel;
  bool _refreshable = false;
  bool _scrollable = false;
  bool _hasCircularBottomIndicatorEnable = false;
  bool _withSafeArea = true;
  bool _extendBodyBehindAppBar = false;
  Color? _backgroundColor;

  Vm? get viewModel => _viewModel;

  MyViewModel? get myViewModel => _viewModel;

  T? getArgument<T extends MyArgument>() {
    final myArgument = (ModalRoute.of(getContext())?.settings.arguments as MyArgument);

    return myArgument.arg()[myArgument.argKey] as T;
  }

  void setRefreshable(bool refresh) {
    _refreshable = refresh;
  }

  void setScrollable(bool scrollable) {
    _scrollable = scrollable;
  }

  void setCircularBottomIndicator(bool value) {
    _hasCircularBottomIndicatorEnable = value;
  }

  void setBackgroundColor(Color color) {
    _backgroundColor = color;
  }

  void setWithSafeArea(bool value) {
    _withSafeArea = value;
  }

  void setExtendBodyBehindAppBar(bool value) {
    _extendBodyBehindAppBar = value;
  }

  Future<void> onRefresh() async {}

  @override
  void onCreate() {
    super.onCreate();
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
  void didUpdateWidgets(covariant MyScreen oldWidget) {
    super.didUpdateWidgets(oldWidget);
    this._viewModel = oldWidget._viewModel as Vm?;
    this._refreshable = oldWidget._refreshable;
    this._scrollable = oldWidget._scrollable;
    this._hasCircularBottomIndicatorEnable = oldWidget._hasCircularBottomIndicatorEnable;
    this._backgroundColor = oldWidget._backgroundColor;
  }

  @override
  void initListeners() {
    super.initListeners();
    _viewModel?.initListeners();
  }

  @override
  void onDestroy() {
    super.onDestroy();
    _viewModel?.removeListener(_viewModelListener);
    _viewModel?.onDestroy();
  }

  PreferredSizeWidget? buildAppBarWidget(BuildContext context) {
    return null;
  }

  @override
  Widget onBuildWidget(BuildContext context) {
    Widget body = ViewModelBuilder<Vm>(
      viewModel: viewModel!,
      builder: (_, model, child) {
        Widget bodyWidget = onBuildBodyWidget(context);
        if (_scrollable == true) {
          bodyWidget = SingleChildScrollView(child: bodyWidget);
        }
        bodyWidget = Stack(
          children: [
            bodyWidget,
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
    );

    if (_withSafeArea) {
      body = SafeArea(child: body);
    }

    return Scaffold(
      extendBodyBehindAppBar: _extendBodyBehindAppBar,
      backgroundColor: _backgroundColor,
      appBar: buildAppBarWidget(context),
      persistentFooterButtons: buildPersistentFooterWidgets(context),
      body: body,
    );
  }

  Widget onBuildBodyWidget(BuildContext context) {
    return Container();
  }

  List<Widget>? buildPersistentFooterWidgets(BuildContext context) {
    return null;
  }
}
