import 'package:flutter/material.dart';

import 'common.dart';
import 'data/store.dart';
import 'overlay.dart';
import 'settings.dart';

const bsd3License = '''BSD 3-Clause License

Copyright (c) 2020, gamer-gang
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its
   contributors may be used to endorse or promote products derived from
   this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.''';

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
        color: darkBlue,
        child: Stack(children: [
          Positioned(
            top: 0,
            right: 0,
            child: Row(children: [
              IconButton(
                onPressed: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'Monument Platformer',
                    applicationVersion: '0.1.0',
                    applicationIcon: Icon(Icons.gamepad),
                    applicationLegalese: bsd3License,
                  );
                },
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
              ),
            ]),
          ),
          Center(
            child: Column(children: <Widget>[
              Spacer(flex: 3),
              Text(
                "MONUMENT PLATFORMER",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 6,
                ),
              ),
              Spacer(),
              Text(
                "A minimalist platformer game",
                style: TextStyle(fontSize: 16),
              ),
              Spacer(),
              Row(children: [
                Spacer(flex: 128),
                RaisedButton(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow),
                      Text("Start"),
                    ],
                  ),
                  onPressed: () {
                    if (!bottomSheetVisible) {
                      bottomSheetVisible = true;
                      showBottomSheet(
                        elevation: 4,
                        context: context,
                        builder: (context) => FileSelector(),
                      );
                    }
                  },
                ),
                Spacer(),
                RaisedButton(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.settings),
                      Text('Settings'),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, anim1, anim2) => SettingsPage(),
                        transitionsBuilder: pageTransition,
                      ),
                    );
                  },
                ),
                Spacer(flex: 128),
              ]),
              Spacer(flex: 3),
            ]),
          ),
        ]),
      ),
    );
  }
}

class FileSelector extends StatelessWidget {
  final double _buttonPadding = 8;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: darkBlueAccent,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(children: [
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
            style: TextStyle(fontSize: 20),
          ),
          Spacer(flex: 256),
          RaisedButton(
            color: darkBlue,
            padding: EdgeInsets.all(_buttonPadding),
            child: Text(
              "File 1",
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, anim1, anim2) =>
                      GamePage(file: SaveFile.file1),
                  transitionsBuilder: pageTransition,
                ),
              );
            },
            onLongPress: () {
              // clearSaveFile(1);
            },
          ),
          Spacer(flex: 4),
          RaisedButton(
            color: darkBlue,
            padding: EdgeInsets.all(_buttonPadding),
            child: Text(
              "File 2",
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, anim1, anim2) =>
                    GamePage(file: SaveFile.file2),
                transitionsBuilder: pageTransition,
              ));
            },
          ),
          Spacer(flex: 4),
          RaisedButton(
            color: darkBlue,
            padding: EdgeInsets.all(_buttonPadding),
            child: Text(
              "File 3",
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, anim1, anim2) =>
                    GamePage(file: SaveFile.file3),
                transitionsBuilder: pageTransition,
              ));
            },
          ),
          Spacer(flex: 32),
        ]),
      ),
    );
  }
}
