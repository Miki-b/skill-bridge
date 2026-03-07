import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skillbridge_excercise_app/Form_screens/Registration.dart';
import 'package:skillbridge_excercise_app/Form_screens/display_data.dart';
import 'package:skillbridge_excercise_app/Form_screens/images_display.dart';
import 'package:skillbridge_excercise_app/screen_1.dart';
import 'package:skillbridge_excercise_app/screen_2.dart';

import 'api/posts_screen.dart';

void main() {
  runApp(MaterialApp(
    initialRoute : '/',
    routes:{
      '/':(context)=> postsScreen(),
      '/displayData': (context)=> DisplayData()
    },
    debugShowCheckedModeBanner: false,
  ));
}



























class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isFavourite = false;
  int count = 0;

  void increment(){
    setState(() {
      count++;
    });

  }

  final services = ["Transfer","people","Finance","Utility","TopUp"];



  void favoriteToggle(){
    print(isFavourite);
    setState(() {
      isFavourite= !isFavourite;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Gesture and interactivity"),
        ),
        body: Center(
          child: GestureDetector(
            onTap: favoriteToggle,
            onDoubleTap: (){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("double tap detected"))
              );
            },
            child: AnimatedContainer(
              width: 200,
              height: 200,
              duration: Duration(microseconds: 300),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Icon(
                isFavourite ? Icons.favorite : Icons.favorite_border,
                color: isFavourite ? Colors.red: Colors.white,
                size: 55,
              )

            ),
          ),
        )

    );

  }
}


class iconCard extends StatelessWidget {
  final String icon;
  final String iconText;
  const iconCard({required this.icon,required this.iconText,super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print("container tapped");
      },
      onDoubleTap: () {
        print("container double-tapped");
      },

      onLongPress: (){
        print("container long-pressed");
      },
      child: Container(
        width: 180,
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow:[
            BoxShadow(
                offset: Offset(6,6),
                color: Colors.grey.shade200,
                blurRadius: 5,
                spreadRadius: 2
            )],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet_rounded,size: 30,color: Colors.deepPurple),
            SizedBox(height: 5,),
            Text("$iconText",style: GoogleFonts.montserrat(fontSize: 19),)
          ],
        ),

      ),
    );
  }
}
