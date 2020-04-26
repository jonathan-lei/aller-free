import 'dart:async';
import 'dart:io';
import 'dart:convert';


import 'package:camera/camera.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:allerfree/pages/results.dart';
import 'package:allerfree/pages/profile.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';


import 'globals.dart' as globals;


PanelController _pc = new PanelController();

FirebaseAnalytics analytics = FirebaseAnalytics();


Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  await loadPreferences();

  runApp(
    MaterialApp(
      theme: ThemeData.light(),
      home: TakePictureScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        camera: firstCamera,
      ),
    ),
  );

  _pc.open();


}




Future<String> analyzeText(String path) async{
  globals.allergenContainsList=[];
  final File imageFile = await FlutterExifRotation.rotateImage(path: path);
  final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
  final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
  final VisionText visionText = await textRecognizer.processImage(visionImage);
  String text = await translateText(visionText);
  savePreferences();
//    print(text);
//    final Rect boundingBox = block.boundingBox;
//    final List<Offset> cornerPoints = block.cornerPoints;
//    final String text = block.text;
//    final List<RecognizedLanguage> languages = block.recognizedLanguages;
//    for (TextLine line in block.lines) {
//      // Same getters as TextBlock
//      for (TextElement element in line.elements) {
//        // Same getters as TextBlock
//      }
//    }
//  }
  globals.allergenChoices.forEach((key, value) {
    if(value && text.toUpperCase().contains(key)){
      if(globals.allergenContainsList.isEmpty || (globals.allergenContainsList.isNotEmpty && !globals.allergenContainsList.contains(key))){
        globals.allergenContainsList.add(key);
        print(globals.allergenContainsList);
        print(key);
      }
    }
  });
//  print("TEXTPRINTOUT" + text);
  return text;
}

Future<String> translateText(VisionText visionText) async{
  String text = visionText.text;
//  try {
    final result = await InternetAddress.lookup('aller-free.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      final GoogleTranslator translator = GoogleTranslator();
      for (TextBlock block in visionText.blocks) {
        final List<RecognizedLanguage> languages = block.recognizedLanguages;
        if (languages[0].languageCode != null && languages[0].languageCode !="en") {
          try {
            await translator.translate(
                block.text, from: languages[0].languageCode, to: 'en').then((
                s) {
//              print('Text Before: '+text);
//              print('Result: '+s);
              text = text + s;
//              print('Text After: '+text);
            });
          }  catch(error){
//            print('Error: '+error);
            return text;
          }
        }
      }
    }
    return text;
//  } on SocketException catch (_) {
    print('Oops, not connected on the internet');
    return text;
//  }
}

Future<void> savePreferences() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String> mapKeys = [];
  List<String> mapVals = [];

  globals.allergenChoices.forEach((key, value) {
    mapKeys.add(key);
    mapVals.add(value.toString());
  });

  prefs.setStringList('allergenChoicesKeysPersist', mapKeys);
  prefs.setStringList('allergenChoicesValsPersist', mapVals);
  prefs.setStringList('allergenChoiceListPersist', globals.allergenChoiceList);

//  print(globals.allergenChoiceList);
}

Future<void> loadPreferences() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.containsKey('allergenChoiceListPersist')) {
    print("Loading Preferences");
    globals.allergenChoiceList =
        prefs.getStringList('allergenChoiceListPersist');
    List<String> mapKeys = prefs.getStringList('allergenChoicesKeysPersist');
    List<String> mapVals = prefs.getStringList('allergenChoicesValsPersist');
    for (int i = 0; i < mapKeys.length; i++) {
      globals.allergenChoices[mapKeys[i]] = mapVals[i] == 'true';
    }
    print(globals.allergenChoiceList);
  }
}


// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.max,
    );
    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(36.0),
      topRight: Radius.circular(36.0),
    );

    return Scaffold(
        body: Stack(
          children: <Widget>[SlidingUpPanel(
            controller: _pc,
            maxHeight: 600,
            minHeight: 64,
            backdropEnabled: true,
            panel: userProfiles(),

            collapsed: Container(
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: radius,
              ),
              child: Center(
                child: Text(
                  "Swipe Up To Modify Profile",
                  style: TextStyle(color: Colors.blueGrey),
                ),
              ),
            ),

            body: Stack(
              children: <Widget>[
                FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If the Future is complete, display the preview.
                      return CameraPreview(_controller);
                    } else {
                      // Otherwise, display a loading indicator.
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 72,
                  child: takePictureButton,
                ),
              ],
            ),
            borderRadius: radius,
          ),
            Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Center(
                      child:  Image.asset(
                        "assets/aller-free-logo-white.png",
                        width: 240,
                      ),
                    ),
                  ),
                ]
            ),
          ],
        )
    );
  }

  Widget get takePictureButton {
    return Container(
      height: 100,
      width: 100,
      child: FittedBox(
        child: FloatingActionButton(
          child: Icon(Icons.camera_alt),
          backgroundColor: Colors.green,
          tooltip: 'Tap this button to take a picture',
          // Provide an onPressed callback.
          onPressed: () async {
            // Take the Picture in a try / catch block. If anything goes wrong,
            // catch the error.
            try {
              // Ensure that the camera is initialized.
              await _initializeControllerFuture;

              // Construct the path where the image should be saved using the
              // pattern package.
              final path = join(
                // Store the picture in the temp directory.
                // Find the temp directory using the `path_provider` plugin.
                (await getTemporaryDirectory()).path,
                '${DateTime.now()}.png',
              );

              // Attempt to take a picture and log where it's been saved.
              await _controller.takePicture(path);


              globals.analyzedText = await analyzeText(path);


//              analyzeText(path);
              // If the picture was taken, display it on a new screen.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DisplayPictureScreen(imagePath: path),
                ),
              );
            } catch (e) {
              // If an error occurs, log the error to the console.
              print(e);
            }
          },
        ),
      ),
    );
  }



}
