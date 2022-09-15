import 'dart:ui';

import 'package:flutter/material.dart';

class MyCircularProgressBar extends StatelessWidget {
  final String? text;
  const MyCircularProgressBar({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: Colors.black.withOpacity(.1)),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
                width: text != null ? null : 80,
                height: text != null ? null : 80,
                color: Colors.white.withOpacity(.9),
                padding: text != null ? const EdgeInsets.all(12) : null,
                child: text != null
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator.adaptive(),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(text!),
                        ],
                      )
                    : const Padding(
                        padding: EdgeInsets.all(25.0),
                        child: CircularProgressIndicator.adaptive(),
                      )),
          ),
        ),
      ),
    );
  }
}
