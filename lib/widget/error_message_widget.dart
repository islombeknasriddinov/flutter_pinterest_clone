import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/screen/karnel/bean/message.dart';

class ErrorMessageWidget extends StatelessWidget {
  Message? message;
  void Function() onTap;

  ErrorMessageWidget({
    required this.message,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (message == null) return Container();

    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      color: message!.backgroundColor,
      child: Row(
        children: [
          Expanded(
            child: Text(
              message!.messageText,
              style: TextStyle(
                color: message!.messageTextColor,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            onPressed: onTap,
            icon: const Icon(Icons.close),
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
