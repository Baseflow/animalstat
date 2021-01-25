import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;

import '../animalstat_repository.dart';

class FirestoreUserRepository implements UserRepository {
  final fire_auth.FirebaseAuth _firebaseAuth;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  FirestoreUserRepository({
    fire_auth.FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? fire_auth.FirebaseAuth.instance;

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

  bool isSignedIn() {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<User> getUser() async {
    var firebaseUser = _firebaseAuth.currentUser;
    var snapshot = await _userCollection.doc(firebaseUser.uid).get();

    return User.fromJson(snapshot.data());
  }
}
