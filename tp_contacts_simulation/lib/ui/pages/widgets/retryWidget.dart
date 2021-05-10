import 'package:flutter/material.dart';

class RetryWidget extends StatelessWidget {
  String errorMessage;
  Function onAction;

  RetryWidget({this.errorMessage, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(errorMessage),
        RaisedButton(
          onPressed: onAction,
          child: Text(
            'Ressayer',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.deepPurple,
        )
      ],
    );
  }
}
