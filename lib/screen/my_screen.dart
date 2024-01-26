import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';
import 'package:flutter_pinterestclone/view_model/view_model_provider.dart';
import 'package:flutter_pinterestclone/widget/circular_indicator_widget.dart';
import 'package:flutter_pinterestclone/widget/error_message_widget.dart';
import 'package:provider/provider.dart';

abstract class MyScreen<Vm extends MyViewModel, V extends View> extends StatefulWidget
    implements View {
  BuildContext? _context;
  Vm? _viewModel;
  bool _refreshable = false;
  bool _scrollable = false;
  Color? _backgroundColor;

  @override
  State<MyScreen> createState() => _MyScreenState();

  Vm? get viewModel => _viewModel;

  MyViewModel? get myViewModel => _viewModel;

  BuildContext getContext() => _context!;

  void setContext(BuildContext context) {
    _context = context;
  }

  void setRefreshable(bool refresh) {
    _refreshable = refresh;
  }

  void setScrollable(bool scrollable) {
    _scrollable = scrollable;
  }

  void setBackgroundColor(Color color) {
    _backgroundColor = color;
  }

  Future<void> onRefresh() async {}

  void onCreate() {
    viewModel?.onCreate();
    if (_viewModel == null) {
      _viewModel = ViewModelProvider.of(this).get(V) as Vm?;
      _viewModel?.onCreate();
    }
  }

  void onDestroy() {
    viewModel?.onDestroy();
  }

  PreferredSizeWidget? buildAppBarWidget(BuildContext context){
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
                  CircularIndicatorWidget(model.isLoading),
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

  List<Widget>? buildPersistentFooterWidgets(BuildContext context){
    return null;
  }
}

class _MyScreenState extends State<MyScreen> {
  @override
  Widget build(BuildContext context) {
    widget.setContext(context);

    if (widget.viewModel == null) {
      widget.onCreate();
    }

    return widget.build(context);
  }

  @override
  void dispose() {
    widget.onDestroy();
    super.dispose();
  }
}
