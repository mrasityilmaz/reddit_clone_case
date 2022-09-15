import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  final String errorMessage;
  const MyErrorWidget({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Icon(
              Icons.warning_amber_rounded,
              size: 45,
              color: Colors.red,
            ),
          ),
          Text(
            errorMessage.toString(),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
