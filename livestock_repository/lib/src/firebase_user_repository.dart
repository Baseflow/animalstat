import 'package:livestock_repository/livestock_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserRepository implements UserRepository{
  final FirebaseAuth _firebaseAuth;

  FirebaseUserRepository({
    FirebaseAuth firebaseAuth,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<User> getUser() async {
    var firebaseUser = await _firebaseAuth.currentUser();
    return _fromFirebaseUser(firebaseUser);
  }

  User _fromFirebaseUser(FirebaseUser user) {
    return User(
      user.displayName,
      user.email,
    );
  }
}
