import 'package:animal_stat/models/user.dart';

abstract class UserRepository {
  Future<void> signInWithCredentials(String email, String password);

  Future<void> signOut();

  Future<bool> isSignedIn();

  Future<User> getUser();
}
