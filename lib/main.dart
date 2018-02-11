import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'constants.dart';

import 'chatscreen.dart';
import 'qrgenscreen.dart';
import 'qrscanscreen.dart';

import 'navbar.dart';

// solarized colors
final Color _primary = new Color.fromARGB(255, 7, 54, 66);
final Color _accent = new Color.fromARGB(255, 42, 161, 152);
final Color _background = new Color.fromARGB(255, 253, 246, 227);

final ThemeData _appTheme = new ThemeData(
  primaryColor: _primary,
  primaryColorBrightness: Brightness.dark,
  accentColor: _accent,
  backgroundColor: _background,
);

void main() {
  runApp(new RavenMessengerApp());
}

class RavenMessengerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new MaterialApp(
    title: appTitle,
    theme: _appTheme,
    color: _primary,
    home: new HomePage(),
  );
}

class HomePage extends StatefulWidget {
  @override
  State createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  final _controller = new PageController();

  final List<Widget> _pages = <Widget>[
    new ChatScreen(),
    new QRGenScreen(),
    new QRScanScreen(),
  ];

  RavenNavBar ravenNavBar;

  Widget bodyBuilder(BuildContext context) {
    return new Scaffold(
      body: new IconTheme(
        data: new IconThemeData(color: Colors.green),
        child: new Stack(
          children: <Widget>[
            new PageView.builder(
              physics: new NeverScrollableScrollPhysics(),
//              physics: new AlwaysScrollableScrollPhysics(),
              controller: _controller,
              itemBuilder: (BuildContext context, int index) {
                return _pages[index % _pages.length];
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ravenNavBar = new RavenNavBar(context, _controller);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(appTitle),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      bottomNavigationBar: ravenNavBar,
      body: bodyBuilder(context),
    );
  }
}
