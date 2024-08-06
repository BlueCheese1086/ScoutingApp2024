// ignore_for_file: sized_box_for_whitespace

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.storage.request();
  createInfoFile();
  runApp(const MyApp());
}

getQRdata() async {
  String data = await readFile();
  if (data == "An Error occured" || data.isEmpty) {
    qrData = "";
  } else {
    qrData = data;
  }
}

String hightext() {
  if (_isteleop) {
    return "Note Scored High Teleop";
  } else {
    return "Note Scored High Auto";
  }
}

String lowtext() {
  if (_isteleop) {
    return "Note Scored In Amp Teleop";
  } else {
    return "Note Scored In Amp Auto";
  }
}

String missedtext() {
  if (_isteleop) {
    return "Missed Notes Teleop";
  } else {
    return "Missed Notes Auto";
  }
}

String determineHighVal() {
  if (_isteleop) {
    return "$_notescorehighteleop";
  } else {
    return "$_notescorehighauto";
  }
}

String determineLowVal() {
  if (_isteleop) {
    return "$_notescorelowteleop";
  } else {
    return "$_notescorelowauto";
  }
}

String determineMissedVal() {
  if (_isteleop) {
    return "$_notemissedteleop";
  } else {
    return "$_notemissedauto";
  }
}

void _incrementteleoplow(bool increase) {
  if (increase) {
    _notescorelowteleop++;
  } else {
    if (_notescorelowteleop > 0) {
      _notescorelowteleop--;
    }
  }
}

void _incrementteleophigh(bool increase) {
  if (increase) {
    _notescorehighteleop++;
  } else {
    if (_notescorehighteleop > 0) {
      _notescorehighteleop--;
    }
  }
}

void _incrementautolow(bool increase) {
  if (increase) {
    _notescorelowauto++;
  } else {
    if (_notescorelowauto > 0) {
      _notescorelowauto--;
    }
  }
}

void _incrementautohigh(bool increase) {
  if (increase) {
    _notescorehighauto++;
  } else {
    if (_notescorehighauto > 0) {
      _notescorehighauto--;
    }
  }
}

void _incrementmissedauto(bool increase) {
  if (increase) {
    _notemissedauto++;
  } else {
    if (_notemissedauto > 0) {
      _notemissedauto--;
    }
  }
}

void _incrementmissedteleop(bool increase) {
  if (increase) {
    _notemissedteleop++;
  } else {
    if (_notemissedteleop > 0) {
      _notemissedteleop--;
    }
  }
}

createInfoFile() async {
  if (await Permission.manageExternalStorage.request().isGranted) {
    Directory? localDir = await getApplicationDocumentsDirectory();
    String localPath = localDir.path;
    File file = File('$localPath/info.json');
    await file.create();
  }
}

Future<File> writeData(String data) async {
  if (await Permission.manageExternalStorage.request().isGranted) {
    Directory? localDir = await getApplicationDocumentsDirectory();
    String localPath = localDir.path;
    File file = File('$localPath/info.json');
    return file.writeAsString(data);
  }
  return File("File not found");
}

Future<File> writeInternalData(String data) async {
  if (await Permission.manageExternalStorage.request().isGranted) {
    Directory? localDir = await getApplicationDocumentsDirectory();
    String localPath = localDir.path;
    File file = File('$localPath/app.json');
    return file.writeAsString(data);
  }
  return File("File not found");
}

Future<String> readFile() async {
  try {
    if (await Permission.manageExternalStorage.request().isGranted) {
      Directory? localDir = await getApplicationDocumentsDirectory();
      String localPath = localDir.path;
      File file = File('$localPath/info.json');
      final contents = await file.readAsString();
      return contents;
    }
    return "An Error occured";
  } catch (e) {
    return "an Error occured";
  }
}

late String robot;
late String qrData;
String _teamnumber = '1086';
String _matchnumber = '1';
bool _isteleop = false;
bool _istrap = false;
int _notescorehighteleop = 0;
int _notescorelowteleop = 0;
int _notescorehighauto = 0;
int _notescorelowauto = 0;
int _notemissedauto = 0;
int _notemissedteleop = 0;
int _harmonize = 0;
String _hangState = "Did not hang";
String _robotState = "Played";
String passwordMessage = "";
String password = "";
int _rating = 0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scouting App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    Future<void> submitPopup(BuildContext context) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Submitted'),
            content: const Text('Stored to files!'),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Red 1'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              Column(
                children: <Widget>[
                  const Row(
                  children: <Widget>[
                    Text('Team Number:'),
                    Padding(padding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 5)),
                    Text('Match Number:'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Team Number',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          _teamnumber = text;
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 5)),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Match Number',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          _matchnumber = text;
                        },
                      ),
                    ),
                  ]
                ),
                ],
              ),
              Row(
                children: <Widget>[
                  const Text('Teleop?'),
                  Checkbox(
                      value: _isteleop,
                      checkColor: Colors.white,
                      activeColor: Colors.blue,
                      onChanged: (bool? value) {
                        setState(() {
                          _isteleop = value!;
                        });
                      })
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    hightext(),
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    determineHighVal(),
                    style: const TextStyle(fontSize: 15),
                  ),
                  Row(
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () => {
                          setState(() {
                            if (_isteleop) {
                              _incrementteleophigh(false);
                            } else {
                              _incrementautohigh(false);
                            }
                          })
                        },
                        child: const Text('-'),
                      ),
                      FloatingActionButton(
                        onPressed: () => {
                          setState(() {
                            if (_isteleop) {
                              _incrementteleophigh(true);
                            } else {
                              _incrementautohigh(true);
                            }
                          })
                        },
                        child: const Text('+'),
                      )
                    ],
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    lowtext(),
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    determineLowVal(),
                    style: const TextStyle(fontSize: 15),
                  ),
                  Row(
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () => {
                          setState(() {
                            if (_isteleop) {
                              _incrementteleoplow(false);
                            } else {
                              _incrementautolow(false);
                            }
                          })
                        },
                        child: const Text('-'),
                      ),
                      FloatingActionButton(
                        onPressed: () => {
                          setState(() {
                            if (_isteleop) {
                              _incrementteleoplow(true);
                            } else {
                              _incrementautolow(true);
                            }
                          })
                        },
                        child: const Text('+'),
                      )
                    ],
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    missedtext(),
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    determineMissedVal(),
                    style: const TextStyle(fontSize: 15),
                  ),
                  Row(
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () => {
                          setState(() {
                            if (_isteleop) {
                              _incrementmissedteleop(false);
                            } else {
                              _incrementmissedauto(false);
                            }
                          })
                        },
                        child: const Text('-'),
                      ),
                      FloatingActionButton(
                        onPressed: () => {
                          setState(() {
                            if (_isteleop) {
                              _incrementmissedteleop(true);
                            } else {
                              _incrementmissedauto(true);
                            }
                          })
                        },
                        child: const Text('+'),
                      )
                    ],
                  )
                ],
              ),
            ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const Text('Amplify Number'),
                    Text(
                      '$_harmonize',
                      style: const TextStyle(fontSize: 15),
                    ),
                    Row(
                      children: <Widget>[
                        FloatingActionButton(
                          onPressed: () => {
                            setState(() {
                              if (_harmonize > 0) {
                                _harmonize--;
                              }
                            })
                          },
                          child: const Text('-'),
                        ),
                        FloatingActionButton(
                          onPressed: () => {
                            setState(() {
                              _harmonize++;
                            })
                          },
                          child: const Text('+'),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const Text('Trap?'),
                    Checkbox(
                        value: _istrap,
                        checkColor: Colors.white,
                        activeColor: Colors.blue,
                        onChanged: (bool? value) {
                          setState(() {
                            _istrap = value!;
                          });
                        })
                  ],
                ),
                Column(
                  children: <Widget>[
                    const Text('Hang State'),
                    DropdownButton(
                      value: _hangState,
                      items: const [
                        DropdownMenuItem(
                            value: 'Did not hang', child: Text("Did not hang")),
                        DropdownMenuItem(
                            value: 'Hanging alone',
                            child: Text("Hanging alone")),
                        DropdownMenuItem(
                            value: 'Hanging with 1 robot',
                            child: Text("Hanging with 1 robot")),
                        DropdownMenuItem(
                            value: 'Hanging with 2 robots',
                            child: Text("Hanging with 2 robots"))
                      ],
                      onChanged: (value) {
                        setState(() {
                          _hangState = value!;
                        });
                      },
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    const Text('Robot State'),
                    DropdownButton(
                      value: _robotState,
                      items: const [
                        DropdownMenuItem(
                            value: 'Played', child: Text("Played")),
                        DropdownMenuItem(
                            value: 'Did not show', child: Text("Did not show")),
                        DropdownMenuItem(
                            value: 'Tipped', child: Text("Tipped")),
                        DropdownMenuItem(
                            value: 'Disabled', child: Text("Disabled"))
                      ],
                      onChanged: (value) {
                        setState(() {
                          _robotState = value!;
                        });
                      },
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    const Text('Rating'),
                    Slider(
                      value: _rating.toDouble(),
                      max: 10,
                      divisions: 10,
                      label: _rating.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _rating = value.round();
                        });
                      },
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String data =
              "{\"teamNumber\": \"$_teamnumber\", \"matchNumber\": \"$_matchnumber\", \"notesHighAuto\": \"$_notescorehighauto\", \"notesHighTeleop\": \"$_notescorehighteleop\", \"notesLowAuto\": \"$_notescorelowauto\", \"notesMissedAuto\": \"$_notemissedauto\", \"notesMissedTeleop\": \"$_notemissedteleop\", \"amplify\": \"$_harmonize\", \"hangState\": \"$_hangState\", \"robotState\": \"$_robotState\", \"rating\": \"$_rating\", \"didTrap\": \"$_istrap\"}";
          readFile().then((String content) {
            if (content.isEmpty) {
              writeData("{\"root\": [$data]}");
              qrData = "{\"root\": [$data]}";
            } else {
              content = content.substring(0, content.length - 2);
              writeData("$content, $data]}");
              qrData = "$content, $data]}";
            }
          });
          setState(() {
            _teamnumber = '1086';
            _matchnumber = '1';
            _isteleop = false;
            _istrap = false;
            _notescorehighteleop = 0;
            _notescorelowteleop = 0;
            _notescorehighauto = 0;
            _notescorelowauto = 0;
            _notemissedauto = 0;
            _notemissedteleop = 0;
            _harmonize = 0;
            _hangState = "Did not hang";
            _robotState = "Played";
            _rating = 0;
          });
          submitPopup(context);
        },
        tooltip: 'Submit',
        child: const Text('Submit'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}