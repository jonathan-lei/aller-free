
import 'package:flutter/material.dart';
import 'package:allerfree/globals.dart' as globals;

class userProfiles extends StatefulWidget {
  userProfiles({Key key}) : super(key: key);

  @override
  _userProfiles createState() => _userProfiles();
}

class _userProfiles extends State<userProfiles> {

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 48.0, bottom: 12.0),
              color: Colors.blueGrey[600],
              width: 96.0,
              height: 6.0,
            ),
            Text(
              "Swipe down to exit", style: TextStyle(color: Colors.blueGrey),),
            Container(
              margin: const EdgeInsets.only(bottom: 16.0),
            ),
            // REMOVE FOR DEMO START
            Image.asset(
              'assets/default-user.png',
              height: 200,
              width: 200,
            ),
            //REMOVE FOR DEMO END
            //ADD FOR DEMO START
//            globals.selectedUser=='Grandma'? Image.asset(
//              'assets/user-grandma.png',
//              height: 200,
//              width: 200,
//            ) : Image.asset(
//              'assets/user-jonathan.png',
//              height: 200,
//              width: 200,
//            ),
            //ADD FOR DEMO END
            Container(
              margin: const EdgeInsets.only(top: 12.0, bottom: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                //REMOVE FOR DEMO START
                children: <Widget>[

                Text("User",style: TextStyle(
                  fontSize: 36,
                  color: Colors.green[600],
                  decoration: TextDecoration.none,
                ),),
              ],
                //REMOVE FOR DEMO END
                //ADD FOR DEMO START
//                children: <Widget>[
//                  DropdownButton<String>(
//                    value: globals.selectedUser,
//                    icon: Icon(Icons.keyboard_arrow_down),
//                    iconSize: 24,
//                    elevation: 8,
//                    underline: Container(
//                      height: 2,
//                      color: Colors.green[600],
//                    ),
//                    onChanged: (String newValue) {
//                      setState(() {
//                        globals.selectedUser = newValue;
//                        _setPerson();
//                      });
//                    },
//                    items: globals.users
//                        .map<DropdownMenuItem<String>>((String value) {
//                      return DropdownMenuItem<String>(
//                        value: value,
//                        child: Text(value,
//                          style: TextStyle(
//                            fontSize: 36,
//                            color: Colors.green[600],
//                            decoration: TextDecoration.none,
//                          ),
//                        ),
//                      );
//                    }).toList(),
//                  ),
//                ],
                //ADD TO DEMO END
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(24.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
//              border: Border.all(
//                width: 4.0, color: Colors.green.shade600,
//              ),
                ),
                child: Wrap(
                  children: <Widget>[
                    const Center(
                      child: Text('Tap on an allergen to remove it'),
                    ),
                    Theme(
                      data: ThemeData.dark(),
                      child: Wrap(
                        spacing: 4.0,
                        children: _setPerson(),
                      ),
                    ),
                    ActionChip(
                        avatar: Icon(Icons.add),
                        backgroundColor: Colors.grey[400],
                        label: Text("Add More"),
                        onPressed: () {
                          _neverSatisfied();
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _neverSatisfied() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Allergens'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Add a suggested ingredient: '),
                Wrap(
                  children: <Widget>[
                    Wrap(
                      children: List.generate(
                          globals.allergenChoices.length, (index) {
                        if (globals.allergenChoices[globals
                            .allergenChoiceList[index]] == false) {
                          return RawChip(
                            label: Text(
                                globals.allergenChoiceList[index].toString()),
                            backgroundColor: Colors.grey[300],
                            selected: false,
                            onSelected: (bool isSelected) {
                              setState(() {
                                globals.allergenChoices[globals
                                    .allergenChoiceList[index]] = true;
                                Navigator.of(context, rootNavigator: true).pop(
                                    'dialog');
                                _neverSatisfied();
                              });
                            },
                            showCheckmark: true,
                          );
                        } else {
                          return Wrap();
                        }
                      }),
                    ),
                    Text('Add a custom ingredient: '),
                    TextField(
                        controller: myController
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Save Custom Ingredient'),
              onPressed: () {
                setState(() {
                  if (!globals.allergenChoiceList.contains(
                      myController.text.toUpperCase())) {
                    globals.allergenChoiceList.add(
                        myController.text.toUpperCase());
                  }
                  globals.allergenChoices[myController.text.toUpperCase()] =
                  true;
                  Navigator.of(context).pop();
                });
              },
            ),
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSnackbar(BuildContext context) {
    final scaff = Scaffold.of(context);
    scaff.showSnackBar(SnackBar(
      content: Text("Hay this is it"),
      backgroundColor: Color.fromARGB(255, 255, 0, 0),
      duration: Duration(seconds: 5),
      action: SnackBarAction(
        label: 'UNDO', onPressed: scaff.hideCurrentSnackBar,
      ),
    ));
  }

  List<Widget> _setPerson() {

//    ADD FOR DEMO START
//    if (globals.selectedUser == "Grandma") {
//      return List.generate(globals.allergenChoicesProfile2.length, (index) {
//        if (globals.allergenChoicesProfile2[globals.allergenChoiceListProfile2[index]] ==
//            true) {
//          return RawChip(
//            label: Text(globals.allergenChoiceListProfile2[index].toString()),
//            labelStyle: TextStyle(
//              color: Colors.white,
//              fontSize: 16,
//            ),
//            backgroundColor: Colors.grey,
//            selected: true,
//            selectedColor: Colors.green[500],
//            onSelected: (bool isSelected) {
//              setState(() {
//                globals.allergenChoicesProfile2[globals.allergenChoiceListProfile2[index]] =
//                false;
//                globals.allergenChoiceListProfile2.remove(index);
//              });
//            },
//            showCheckmark: true,
//          );
//        } else {
//          return Wrap();
//        }
//      });
//    } else {
      //ADD FOR DEMO END
      return List.generate(globals.allergenChoices.length, (index) {
        if (globals.allergenChoices[globals.allergenChoiceList[index]] ==
            true) {
          return RawChip(
            label: Text(globals.allergenChoiceList[index].toString()),
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            backgroundColor: Colors.grey,
            selected: true,
            selectedColor: Colors.green[500],
            onSelected: (bool isSelected) {
              setState(() {
                globals.allergenChoices[globals.allergenChoiceList[index]] =
                false;
                globals.allergenChoiceList.remove(index);
              });
            },
            showCheckmark: true,
          );
        } else {
          return Wrap();
        }
      });
    }
    //ADD FOR DEMO START
//  }
  //ADD FOR DEMO END
}