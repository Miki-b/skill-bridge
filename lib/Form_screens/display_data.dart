import 'package:flutter/material.dart';
class DisplayData extends StatefulWidget {
  const DisplayData({super.key});

  @override
  State<DisplayData> createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as Map;
    final keys = data.keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Display Form Data"),

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Card(
            elevation: 4,
            child: Container(
              width: 300,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: keys.map((i){
                    return Text(data[i].toString());
                  }).toList()


                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
