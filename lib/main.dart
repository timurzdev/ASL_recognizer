import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {
  final picker = ImagePicker();
  PickedFile image;
  var flag = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.camera_alt_outlined, color: Colors.black,),
        onPressed: () async {
          image = await picker.getImage(
            source: ImageSource.gallery,
            maxHeight: 128,
            maxWidth: 128,
            imageQuality: 100,
          );
          //classifier
          flag = true;
          setState(() {

          });
        },
      ),
      appBar: AppBar(
        title: Text("ASL recognizer"),
        backgroundColor: Colors.grey,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Your image'
            ),
            SizedBox(height: 20,),
            Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 4),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: flag? FileImage(File(image.path)) : AssetImage('./assets/white_background.jpg'),
                )
              ),
            )
          ],
        ),
      ),
    );
    }
  }
