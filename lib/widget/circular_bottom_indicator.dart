import 'package:flutter/material.dart';

class CircularBottomIndicator extends StatelessWidget {
  final bool isLoading;
  final double? height;

  const CircularBottomIndicator(this.isLoading, {this.height});

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: height ?? kToolbarHeight,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : Container();
  }
}
