import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_app_test/classifier/classifier.dart';

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
  String prediction = 'no';
  PickedFile image;
  Classifier classifier = Classifier();
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
            maxHeight: 300,
            maxWidth: 300,
            imageQuality: 100,
          );
          flag = true;
          //classifier
          //prediction = await classifier.classifyImage(image);
          setState(() {},
          );
        },
      ),
      appBar: AppBar(
        title: Text("ASL recognizer"),
        backgroundColor: Colors.black,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Your image',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
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
                    image: flag ? FileImage(File(image.path)) : AssetImage(
                        './assets/white_background.jpg'),
                  )
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Prediction:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              prediction,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
