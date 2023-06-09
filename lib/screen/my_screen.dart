import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';
import 'package:flutter_pinterestclone/view_model/view_model_provider.dart';
import 'package:provider/provider.dart';

abstract class MyScreen<Vm extends MyViewModel, V extends View> extends StatefulWidget
    implements View {
  MyScreenNotifier myScreenNotifier = MyScreenNotifier();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  Vm? _viewModel;

  Vm? get viewModel => _viewModel;

  MyViewModel? get myViewModel => _viewModel;

  @override
  State<MyScreen> createState() => _MyScreenState();

  void onCreate() {
    viewModel?.onCreate();
    if (_viewModel == null) {
      _viewModel = ViewModelProvider.of(this).get(V) as Vm?;
      _viewModel?.onCreate();
    }
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyScreenNotifier>.value(
      value: myScreenNotifier,
      child: Consumer<MyScreenNotifier>(
        builder: (_, model, child) {
          final ctx = context;
          final notifier = model;
          return Stack(
            children: [
              Scaffold(
                key: _scaffoldKey,
                resizeToAvoidBottomInset: notifier._resizeToAvoidBottomInset,
                backgroundColor: notifier._backgroundColor,
                floatingActionButton: notifier._floatActionButton,
                bottomNavigationBar: onBuildBottomNavigationBar(context),
                body: SafeArea(
                    child: Column(children: [
                  /*MessageScreenWidget(
                        myBloc?.getMessageStream(),
                        onCloseTap: () => myBloc?.resetMessage(),
                      ),*/
                  ChangeNotifierProvider<Vm>.value(
                    value: viewModel!,
                    child: Consumer<Vm>(
                      builder: (_, model, child) {
                        Widget bodyWidget = onBuildBodyWidget(ctx, model);

                        if (notifier._scrollable) {
                          bodyWidget = Expanded(
                            child: SingleChildScrollView(child: bodyWidget),
                          );
                        } else {
                          bodyWidget = Expanded(child: bodyWidget, flex: 1);
                        }

                        return bodyWidget;
                      },
                    ),
                  ),
                ])),
              )
            ],
          );
        },
      ),
    );
  }

  void onDestroy() {}

  Widget onBuildBodyWidget(BuildContext context, MyViewModel? model) {
    return Container();
  }

  Widget? onBuildBottomNavigationBar(BuildContext context) {
    return null;
  }
}

class _MyScreenState extends State<MyScreen> {
  @override
  void initState() {
    super.initState();
    widget.onCreate();
  }

  @override
  Widget build(BuildContext context) {
    return widget.onBuildBodyWidget(context, widget.viewModel);
  }

  @override
  void dispose() {
    widget.onDestroy();
    super.dispose();
  }
}

class MyScreenNotifier extends ChangeNotifier {
  void notif() {
    notifyListeners();
  }

  @nonVirtual
  Widget? get getFloatActionButton => _floatActionButton;

  @nonVirtual
  bool get isScrollable => _scrollable;

  @nonVirtual
  bool get isSearchEnabled => _isSearchEnabled;

  @nonVirtual
  Color? get getBackgroundColor => _backgroundColor;

  @nonVirtual
  bool? get getResizeToAvoidBottomInset => _resizeToAvoidBottomInset;

  Color? _backgroundColor;

  set backgroundColor(Color newValue) {
    _backgroundColor = newValue;
    notifyListeners();
  }

  bool _isSearchEnabled = false;

  set setSearchEnabled(bool newValue) {
    _isSearchEnabled = newValue;
    notifyListeners();
  }

  bool _scrollable = true;

  set scrollable(bool newValue) {
    _scrollable = newValue;
    notifyListeners();
  }

  Widget? _floatActionButton;

  set floatActionButton(Widget newValue) {
    _floatActionButton = newValue;
    notifyListeners();
  }

  bool? _resizeToAvoidBottomInset;

  set resizeToAvoidBottomInset(bool newValue) {
    _resizeToAvoidBottomInset = newValue;
    notifyListeners();
  }
}
