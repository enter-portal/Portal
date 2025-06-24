// Define a simple User class to structure the data
class User {
  final String name;
  final String lastMessage;
  final String time;
  final String avatarUrl;
  final int unreadCount;

  User({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.avatarUrl,
    required this.unreadCount,
  });

  // Optional: A factory constructor to create a User from a Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
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

final List<String> names = [
  "Alice Johnson",
  "Michael Smith",
  "sophia Lee",
  "James Brown",
  "Emily Davis",
  "Daniel Wilson",
  "Olivia Martinez",
  "Liam Anderson",
  "Isabella Thomas",
  "Noah Taylor",
  "Ava Moore",
  "Ethan Jackson",
  "Mia White",
  "Logan Harris",
  "Charlotte Clark",
  "Lucas Lewis",
  "Amelia Hall",
  "Mason Young",
  "Harper King",
  "Elijah Wright",
];

final List<String> messages = [
  "Hey, how's it going?",
  "Let's catch up tomorrow.",
  "Did you finish the report?",
  "Happy Birthday!",
  "Call me when you're free.",
  "see you at the event.",
  "I'll send the files soon.",
  "Great job today!",
  "Thanks for the update.",
  "Where are you?",
  "Lunch at 1 PM?",
  "That sounds awesome!",
  "I'mon my way.",
  "Meeting got postponed.",
  "Let me check and reply.",
  "Let's discuss this later.",
  "I'min a call right now.",
  "All set for the trip!",
  "I'll book the tickets.",
  "Congrats on the promotion!",
];

final List<String> times = [
  "9:30 AM",
  "10:15 AM",
  "11:45 AM",
  "12:00 PM",
  "1:20 PM",
  "2:35 PM",
  "3:00 PM",
  "4:10 PM",
  "5:25 PM",
  "6:45 PM",
  "7:00 PM",
  "8:15 PM",
  "9:40 PM",
  "10:05 PM",
  "11:50 PM",
  "Yesterday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Friday",
];

List<User> getUsers() {
  List<User> users = [];

  for (int i = 0; i < names.length; i++) {
    final name = names[i];
    // final avatarUrl = "https://api.dicebear.com/9.x/lorelei/png?flip=false&seed=$name";
    final avatarUrl = "https://api.dicebear.com/9.x/pixel-art/png?seed=$name";
    users.add(
      User(
        name: name,
        lastMessage: messages[i],
        time: times[i],
        avatarUrl: avatarUrl,
        unreadCount: i % 4, // 0 to 3 unread messages
      ),
    );
  }

  return users;
}
