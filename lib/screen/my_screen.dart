import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';
import 'package:flutter_pinterestclone/view_model/view_model_provider.dart';
import 'package:flutter_pinterestclone/widget/circular_indicator_widget.dart';
import 'package:flutter_pinterestclone/widget/error_message_widget.dart';
import 'package:provider/provider.dart';

abstract class MyScreen<Vm extends MyViewModel, V extends View>
    extends StatefulWidget implements View {
  BuildContext? _context;
  Vm? _viewModel;

  Vm? get viewModel => _viewModel;

  MyViewModel? get myViewModel => _viewModel;

  @override
  State<MyScreen> createState() => _MyScreenState();

  BuildContext getContext() => _context!;

  void setContext(BuildContext context) {
    _context = context;
  }

  void onCreate() {
    viewModel?.onCreate();
    if (_viewModel == null) {
      _viewModel = ViewModelProvider.of(this).get(V) as Vm?;
      _viewModel?.onCreate();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider<Vm>.value(
          value: viewModel!,
          child: Consumer<Vm>(
            builder: (_, model, child) {
              Widget bodyWidget = onBuildBodyWidget(context);

              return RefreshIndicator(
                onRefresh: onRefresh,
                child: Stack(
                  children: [
                    CircularIndicatorWidget(myViewModel?.isLoading == true),
                    Column(
                      children: [
                        ErrorMessageWidget(
                          message: myViewModel?.message,
                          onTap: () => myViewModel?.resetMessage(),
                        ),
                        Expanded(child: bodyWidget)
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void onDestroy() {}

  Widget onBuildBodyWidget(BuildContext context) {
    return Container();
  }

  Future<void> onRefresh() async {}
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
