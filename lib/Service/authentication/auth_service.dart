import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{

  // instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in
  Future<UserCredential> signInWithEmailAndPassword(String email, password) async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }

  //sign up
  Future<UserCredential> signUpWithEmailAndPassword(String email, password) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }

   Future<void> signWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      // If the user cancels the sign-in process
      if (gUser == null) return;

      // Obtain the auth details from the request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Sign in with the credential
      UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Create a user document in Firestore
      await createUserDocument(userCredential);
      
    } catch (e) {
      throw Exception("Google Sign-In failed: $e");
    }
  }

  // Function to create a user document in Firestore
  Future<void> createUserDocument(UserCredential userCredential) async {
    await FirebaseFirestore.instance.collection("Users").doc(userCredential.user!.email).set({
      'email': userCredential.user!.email,
      'username': userCredential.user!.displayName ?? 'Anonymous', // Using displayName if available
    });
  }

  //sign out
  Future<void> signOut() async{
    return await _auth.signOut();
  }
  }