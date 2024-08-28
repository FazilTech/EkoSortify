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

  // googleSignIn 
  signWithGoogle() async{
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // user cancels google sign in pop up screen
    if(gUser == null) return;

    // obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    // create a new creditional for user
    final Credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // finally, sign in
    return await _auth.signInWithCredential(Credential);
  }

  //sign out
  Future<void> signOut() async{
    return await _auth.signOut();
  }
  }