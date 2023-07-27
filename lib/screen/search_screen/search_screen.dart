import 'package:flutter/cupertino.dart';
import 'package:flutter_pinterestclone/screen/my_screen.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';

class SearchScreen extends MyScreen<SearchScreenViewModel, SearchScreenView>
    implements SearchScreenView {
  static const String ROUTE_NAME = "search_screen";

  @override
  Widget onBuildBodyWidget(BuildContext context) {
    return Container();
  }
}
