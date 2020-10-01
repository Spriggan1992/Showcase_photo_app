import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:flutter/material.dart';
import 'package:photo/entities/user_entity.dart';
import 'package:photo/model/user_model.dart';

import '../repositories.dart';
// import 'package:meta/meta.dart';

class AuthRepository extends BaseAuthRepository {
  final FirebaseFirestore _firestore;
  final auth.FirebaseAuth _firebaseAuth;
  // final FirebaseMessaging _messaging;

  AuthRepository({
    FirebaseFirestore firestore,
    auth.FirebaseAuth firebaseAuth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;
  // _messaging = messaging ?? FirebaseMessaging();

  @override
  void dispose() {}

  Future<User> _firebaseUserToUser(auth.User authUser) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(authUser.uid).get();
    if (userDoc.exists) {
      User user = User.fromEntity(UserEntity.fromSnapshot(userDoc));
      return user;
    }
    return User(id: authUser.uid, email: '');
  }

  Future<void> _updateProfile(String nickname) {
    var user = _firebaseAuth.currentUser;
    if (nickname.isNotEmpty) {
      user.updateProfile(displayName: nickname);
    }
    user.updateProfile(displayName: '');
  }

  @override
  Future<User> signUpWithEmailAndPassword({
    @required String email,
    @required String password,
    @required String nickname,
  }) async {
    auth.UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    final user = await _firebaseUserToUser(userCredential.user);
    _firestore
        .collection('users')
        .doc(user.id)
        .set(user.toEntity().toDocument());
    await _updateProfile(nickname);
    return user;
  }

  @override
  Future<User> loginWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    final auth.UserCredential authResult = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    return await _firebaseUserToUser(authResult.user);
  }

  @override
  Future<void> logout() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }

  @override
  Future<User> getCurrentUser() async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) return null;
    return await _firebaseUserToUser(currentUser);
  }
}
