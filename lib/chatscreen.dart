import 'dart:async';
import 'user.dart';

import 'otp.dart';
import 'random.dart';
import 'serialize.dart';
import 'constants.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'main.dart';

final googleSignIn = new GoogleSignIn();
final currentConfig = new CurrentConfig(googleSignIn);
final analytics = new FirebaseAnalytics();
final auth = FirebaseAuth.instance;
User user;
OneTimePad otp = new OneTimePad(RandomSeed.generateSeed());
// List<User> recipients;

class ChatScreen extends StatefulWidget {
  @override
  State createState() {
    getUser();
    return new ChatScreenState();
  }

  Future<User> getUser() async {
    user = await currentConfig.getUser();
    return user;
  }

//  Future<List<User>> getRecipients() async {
//    recipients = await currentConfig.getRecipients();
//    return recipients;
//  }
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;

  final reference = FirebaseDatabase.instance.reference().child('messages');

  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: MediaQuery.of(context).padding,
        child: new Column(
          children: <Widget>[
            new Flexible(
              child: new FirebaseAnimatedList(
                query: reference,
                sort: (a, b) => b.key.compareTo(a.key),
                padding: new EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder:
                    (_, DataSnapshot snapshot, Animation<double> animation) {
                  return new ChatMessage(
                    snapshot: snapshot,
                    animation: animation,
                  );
                },
              ),
            ),
            new Divider(height: 1.0),
            new Container(
              decoration: new BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ],
        ),
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? new BoxDecoration(
                border: new Border(
                  top: new BorderSide(color: Colors.grey[200]),
                ),
              )
            : null);
  }

  Future<Null> _handleSubmitted(String text) async {
//    User desiredRecipient;
//
//    List<Widget> options = new List<Widget>.generate(
//      recipients.length,
//      (index) {
//        return new SimpleDialogOption(
//          onPressed: () {
//            desiredRecipient = recipients.elementAt(index);
//          },
//          child: new Text(recipients.elementAt(index).uid),
//        );
//      },
//    );
//    showDialog(
//      context: context,
//      child: new SimpleDialog(
//        title: const Text("Select a recipient"),
//        children: options,
//      ),
//    );

    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    await _ensureLoggedIn();
    _sendMessage(
        // desiredRecipient,
      text,
      0,
      0
    );
  }

  void _sendMessage(// User recipient,
  String text, int seedIndex, int otpIndex) {

    DatabaseReference tableReference =
        FirebaseDatabase.instance.reference().child("messages");
    tableReference.push().set({
      'senderName': googleSignIn.currentUser.displayName,
      'senderPhotoUrl': googleSignIn.currentUser.photoUrl,
      'text': otp.encodeMessage(text),
      'seedIndex': seedIndex,
      'otpIndex': otpIndex,
    });
    analytics.logEvent(name: "send_message");
  }

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                maxLength: maxMessageLength,
                controller: _textController,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: _handleSubmitted,
                decoration:
                    new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: Theme.of(context).platform == TargetPlatform.iOS
                  ? new CupertinoButton(
                      child: new Text("Send"),
                      onPressed: _isComposing
                          ? () => _handleSubmitted(_textController.text)
                          : null,
                    )
                  : new IconButton(
                      icon: new Icon(Icons.send),
                      onPressed: _isComposing
                          ? () => _handleSubmitted(_textController.text)
                          : null,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _ensureLoggedIn() async {
    GoogleSignInAccount user = googleSignIn.currentUser;
    if (user == null) {
      user = await googleSignIn.signInSilently();
    }
    if (user == null) {
      await googleSignIn.signIn();
      analytics.logLogin();
    }
    if (await auth.currentUser() == null) {
      GoogleSignInAuthentication credentials =
          await googleSignIn.currentUser.authentication;
      await auth.signInWithGoogle(
        idToken: credentials.idToken,
        accessToken: credentials.accessToken,
      );
    }
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.snapshot, this.animation});

  final DataSnapshot snapshot;
  final Animation animation;

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(parent: animation, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: new Card(
        child: new Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: new CircleAvatar(
                  backgroundImage:
                      new NetworkImage(snapshot.value['senderPhotoUrl']),
                ),
              ),
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      snapshot.value['senderName'],
                      style: Theme.of(context).textTheme.subhead,
                    ),
                    new Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: new Text(otp.decodeMessage(snapshot
                          .value['text'])),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
