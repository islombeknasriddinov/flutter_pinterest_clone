import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/main.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';
import 'package:flutter_pinterestclone/view_model/view_model_provider.dart';
import 'package:flutter_pinterestclone/widget/circular_bottom_indicator.dart';
import 'package:flutter_pinterestclone/widget/circular_indicator_widget.dart';
import 'package:flutter_pinterestclone/widget/error_message_widget.dart';
import 'package:provider/provider.dart';

abstract class MyArgument {
  String get argKey;

  Map<String, dynamic> arg() => {argKey: this};
}

class MyStateBuilder extends StatefulWidget {
  final MyScreen _screen;

  MyStateBuilder(MyScreen screen) : _screen = screen;

  @override
  State<MyStateBuilder> createState() => _MyStateBuilderState(MyApp.getNewState(_screen));
}

class _MyStateBuilderState extends State<MyStateBuilder>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final MyScreen screen;

  _MyStateBuilderState(this.screen);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    screen.setVsync(this);
  }

  @override
  Widget build(BuildContext context) {
    screen.setContext(context);

    screen.onCreate();
    screen.initListeners();

    return screen.build(context);
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

class MyScreen<Vm extends MyViewModel, V extends View> implements View {
  BuildContext? _context;
  Vm? _viewModel;
  bool _refreshable = false;
  bool _scrollable = false;
  bool _hasCircularBottomIndicatorEnable = false;
  Color? _backgroundColor;
  TickerProvider? _tickerProvider;

  Vm? get viewModel => _viewModel;

  MyViewModel? get myViewModel => _viewModel;

  BuildContext getContext() => _context!;

  T? getArgument<T extends MyArgument>() {
    final myArgument = (ModalRoute.of(getContext())?.settings.arguments as MyArgument);

    return myArgument.arg()[myArgument.argKey] as T;
  }

  TickerProvider getVsync() => _tickerProvider!;

  void setContext(BuildContext context) {
    _context = context;
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

  void setVsync(TickerProvider tickerProvider) {
    _tickerProvider = tickerProvider;
  }

  Future<void> onRefresh() async {}

  void onCreate() {
    if (_viewModel == null) {
      _viewModel = ViewModelProvider.of(this).get(V) as Vm?;
      _viewModel?.onCreate();
    }
  }

  void didUpdateWidgets(covariant MyScreen oldWidget) {
    this._context = oldWidget._context;
    this._viewModel = oldWidget._viewModel as Vm?;
    this._refreshable = oldWidget._refreshable;
    this._scrollable = oldWidget._scrollable;
    this._hasCircularBottomIndicatorEnable = oldWidget._hasCircularBottomIndicatorEnable;
    this._backgroundColor = oldWidget._backgroundColor;
  }

  void initListeners() {
    viewModel?.initListeners();
  }

  void onDestroy() {
    viewModel?.onDestroy();
  }

  PreferredSizeWidget? buildAppBarWidget(BuildContext context) {
    return null;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: buildAppBarWidget(context),
      persistentFooterButtons: buildPersistentFooterWidgets(context),
      body: SafeArea(
        child: ChangeNotifierProvider<Vm>.value(
          value: viewModel!,
          child: Consumer<Vm>(
            builder: (_, model, child) {
              Widget bodyWidget = onBuildBodyWidget(context);
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
                      Expanded(child: bodyWidget)
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
        ),
      ),
    );
  }

  Widget onBuildBodyWidget(BuildContext context) {
    return Container();
  }

  List<Widget>? buildPersistentFooterWidgets(BuildContext context) {
    return null;
  }
}
