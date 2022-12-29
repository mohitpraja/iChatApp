class ChatUser {
  String? image;
  String? name;
  String? about;
  String? createdAt;
  String? lastActive;
  bool? isOnline;
  String? id;
  String? email;
  String? pushToken;

  ChatUser({this.image, this.name, this.about, this.createdAt, this.lastActive, this.isOnline, this.id, this.email, this.pushToken});

  ChatUser.fromJson(Map<String, dynamic> json) {
    if(json["image"] is String) {
      image = json["image"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["about"] is String) {
      about = json["about"];
    }
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if(json["last_active"] is String) {
      lastActive = json["last_active"];
    }
    if(json["is_online"] is bool) {
      isOnline = json["is_online"];
    }
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    if(json["push_token"] is String) {
      pushToken = json["push_token"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["image"] = image;
    data["name"] = name;
    data["about"] = about;
    data["created_at"] = createdAt;
    data["last_active"] = lastActive;
    data["is_online"] = isOnline;
    data["id"] = id;
    data["email"] = email;
    data["push_token"] = pushToken;
    return data;
  }
}