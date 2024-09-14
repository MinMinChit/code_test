import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context, String message) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CupertinoActivityIndicator(),
              const SizedBox(height: 12),
              Text(message),
            ],
          ),
        );
      });
}
