import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portal/config/app_configs.dart';
import 'package:portal/domain/models/message.dart';
import 'package:portal/domain/models/user.dart';
import 'package:portal/data/repositories/message_repository.dart';
import 'package:portal/data/repositories/user_repository.dart';
import 'package:portal/data/services/logger_service.dart';

// ---------------------------------------------------------------------------
// Fake User Repository
// ---------------------------------------------------------------------------

class _FakeUserRepository implements UserRepository {
  static const List<String> _names = [
    'Alice Johnson',
    'Michael Smith',
    'Sophia Lee',
    'James Brown',
    'Emily Davis',
    'Daniel Wilson',
    'Olivia Martinez',
    'Liam Anderson',
    'Isabella Thomas',
    'Noah Taylor',
    'Ava Moore',
    'Ethan Jackson',
    'Mia White',
    'Logan Harris',
    'Charlotte Clark',
    'Lucas Lewis',
    'Amelia Hall',
    'Mason Young',
    'Harper King',
    'Elijah Wright',
  ];
  static const List<String> _messages = [
    "Hey, how's it going?",
    "Let's catch up tomorrow.",
    'Did you finish the report?',
    'Happy Birthday!',
    "Call me when you're free.",
    'See you at the event.',
    "I'll send the files soon.",
    'Great job today!',
    'Thanks for the update.',
    'Where are you?',
    'Lunch at 1 PM?',
    'That sounds awesome!',
    "I'm on my way.",
    'Meeting got postponed.',
    'Let me check and reply.',
    "Let's discuss this later.",
    "I'm in a call right now.",
    'All set for the trip!',
    "I'll book the tickets.",
    'Congrats on the promotion!',
  ];
  static const List<String> _times = [
    '9:30 AM',
    '10:15 AM',
    '11:45 AM',
    '12:00 PM',
    '1:20 PM',
    '2:35 PM',
    '3:00 PM',
    '4:10 PM',
    '5:25 PM',
    '6:45 PM',
    '7:00 PM',
    '8:15 PM',
    '9:40 PM',
    '10:05 PM',
    '11:50 PM',
    'Yesterday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Friday',
  ];

  @override
  Future<List<User>> getUsers() async {
    appLogger.d('[FakeChat] getUsers()');
    await Future.delayed(AppConfigs.fakeMediumDelay);
    return List.generate(_names.length, (i) {
      final name = _names[i];
      return User(
        name: name,
        lastMessage: _messages[i],
        time: _times[i],
        avatarUrl: 'https://api.dicebear.com/9.x/pixel-art/png?seed=$name',
        unreadCount: i % 4,
      );
    });
  }
}

// ---------------------------------------------------------------------------
// Fake Message Repository
// ---------------------------------------------------------------------------

class _FakeMessageRepository implements MessageRepository {
  static final List<Message> _static = [
    Message(
      sender: 'Alice',
      receiver: 'Bob',
      message: 'Hey Bob, how are you?',
      messageDigest: 'Hey Bob',
      type: 'text',
      isSent: true,
    ),
    Message(
      sender: 'Bob',
      receiver: 'Alice',
      message: "Hi Alice! I'm good, thanks. You?",
      messageDigest: "Hi Alice!",
      type: 'text',
      isSent: false,
    ),
    Message(
      sender: 'Alice',
      receiver: 'Bob',
      message: 'Wanna catch up over the weekend?',
      messageDigest: 'Wanna catch up',
      type: 'text',
      isSent: true,
    ),
    Message(
      sender: 'Bob',
      receiver: 'Alice',
      message: "Sure, let's do that!",
      messageDigest: "Sure!",
      type: 'text',
      isSent: false,
    ),
    Message(
      sender: 'Alice',
      receiver: 'Bob',
      message: 'Check out this photo 📸',
      messageDigest: 'Photo',
      type: 'image',
      isSent: true,
    ),
    Message(
      sender: 'Bob',
      receiver: 'Alice',
      message: 'Looks awesome!',
      messageDigest: 'Looks awesome!',
      type: 'text',
      isSent: false,
    ),
  ];

  static const List<String> _pushMessages = [
    "Hey, just seen your message!",
    "Sure, sounds great!",
    "Can you share the file?",
    "I'll be there in 5 minutes.",
    "Talk soon! 👋",
    "Roger that ✅",
  ];
  int _pushIndex = 0;

  @override
  Future<List<Message>> getMessages(String chatRoomId) async {
    appLogger.d('[FakeChat] getMessages(chatRoomId=$chatRoomId)');
    await Future.delayed(AppConfigs.fakeShortDelay);
    return List.unmodifiable(_static);
  }

  /// Emits a new fake message every 8 seconds, simulating a push from socket.io.
  /// Replace the body with socket.io event subscription when backend is ready.
  @override
  Stream<Message> watchMessages(String chatRoomId) {
    appLogger.d(
      '[FakeChat] watchMessages(chatRoomId=$chatRoomId) — streaming every 8s',
    );
    return Stream.periodic(const Duration(seconds: 8), (_) {
      final msg = _pushMessages[_pushIndex % _pushMessages.length];
      _pushIndex++;
      return Message(
        sender: 'Alice',
        receiver: 'Bob',
        message: msg,
        messageDigest: msg,
        type: 'text',
        isSent: false,
      );
    });
  }
}

// ---------------------------------------------------------------------------
// Providers
// ---------------------------------------------------------------------------

final userRepositoryProvider = Provider<UserRepository>(
  (_) => _FakeUserRepository(),
);
final messageRepositoryProvider = Provider<MessageRepository>(
  (_) => _FakeMessageRepository(),
);
