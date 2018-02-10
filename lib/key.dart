import 'encryption.dart';

class Key {
  // Name of the user chatting with
  String user;
  // UUID of convo
  int seedIndex;
  // List of the One Time Pads
  List<String> oneTimePads;
  // Use odd numbers
  bool odds;

  Key({this.user, this.seedIndex, this.oneTimePads, this.odds});

  Key.fromJson(Map<String, dynamic> json)
      : user = json['user'],
        seedIndex = json['convoId'],
        oneTimePads = json['oneTimePads'];

  Map<String, dynamic> toJson() =>
      {
        'user' : user,
        'convoId': seedIndex,
        'oneTimePads' : oneTimePads,
      };

  @override
  String toString(){
    return this.user + ", " + seedIndex.toString() + ", " + oneTimePads.toString();
  }

  // Sends the message
  String sendMessage(String msg){
    Encryption encyrpt = new Encryption();
    String cipher = encyrpt.xor(msg, oneTimePads.first);
  }



}