import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/network/network_manager.dart';
import 'package:flutter_pinterestclone/viewmodel/main_viewmodel.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../views/item_of_photos.dart';

class MainPage extends StatefulWidget {
  static final String id = "main_page";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainViewModel viewModel = MainViewModel(NetworkManagerImpl());

  int page = 1;

  @override
  void initState() {
    viewModel.apiPhotoList(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Consumer<MainViewModel>(
          builder: (ctx, model, index) => Stack(
            children: [
              MasonryGridView.builder(
                padding: EdgeInsets.only(right: 5, left: 5),
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: viewModel.items.length,
                itemBuilder: (ctx, i) {
                  return itemOfPhotos(viewModel.items[i], ctx);
                },
                gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
              ),
              viewModel.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    ));
  }
}
