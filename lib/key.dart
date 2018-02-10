class Key {
  // Name of the user chatting with
  String user;
  // UUID of convo
  int convoId;
  // List of the One Time Pads
  List<String> oneTimePads;

  Key(String user, int convoId, List<String> oneTimePads) {
    this.user = user;
    this.convoId = convoId;
    this.oneTimePads = oneTimePads;
  }

  Key.fromJson(Map<String, dynamic> json)
      : user = json['user'],
        convoId = json['convoId'],
        oneTimePads = json['oneTimePads'];

  Map<String, dynamic> toJson() =>
      {
        'user' : user,
        'convoId': convoId,
        'oneTimePads' : oneTimePads,
      };

  @override
  String toString(){
    return this.user + ", " + convoId.toString() + ", " + oneTimePads.toString();
  }



}