/// Domain entity representing a user/contact in the chat list.
class User {
  final String name;
  final String lastMessage;
  final String time;
  final String avatarUrl;
  final int unreadCount;

  const User({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.avatarUrl,
    required this.unreadCount,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      lastMessage: map['lastMessage'] as String,
      time: map['time'] as String,
      avatarUrl: map['avatarUrl'] as String,
      unreadCount: map['unreadCount'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastMessage': lastMessage,
      'time': time,
      'avatarUrl': avatarUrl,
      'unreadCount': unreadCount,
    };
  }
}
