// Define a simple User class to structure the data
class UserModel {
  final String name;
  final String lastMessage;
  final String time;
  final String avatarUrl;
  final int unreadCount;

  UserModel({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.avatarUrl,
    required this.unreadCount,
  });

  // Optional: A factory constructor to create a User from a Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map["name"] as String,
      lastMessage: map["lastMessage"] as String,
      time: map["time"] as String,
      avatarUrl: map["avatarUrl"] as String,
      unreadCount: map["unreadCount"] as int,
    );
  }

  // Optional: Convert User object to a Map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "lastMessage": lastMessage,
      "time": time,
      "avatarUrl": avatarUrl,
      "unreadCount": unreadCount,
    };
  }
}
