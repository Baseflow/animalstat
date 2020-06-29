import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../animalstat_repository.dart';

class FirestoreUserRepository implements UserRepository{
  final FirebaseAuth _firebaseAuth;
  final CollectionReference _userCollection = Firestore.instance.collection('users');

  FirestoreUserRepository({
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
    var snapshot = await _userCollection
      .document(firebaseUser.uid)
      .get();

    return User.fromJson(snapshot.data);
  }
}
