
import 'package:flutter/material.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Screen 1")
        ),
        body: Column(
          mainAxisAlignment :  MainAxisAlignment.center,
          crossAxisAlignment : CrossAxisAlignment.center,
          children: [
            Text("This is Screen 1"),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,'/screen2',
                    arguments: "hello"
                  );
                },
                child: Text("screen 2")
            )
          ],
        )
    );
  }
}