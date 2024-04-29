import 'package:flutter/cupertino.dart';
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
        brightness: Brightness.dark,
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
              builder: (BuildContext context) {
                return CupertinoActionSheet(
                  title: Text('Settings'),
                  actions: [
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Changed to move content down
          children: [
            Expanded(
              flex: 6, // Decreased to move the counter down
              child: Container(), // Empty space to push content down
            ),
            Center(
              child: Text(
                '$_counter',
                style: TextStyle(
                  fontSize: 40.0,
                  color: CupertinoColors.white,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(), // Additional space to move the content down
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: 200.0, // Set the height of the button
                        child: CupertinoButton(
                          padding: EdgeInsets.symmetric(horizontal: 16.0), // Remove vertical padding
                          child: Text('-1', style: TextStyle(color: CupertinoColors.white)),
                          color: CupertinoColors.destructiveRed,
                          onPressed: _decrementCounter,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        height: 200.0, // Set the height of the button
                        child: CupertinoButton(
                          padding: EdgeInsets.symmetric(horizontal: 16.0), // Remove vertical padding
                          child: Text('+1', style: TextStyle(color: CupertinoColors.white)),
                          color: CupertinoColors.activeGreen,
                          onPressed: _incrementCounter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
