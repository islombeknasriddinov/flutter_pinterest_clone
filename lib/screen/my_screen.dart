import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/screen/bean/message.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';
import 'package:flutter_pinterestclone/view_model/view_model_provider.dart';
import 'package:flutter_pinterestclone/widget/circular_indicator_widget.dart';
import 'package:flutter_pinterestclone/widget/error_message_widget.dart';
import 'package:provider/provider.dart';

abstract class MyScreen<Vm extends MyViewModel, V extends View>
    extends StatefulWidget implements View {
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
                          message: Message(messageText: "Error"),
                          onTap: () {},
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
  void initState() {
    super.initState();
    widget.onCreate();
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context);
  }

  @override
  void dispose() {
    widget.onDestroy();
    super.dispose();
  }
}
