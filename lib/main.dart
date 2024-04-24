import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Counter',
      theme: CupertinoThemeData(
        brightness: Brightness.dark, // This line sets the theme to dark mode
        primaryColor: CupertinoColors.white,
      ),
      home: MyHomePage(key: UniqueKey(), title: 'Counter - Super Simple'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _clearCounter() {
    setState(() {
      _counter = 0;
    });
  }

  Future<void> _saveCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _counter);
  }

  Future<void> _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title),
        trailing: CupertinoButton(
          child: Icon(CupertinoIcons.gear_alt),
          padding: EdgeInsets.zero,
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) => CupertinoActionSheet(
                title: Text('Settings'),
                actions: <CupertinoActionSheetAction>[
                  CupertinoActionSheetAction(
                    child: Text('Clear Count'),
                    onPressed: () {
                      Navigator.pop(context);
                      _clearCounter();
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: Text('Save Count'),
                    onPressed: () {
                      Navigator.pop(context);
                      _saveCounter();
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: Text('Load Count'),
                    onPressed: () {
                      Navigator.pop(context);
                      _loadCounter();
                    },
                  ),
                ],
                cancelButton: CupertinoActionSheetAction(
                  child: Text('Cancel'),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
        ),
      ),
      child: Column(
        children: <Widget>[
          // Top Spacer
          Expanded(
            flex: 1,
            child: Container(),
          ),
          // Centered Counter Text
          Center(
            child: Text(
              '$_counter',
              style: TextStyle(
                fontSize: 40.0,
                color: CupertinoColors.white,
              ),
            ),
          ),
          // Bottom Spacer
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: CupertinoButton(
                    padding: EdgeInsets.all(16.0),
                    child: Text('-1', style: TextStyle(color: CupertinoColors.white)),
                    color: CupertinoColors.destructiveRed,
                    onPressed: _decrementCounter,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: CupertinoButton(
                    padding: EdgeInsets.all(16.0),
                    child: Text('+1', style: TextStyle(color: CupertinoColors.white)),
                    color: CupertinoColors.activeGreen,
                    onPressed: _incrementCounter,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20), // Extra space at the bottom
        ],
      ),
    );
  }
}