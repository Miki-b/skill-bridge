
import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  final String message;


  Screen2({required this.message});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        appBar: AppBar(
            title: Text("Screen 2")
        ),
        body: Column(
          mainAxisAlignment :  MainAxisAlignment.center,
          crossAxisAlignment : CrossAxisAlignment.center,
          children: [
            Text(args),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("back to screen 1")
            )
          ],
        )
    );
  }
}

