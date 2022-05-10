import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.userChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "SignedIn";
    } on FirebaseAuthException catch (e) {
      // if (e.code == 'user-not-found') {
      //   return 'No user found for that email.';
      // } else if (e.code == 'wrong-password') {
      //   return "Wrong password provided for that user.";
      // }
      return e.message;
    }
  }

  Future<String?> signUp(String email, String password, String name) async {
    try {
      UserCredential usercred = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await usercred.user?.updateDisplayName("sdfsdf");

      return "SignedUp";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      print(e.message);
      return e.message;
    }
  }

  Future<void> updateName(String name) async {
    try {
      await _firebaseAuth.currentUser?.updateDisplayName(name);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }
}
