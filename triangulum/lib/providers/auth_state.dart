import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';

class AuthState extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  bool _isInitialized = false;

  AuthState() {
    _init();
  }

  User? get user => _user;
  bool get isInitialized => _isInitialized;
  bool get isAuthenticated => _user != null;

  Future<void> _init() async {
    // Listen to auth state changes
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _user = user;
      _isInitialized = true;
      notifyListeners();
    });
  }

  Future<void> signOut() async {
    final error = await _authService.signOut();
    if (error != null) {
      // You might want to handle this error in the UI
      debugPrint('Error signing out: $error');
    }
    // Firebase authStateChanges will handle updating the user state
  }
} 