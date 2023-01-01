
class MessageModel {
  String? toId;
  String? msg;
  String? read;
  String? type;
  String? fromId;
  String? sent;

  MessageModel({this.toId, this.msg, this.read, this.type, this.fromId, this.sent});

  MessageModel.fromJson(Map<String, dynamic> json) {
    if(json["toId"] is String) {
      toId = json["toId"];
    }
    if(json["msg"] is String) {
      msg = json["msg"];
    }
    if(json["read"] is String) {
      read = json["read"];
    }
    if(json["type"] is String) {
      type = json["type"];
    }
    if(json["fromId"] is String) {
      fromId = json["fromId"];
    }
    if(json["sent"] is String) {
      sent = json["sent"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["toId"] = toId;
    data["msg"] = msg;
    data["read"] = read;
    data["type"] = type;
    data["fromId"] = fromId;
    data["sent"] = sent;
    return data;
  }
}