import 'dart:io';
import 'package:allerfree/main.dart';
import 'package:flutter/material.dart';
import 'package:allerfree/globals.dart' as globals;

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  DisplayPictureScreen ({Key key, this.imagePath}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(title: Text('Results')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 224,
              floating: false,
              backgroundColor: Colors.blueGrey,
              pinned: false,
              flexibleSpace: Stack(
                children: <Widget>[
                  Positioned.fill(
                      child: Image.file(
                        File(imagePath),
                        fit: BoxFit.cover,
                      )
                  )
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  globals.allergenContainsList.isEmpty? Container(color: Colors.green[600], height: 4.0):
                  Container(color: Colors.red, height: 4.0),
                  Container(
                    padding: const EdgeInsets.all(24.0),
                    child: Image.asset(
                      "assets/aller-free-logo-black.png",
                      height: 36.0,
                    ),
                  ),
                  Container(color: Colors.grey[200], height: 2.0),
                  Container(
                    margin: const EdgeInsets.all(24.0),
                    padding: const EdgeInsets.all(36.0),
                    decoration: decoration(),
                    child: Stack(
                      children: <Widget>[
                        globals.allergenContainsList.isEmpty? Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 32.0,
                        ) : Icon(
                          Icons.clear,
                          color: Colors.red,
                          size: 32.0,
                        ),
                        Column(
                          children: <Widget>[
                            Center(
                              child: globals.allergenContainsList.isEmpty? Column(children: <Widget>[Text(
                                'Safe',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26.0,
                                  color: Colors.black,
                                ),
                              ),Container(padding: const EdgeInsets.only(top: 24.0),
                                child: Text("Please verify results before purchasing or consuming the product",
                                  textAlign: TextAlign.center,),)
                              ],) : Column(children: <Widget>[Text(
                                'Not Safe',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26.0,
                                  color: Colors.black,
                                ),
                              ),Container(padding: const EdgeInsets.only(top: 24.0),
                                child: Text("Please verify results before acting upon these results.",
                                  textAlign: TextAlign.center,),)
                              ],)
                            ),


                            Wrap(
                              spacing: 4.0,
                              children: List.generate(globals.allergenContainsList.length,(index){
//                                if(globals.allergenContainsList[index]==true){
                                  return RawChip(
                                    label: Text(globals.allergenContainsList[index].toString()),
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    backgroundColor: Colors.red,
                                    onSelected: (bool isSelected) {
//                                      setState(() {
//                                        globals.allergenChoices[globals.allergenChoiceList[index]]=false;
//                                        globals.allergenChoiceList.remove(index);
//                                      });
                                    },
                                  );
//                                }else{
//                                  return Wrap();
//                                }
                              }),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(24.0),
                    padding: const EdgeInsets.all(36.0),
                    decoration:  BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      border: Border.all(
                        width: 4.0,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                            'Scanned Text',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Text(globals.analyzedText),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      floatingActionButton: Transform.scale(
        scale: 1.3,
        child: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
            Navigator.popUntil(context, ModalRoute.withName('/'));

          },
          child: Icon(Icons.sync),
          backgroundColor: Colors.green,
        ),
      ),floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
  BoxDecoration decoration(){
    if(globals.allergenContainsList.isEmpty){
      return BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        border: Border.all(
          width: 4.0, color: Colors.green.shade600,
        ),
      );
    }
    return BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(24)),
      border: Border.all(
        width: 4.0, color: Colors.red,
      ),
    );
  }
}
