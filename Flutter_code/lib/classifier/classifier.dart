import 'package:flutter/widgets.dart';
import 'dart:typed_data';
import 'package:tflite_flutter/tflite_flutter.dart';
//import 'package:tflite/tflite.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;

const List<String> predictionsMap = ['A', 'B', 'C', 'D', 'del', 'E', 'F', 'G', 'H', 'I',
  'J', 'K', 'L', 'M', 'N', 'nothing', 'O', 'P', 'Q',
  'R', 'S','space','T', 'U', 'V', 'W', 'X', 'Y','Z'];


class Classifier {
  Classifier();

  classifyImage(PickedFile image) async {
    var _file = io.File(image.path);
    img.Image imageTemp = img.decodeImage(_file.readAsBytesSync());
    img.Image resizedImg = img.copyResize(imageTemp, height: 128, width: 128);
    var imgBytes = resizedImg.getBytes();
    var imgAsList = imgBytes.buffer.asUint8List();

    return predicition(imgAsList);
  }
}

Future<String> predicition(Uint8List imgAsList) async {
  final resultBytes = List(128 * 128 * 3);
  int index = 0;
  //skipping Alpha channel
  for (int i = 0; i < imgAsList.lengthInBytes; i += 4) {
    final r = imgAsList[i];
    final g = imgAsList[i + 1];
    final b = imgAsList[i + 2];
    resultBytes[index] = r / 255.0;
    resultBytes[index + 1] = g / 255.0;
    resultBytes[index + 2] = b / 255.0;
    index += 3;
  }

  final input = resultBytes.reshape([1, 128, 128, 3]);
  var output = List(1 * 29).reshape([1, 29]);

  //InterpreterOptions interpreterOptions = InterpreterOptions();

  try {
    final interpreter = await Interpreter.fromAsset('modelV2.tflite');
    interpreter.run(input, output);
  } catch (e) {
    print("Error running model: " + e.toString());
  }

  double highestProbability = 0;
  String prediction;
  int predictionIndex;
  for (int i = 0; i < output[0].length; i++) {
    if (output[0][i] > highestProbability) {
      highestProbability = output[0][i];
      predictionIndex = i;
    }
  }
  return predictionsMap[predictionIndex];
}