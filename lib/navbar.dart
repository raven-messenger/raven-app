import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class RavenNavBar extends BottomNavigationBar {
  BuildContext context;
  PageController pageController;

  //TODO: navbar doesn't change selected item

  RavenNavBar(this.context, this.pageController)
      : super(
          items: [
            new BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text("Chat"),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.lock),
              title: new Text("Generate"),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.camera),
              title: new Text("Scan"),
            ),
          ],
          onTap: (index) {
            pageController.animateToPage(index,
                duration: new Duration(milliseconds: 500),
                curve: Curves.easeOut);
          },
//        type: BottomNavigationBarType.shifting,
        );
}
