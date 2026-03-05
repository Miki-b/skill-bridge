
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class displayImages extends StatefulWidget {
  const displayImages({super.key});

  @override
  State<displayImages> createState() => _displayImagesState();
}

class _displayImagesState extends State<displayImages> {

  final ImagePicker picker = ImagePicker();
  List<XFile> images= [];

  Future<void> pickSingleImage(ImageSource source) async {
    final XFile? file = await picker.pickImage(source: source);
    if (file==null) return;
    setState(() {
      images= [file];
    });
  }


  Future<void> pickMultipleImage() async {
    final List<XFile>? files = await picker.pickMultiImage();
    if (files==null || files.isEmpty) return;
    setState(() {
      images= files;
    });
  }

  Future<void> pickFromCamera(ImageSource source) async {
    final XFile? file = await picker.pickImage(source: source);
    if (file==null) return;
    setState(() {
      images= [file];
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Images"),
          elevation: 4,
        ),
      body: Column(
        //images
        children: [
          Expanded(
            child: images.isEmpty?Center(child: Text("please pick your images")):GridView.builder(
                itemCount: images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 6,
                  crossAxisSpacing: 6
                ),
                itemBuilder: (context, i){
                  return Image.file(
                    File(images[i].path),
                      fit: BoxFit.cover,
                  );
                }

            ),
          ),
        /// the buttons
        ///
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                SizedBox(width: 2,),
                ElevatedButton(
                    onPressed: ()=>pickSingleImage(ImageSource.gallery),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 10,
                        ),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        )
                    ),
                    child: Text("Pick Single Image")),
                SizedBox(width: 3,),
                ElevatedButton(
                    onPressed: ()=>pickMultipleImage(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 10,
                        ),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        )
                    ),
                    child: Text("Pick Multiple Image")),
                SizedBox(width: 3,),
                ElevatedButton(
                    onPressed: ()=> pickFromCamera(ImageSource.camera),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 10,
                        ),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        )
                    ),
                    child: Text("Pick from camera")),

              ],
            ),
          ),
          SizedBox(height: 20,)

        ],

      ),
    );
  }
}