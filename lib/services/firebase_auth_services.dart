import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Performs Firebase Authentication operations only. Errors are rethrown so
// the calling screen can show the right message and decide on navigation.
class FirebaseAuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static Future<void>? _googleInit;

  // get user info
  static User? get currentUser => _auth.currentUser;

  // login
  static Future<UserModel?> login(UserModel user) async {
    // Auth errors (wrong password, network, ...) go straight to the screen
    UserCredential credential = await _auth.signInWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );

    try {
      UserModel? userData = await getUserInfo(credential.user!.uid);

      // Profile doc is missing (e.g. its save failed at sign up): create it
      // now from the Auth profile so the account is complete
      if (userData == null) {
        userData = UserModel(
          id: credential.user!.uid,
          name: credential.user!.displayName,
          email: credential.user!.email ?? user.email,
          password: '',
        );
        await createUser(userData);
      }

      log('login success');
      return userData;
    } on FirebaseException catch (e) {
      // Firestore failed: sign out so the user is not left half logged in
      log('login: loading profile failed (${e.code})');
      await _auth.signOut();
      rethrow;
    }
  }

  //create user on database

  static CollectionReference<UserModel> getUsersCollection() =>
      FirebaseFirestore.instance
          .collection('users')
          .withConverter<UserModel>(
            fromFirestore: (snapshot, options) =>
                UserModel.fromJson(snapshot.data() ?? {}),
            toFirestore: (value, options) => value.toJson(),
          );

  static Future createUser(UserModel user) async {
    CollectionReference<UserModel> collection = getUsersCollection();

    DocumentReference doc = collection.doc(user.id); // auto generated id :uui
    await doc.set(user);
  }

  static Future<UserModel?> getUserInfo(String id) async {
    CollectionReference<UserModel> collection = getUsersCollection();
    DocumentReference<UserModel> doc = collection.doc(id);
    DocumentSnapshot<UserModel> snapshot = await doc.get();
    return snapshot.data();
  }

  // register
  static Future<void> register(UserModel user) async {
    // Auth errors (email in use, weak password, ...) go straight to the screen
    UserCredential credential = await _auth.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
    user.id = credential.user?.uid;
    await credential.user?.updateDisplayName(user.name);

    try {
      await createUser(user);
    } on FirebaseException catch (e) {
      // The Auth account exists but its profile was not saved. We do NOT
      // delete the account; we sign out, and the next login re-creates the
      // profile (see login above)
      log('register: saving profile failed (${e.code})');
      await _auth.signOut();
      rethrow;
    }

    await _auth.currentUser?.reload();
    log('register success');
  }

  // logout
  static Future<void> logout() => _auth.signOut();

  // forget password
  static Future<void> resetPassword(String email) {
    return _auth.sendPasswordResetEmail(email: email);
  }

  // google login
  static Future<UserCredential> signInWithGoogle() async {
    if (kIsWeb) {
      // Google Sign-In on Web
      return _auth.signInWithPopup(GoogleAuthProvider());
    }

    // Google Sign-In on Android / iOS
    await _ensureGoogleInitialized();

    final googleUser = await GoogleSignIn.instance.authenticate();
    final googleAuth = googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return _auth.signInWithCredential(credential);
  }

  // google_sign_in 7.x must be initialized exactly once per app run
  static Future<void> _ensureGoogleInitialized() {
    return _googleInit ??= GoogleSignIn.instance.initialize().catchError((
      Object error,
    ) {
      // Allow a retry on the next tap if initialization failed
      _googleInit = null;
      throw error;
    });
  }

  // delete account
}
