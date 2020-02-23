import 'package:flutter/material.dart';

import 'common.dart';
import 'overlay.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static bool bottomSheetVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade900,
        child: Center(
          child: Column(children: <Widget>[
            Spacer(),
            Text(
              "FOO GAME",
              style: TextStyle(fontSize: 48),
            ),
            Text(
              "A minimalist platformer game",
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            RaisedButton(
              child: Text("Start"),
              onPressed: () {
                if (!bottomSheetVisible) {
                  bottomSheetVisible = true;
                  showBottomSheet(
                    elevation: 2,
                    context: context,
                    builder: (context) => FileSelector(),
                  );
                }
              },
            ),
            Spacer(flex: 3),
          ]),
        ),
      ),
    );
  }
}

class FileSelector extends StatelessWidget {
  const FileSelector({Key key}) : super(key: key);

  final double buttonPadding = 8;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: darkBlue,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(children: <Widget>[
          Spacer(flex: 1),
          IconButton(
            onPressed: () {
              _HomePageState.bottomSheetVisible = false;
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_downward),
            color: Colors.white,
          ),
          Text(
            "Select file",
            style: TextStyle(fontSize: 16),
          ),
          Spacer(flex: 256),
          RaisedButton(
            padding: EdgeInsets.all(buttonPadding),
            child: Text(
              "File 1",
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () => Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, anim1, anim2) => GameOverlay(),
              transitionsBuilder: pageTransition,
            )),
          ),
          Spacer(flex: 1),
          RaisedButton(
            padding: EdgeInsets.all(buttonPadding),
            child: Text(
              "File 2",
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {},
          ),
          Spacer(flex: 1),
          RaisedButton(
            padding: EdgeInsets.all(buttonPadding),
            child: Text(
              "File 3",
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {},
          ),
          Spacer(flex: 32),
        ]),
      ),
    );
  }
}
