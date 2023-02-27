import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/widgets.dart';
import 'package:hero/models/models.dart';
import 'package:hero/repository/database.dart';
import 'package:hero/repository/firestore_repository.dart';

class AuthRepository {
  final auth.FirebaseAuth _firebaseAuth;

  AuthRepository({auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  @override
  Future<User?> signUp(
      {required String email, required String password}) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      final user = _userFromFirebaseUser(credential.user);

      await FirestoreRepository(id: user!.id).updateUserData(
        user.id,
        'fish',
        0,
        'test bio',
        [
          'https://png.pngtree.com/png-clipart/20190630/original/pngtree-yellow-cartoon-fish-clipart-png-image_4151882.jpg'
        ],
        [],
        'job test',
        false,
        null,
        '',
        0,
        0,
        0,
        false,
        [],
        false,
      );

      return user;
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }

  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = _userFromFirebaseUser(credential.user);
      return user;
    } catch (e) {
      print(e);
    }
  }

  auth.User? get otherUser => _firebaseAuth.currentUser;

  Stream<User?> get user {
    return _firebaseAuth
        .authStateChanges()
        //.map((User? user) => userFromFirebaseUser(user?));
        .map(_userFromFirebaseUser);
  }

  Stream<auth.User?> get authUser {
    return _firebaseAuth.authStateChanges();
  }

  User? _userFromFirebaseUser(auth.User? user) {
    return user != null
        ? User(
            id: user.uid,
            name: '',
            age: 0,
            imageUrls: [],
            jobTitle: '',
            bio: '',
            interests: [],
            email: user.email,
            isRude: false,
            instigations: 0,
            votes: 0,
            votesUsable: 0,
            stingrays: [],
            finishedOnboarding: false,
          )
        : null;
  }
}
