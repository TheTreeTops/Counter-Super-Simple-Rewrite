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
      title: 'Counter App',
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.activeBlue,
      ),
      home: MyHomePage(title: 'Counter - Enhanced'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _incrementCounter() async {
    setState(() {
      _counter++;
    });
    await _saveCounter();
  }

  Future<void> _decrementCounter() async {
    setState(() {
      _counter--;
    });
    await _saveCounter();
  }

  Future<void> _clearCounter() async {
    setState(() {
      _counter = 0;
    });
    await _saveCounter();
  }

  Future<void> _resetCounter() async {
    setState(() {
      _counter = 0;
    });
    await _saveCounter();
  }

  Future<void> _saveCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _counter);
  }

  Future<void> _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return CupertinoPageScaffold(
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title),
        trailing: CupertinoButton(
          child: Icon(CupertinoIcons.gear),
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
      child: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      '$_counter',
                      style: TextStyle(
                        fontSize: 40.0,
                        color: CupertinoColors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CupertinoButton(
                        child: Text(
                          '-1',
                          style: TextStyle(color: CupertinoColors.white),
                        ),
                        color: CupertinoColors.destructiveRed,
                        onPressed: _decrementCounter,
                      ),
                      CupertinoButton(
                        child: Text(
                          '+1',
                          style: TextStyle(color: CupertinoColors.white),
                        ),
                        color: CupertinoColors.activeGreen,
                        onPressed: _incrementCounter,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: CupertinoButton(
              child: Icon(CupertinoIcons.refresh, color: CupertinoColors.white),
              color: CupertinoColors.systemOrange,
              onPressed: _resetCounter,
            ),
          ),
        ],
      ),
    );
  }
}
