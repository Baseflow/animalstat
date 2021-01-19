import '../animalstat_repository.dart';

abstract class UserRepository {
  Future<void> signInWithCredentials(String email, String password);

  Future<void> signOut();

  bool isSignedIn();

  Future<User> getUser();
}
