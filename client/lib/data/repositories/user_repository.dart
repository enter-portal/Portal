import 'package:portal/domain/models/user.dart';

/// Abstract contract for user/contact data access.
/// All methods are async to support both network and DB reads.
abstract interface class UserRepository {
  /// Returns all available users/contacts.
  Future<List<User>> getUsers();
}
