import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../utils/auth_error_handler.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Stream to listen to auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with Google
  Future<(UserCredential?, String?)> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return (null, 'Sign in cancelled by user.');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with the credential
      final userCredential = await _auth.signInWithCredential(credential);
      return (userCredential, null);
    } on FirebaseAuthException catch (e) {
      return (null, AuthErrorHandler.getErrorMessage(e.code));
    } catch (e) {
      return (null, 'An unexpected error occurred.');
    }
  }

  // Sign in with email/password
  Future<(UserCredential?, String?)> signInWithEmail(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return (userCredential, null);
    } on FirebaseAuthException catch (e) {
      return (null, AuthErrorHandler.getErrorMessage(e.code));
    } catch (e) {
      return (null, 'An unexpected error occurred.');
    }
  }

  // Sign up with email/password
  Future<(UserCredential?, String?)> signUpWithEmail(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return (userCredential, null);
    } on FirebaseAuthException catch (e) {
      return (null, AuthErrorHandler.getErrorMessage(e.code));
    } catch (e) {
      return (null, 'An unexpected error occurred.');
    }
  }

  // Sign in with Apple
  Future<(UserCredential?, String?)> signInWithApple() async {
    try {
      final appleProvider = AppleAuthProvider();
      final userCredential = await _auth.signInWithProvider(appleProvider);
      return (userCredential, null);
    } on FirebaseAuthException catch (e) {
      return (null, AuthErrorHandler.getErrorMessage(e.code));
    } catch (e) {
      return (null, 'An unexpected error occurred.');
    }
  }

  // Sign out
  Future<String?> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(), // Sign out from Google
      ]);
      return null;
    } catch (e) {
      return 'Error signing out. Please try again.';
    }
  }
} 