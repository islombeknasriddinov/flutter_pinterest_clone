import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularIndicatorWidget extends StatelessWidget {
  final bool isLoading;

  const CircularIndicatorWidget(this.isLoading);

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Container();
  }
}
