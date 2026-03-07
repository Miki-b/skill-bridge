import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:skillbridge_excercise_app/api/post.dart';
class postsScreen extends StatefulWidget {
  const postsScreen({super.key});

  @override
  State<postsScreen> createState() => _postsScreenState();
}

class _postsScreenState extends State<postsScreen> {


  late Future<List<Post>> posts;
  Future<List<Post>> getData() async {
    Response response = await get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        headers: {
          'User-Agent': 'Mozilla/5.0',
          'Accept': 'application/json'
        }
    );
    List data = jsonDecode(response.body);
    print(data[0]);
    return data.map((post){
      return Post(
          userId: post["userId"],
          id: post["id"],
          title: post["title"],
          body: post["body"]
      );
    }).toList();
  }

  @override
  void initState(){
    super.initState();
    posts = getData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("posts"),
        elevation: 4,
      ),
      body: FutureBuilder(
          future: posts,
          builder: (BuildContext context,snapshot){
            if (snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }

            if(snapshot.hasError){
              return Text("Error: ${snapshot.error}");
            }

              final data = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: data.length,
                    itemBuilder:(context,index){
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data[index].title, textAlign: TextAlign.justify,
                           style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,

                            )),
                            Text(data[index].body,textAlign: TextAlign.justify,),
                          ],
                        ),
                      ),
                    );

                    }),
              );
            }



      )
    );
  }
}
