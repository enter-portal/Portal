/// Domain entity representing an authenticated session.
class Session {
  final String accessToken;
  final String refreshToken;
  final String userId;

  /// UTC timestamp when the access token expires.
  final DateTime expiresAt;

  const Session({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    required this.expiresAt,
  });

  bool get isExpired => DateTime.now().toUtc().isAfter(expiresAt);

  @override
  String toString() =>
      'Session(userId: $userId, expiresAt: $expiresAt, expired: $isExpired)';
}
