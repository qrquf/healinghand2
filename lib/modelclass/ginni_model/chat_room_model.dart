

class ChatRoomModel {
  String? chatroomid;
  String? firstmessage;

  ChatRoomModel({this.chatroomid, this.firstmessage});

  ChatRoomModel.fromMap(Map<String, dynamic> map) {
    chatroomid = map["chatroomid"];
    firstmessage = map["firstmessage"];
  }

  Map<String, dynamic> toMap() {
    return {
      "chatroomid": chatroomid,
      "firstmessage": firstmessage
    };
  }
}
