import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  bool _isAuthenticated = false;
  bool _isEmailVerified = false;
  bool _isDeveloperMode = false;
  String? _currentUserId;
  String? _currentUserEmail;
  Map<String, dynamic>? _currentUser;

  // Getters
  bool get isAuthenticated => _isAuthenticated;
  bool get isEmailVerified => _isEmailVerified;
  bool get isDeveloperMode => _isDeveloperMode;
  String? get currentUserId => _currentUserId;
  String? get currentUserEmail => _currentUserEmail;
  Map<String, dynamic>? get currentUser => _currentUser;

  // Mock user database
  final Map<String, Map<String, dynamic>> _users = {
    'test@example.com': {
      'id': '1',
      'email': 'test@example.com',
      'password': 'password123',
      'firstName': 'Test',
      'lastName': 'User',
      'phone': '+250788123456',
      'isEmailVerified': true,
      'createdAt': DateTime.now().toIso8601String(),
      'twoFactorEnabled': true,
    },
    'john@example.com': {
      'id': '2',
      'email': 'john@example.com',
      'password': 'john123',
      'firstName': 'John',
      'lastName': 'Doe',
      'phone': '+250788654321',
      'isEmailVerified': true,
      'createdAt': DateTime.now().toIso8601String(),
      'twoFactorEnabled': false,
    },
    'admin@vidarpay.com': {
      'id': '3',
      'email': 'admin@vidarpay.com',
      'password': 'admin123',
      'firstName': 'Admin',
      'lastName': 'User',
      'phone': '+250788999999',
      'isEmailVerified': true,
      'createdAt': DateTime.now().toIso8601String(),
      'twoFactorEnabled': true,
      'role': 'admin',
    },
  };

  // Authentication attempts tracking
  final Map<String, List<DateTime>> _authAttempts = {};
  final int _maxAttempts = 5;
  final Duration _lockoutDuration = const Duration(minutes: 15);

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
    _isEmailVerified = prefs.getBool('isEmailVerified') ?? false;
    _isDeveloperMode = prefs.getBool('isDeveloperMode') ?? false;
    _currentUserId = prefs.getString('currentUserId');
    _currentUserEmail = prefs.getString('currentUserEmail');
    
    final userJson = prefs.getString('currentUser');
    if (userJson != null) {
      _currentUser = jsonDecode(userJson);
    }

    _logAuthEvent('App initialized', {
      'isAuthenticated': _isAuthenticated,
      'isEmailVerified': _isEmailVerified,
      'isDeveloperMode': _isDeveloperMode,
    });

    notifyListeners();
  }

  // Developer Mode
  Future<void> toggleDeveloperMode() async {
    _isDeveloperMode = !_isDeveloperMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDeveloperMode', _isDeveloperMode);
    
    _logAuthEvent('Developer mode toggled', {'enabled': _isDeveloperMode});
    notifyListeners();
  }

  Future<void> enableDeveloperMode() async {
    _isDeveloperMode = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDeveloperMode', _isDeveloperMode);
    
    _logAuthEvent('Developer mode enabled', {});
    notifyListeners();
  }

  // Rate limiting
  bool _isRateLimited(String email) {
    final attempts = _authAttempts[email] ?? [];
    final now = DateTime.now();
    
    // Remove old attempts
    attempts.removeWhere((attempt) => 
        now.difference(attempt) > _lockoutDuration);
    
    return attempts.length >= _maxAttempts;
  }

  void _recordAuthAttempt(String email) {
    _authAttempts[email] ??= [];
    _authAttempts[email]!.add(DateTime.now());
  }

  // Sign Up
  Future<AuthResult> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    try {
      _logAuthEvent('Sign up attempt', {'email': email});

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Check if user already exists
      if (_users.containsKey(email)) {
        _logAuthEvent('Sign up failed - user exists', {'email': email});
        return AuthResult.error('An account with this email already exists');
      }

      // Validate input
      if (!_isValidEmail(email)) {
        return AuthResult.error('Please enter a valid email address');
      }

      if (password.length < 6) {
        return AuthResult.error('Password must be at least 6 characters');
      }

      // Create new user
      final userId = DateTime.now().millisecondsSinceEpoch.toString();
      _users[email] = {
        'id': userId,
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'isEmailVerified': false,
        'createdAt': DateTime.now().toIso8601String(),
        'twoFactorEnabled': false,
      };

      _logAuthEvent('Sign up successful', {'email': email, 'userId': userId});
      return AuthResult.success('Account created successfully. Please verify your email.');

    } catch (e) {
      _logAuthEvent('Sign up error', {'email': email, 'error': e.toString()});
      return AuthResult.error('An error occurred during sign up. Please try again.');
    }
  }

  // Sign In
  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    try {
      _logAuthEvent('Sign in attempt', {'email': email});

      // Check rate limiting
      if (_isRateLimited(email)) {
        _logAuthEvent('Sign in blocked - rate limited', {'email': email});
        return AuthResult.error('Too many failed attempts. Please try again later.');
      }

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Check if user exists
      final user = _users[email];
      if (user == null) {
        _recordAuthAttempt(email);
        _logAuthEvent('Sign in failed - user not found', {'email': email});
        return AuthResult.error('Invalid email or password');
      }

      // Check password
      if (user['password'] != password) {
        _recordAuthAttempt(email);
        _logAuthEvent('Sign in failed - wrong password', {'email': email});
        return AuthResult.error('Invalid email or password');
      }

      // Check if email is verified (skip in developer mode)
      if (!_isDeveloperMode && !user['isEmailVerified']) {
        _logAuthEvent('Sign in blocked - email not verified', {'email': email});
        return AuthResult.emailNotVerified('Please verify your email before signing in.');
      }

      // Successful login
      _currentUser = user;
      _currentUserId = user['id'];
      _currentUserEmail = user['email'];
      _isEmailVerified = user['isEmailVerified'];

      // Save to preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('currentUserId', _currentUserId!);
      await prefs.setString('currentUserEmail', _currentUserEmail!);
      await prefs.setString('currentUser', jsonEncode(_currentUser));
      await prefs.setBool('isEmailVerified', _isEmailVerified);

      _logAuthEvent('Sign in successful', {'email': email, 'userId': _currentUserId});

      // Check if 2FA is enabled
      if (!_isDeveloperMode && user['twoFactorEnabled'] == true) {
        return AuthResult.requiresTwoFactor('Two-factor authentication required');
      }

      // Complete authentication
      await _completeAuthentication();
      return AuthResult.success('Sign in successful');

    } catch (e) {
      _logAuthEvent('Sign in error', {'email': email, 'error': e.toString()});
      return AuthResult.error('An error occurred during sign in. Please try again.');
    }
  }

  // Two-Factor Authentication
  Future<AuthResult> verifyTwoFactor(String code) async {
    try {
      _logAuthEvent('2FA verification attempt', {'userId': _currentUserId});

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // In developer mode, accept any 6-digit code
      if (_isDeveloperMode && code.length == 6) {
        await _completeAuthentication();
        _logAuthEvent('2FA verification successful (dev mode)', {'userId': _currentUserId});
        return AuthResult.success('Two-factor authentication successful');
      }

      // Mock verification (accept 123456 as valid code)
      if (code == '123456') {
        await _completeAuthentication();
        _logAuthEvent('2FA verification successful', {'userId': _currentUserId});
        return AuthResult.success('Two-factor authentication successful');
      }

      _logAuthEvent('2FA verification failed', {'userId': _currentUserId, 'code': code});
      return AuthResult.error('Invalid verification code');

    } catch (e) {
      _logAuthEvent('2FA verification error', {'userId': _currentUserId, 'error': e.toString()});
      return AuthResult.error('An error occurred during verification. Please try again.');
    }
  }

  // Email Verification
  Future<AuthResult> sendEmailVerification(String email) async {
    try {
      _logAuthEvent('Email verification sent', {'email': email});

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Check if user exists
      if (!_users.containsKey(email)) {
        return AuthResult.error('User not found');
      }

      // In real app, send actual email here
      _logAuthEvent('Email verification sent successfully', {'email': email});
      return AuthResult.success('Verification email sent successfully');

    } catch (e) {
      _logAuthEvent('Email verification error', {'email': email, 'error': e.toString()});
      return AuthResult.error('Failed to send verification email');
    }
  }

  Future<AuthResult> verifyEmail(String email, String code) async {
    try {
      _logAuthEvent('Email verification attempt', {'email': email});

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Check if user exists
      final user = _users[email];
      if (user == null) {
        return AuthResult.error('User not found');
      }

      // In developer mode or mock verification (accept 123456)
      if (_isDeveloperMode || code == '123456') {
        _users[email]!['isEmailVerified'] = true;
        
        if (_currentUserEmail == email) {
          _isEmailVerified = true;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isEmailVerified', true);
        }

        _logAuthEvent('Email verification successful', {'email': email});
        return AuthResult.success('Email verified successfully');
      }

      _logAuthEvent('Email verification failed', {'email': email, 'code': code});
      return AuthResult.error('Invalid verification code');

    } catch (e) {
      _logAuthEvent('Email verification error', {'email': email, 'error': e.toString()});
      return AuthResult.error('An error occurred during verification');
    }
  }

  // Password Reset
  Future<AuthResult> sendPasswordReset(String email) async {
    try {
      _logAuthEvent('Password reset requested', {'email': email});

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Check if user exists
      if (!_users.containsKey(email)) {
        // Don't reveal if user exists for security
        _logAuthEvent('Password reset sent (user not found)', {'email': email});
        return AuthResult.success('If an account exists, a reset link has been sent');
      }

      // In real app, send actual email here
      _logAuthEvent('Password reset sent successfully', {'email': email});
      return AuthResult.success('Password reset link sent to your email');

    } catch (e) {
      _logAuthEvent('Password reset error', {'email': email, 'error': e.toString()});
      return AuthResult.error('Failed to send password reset email');
    }
  }

  Future<AuthResult> resetPassword(String email, String code, String newPassword) async {
    try {
      _logAuthEvent('Password reset attempt', {'email': email});

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Check if user exists
      if (!_users.containsKey(email)) {
        return AuthResult.error('Invalid reset code');
      }

      // Validate new password
      if (newPassword.length < 6) {
        return AuthResult.error('Password must be at least 6 characters');
      }

      // In developer mode or mock verification (accept 123456)
      if (_isDeveloperMode || code == '123456') {
        _users[email]!['password'] = newPassword;
        _logAuthEvent('Password reset successful', {'email': email});
        return AuthResult.success('Password reset successfully');
      }

      _logAuthEvent('Password reset failed', {'email': email, 'code': code});
      return AuthResult.error('Invalid reset code');

    } catch (e) {
      _logAuthEvent('Password reset error', {'email': email, 'error': e.toString()});
      return AuthResult.error('An error occurred during password reset');
    }
  }

  // Complete Authentication
  Future<void> _completeAuthentication() async {
    _isAuthenticated = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', true);
    notifyListeners();
  }

  // Sign Out
  Future<void> signOut() async {
    _logAuthEvent('Sign out', {'userId': _currentUserId});

    _isAuthenticated = false;
    _isEmailVerified = false;
    _currentUserId = null;
    _currentUserEmail = null;
    _currentUser = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isAuthenticated');
    await prefs.remove('isEmailVerified');
    await prefs.remove('currentUserId');
    await prefs.remove('currentUserEmail');
    await prefs.remove('currentUser');

    notifyListeners();
  }

  // Utility methods
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _logAuthEvent(String event, Map<String, dynamic> data) {
    if (kDebugMode) {
      print('AUTH EVENT: $event - ${jsonEncode(data)}');
    }
  }

  // Developer testing methods
  List<Map<String, dynamic>> getTestAccounts() {
    return _users.values.map((user) => {
      'email': user['email'],
      'password': user['password'],
      'firstName': user['firstName'],
      'lastName': user['lastName'],
      'isEmailVerified': user['isEmailVerified'],
      'twoFactorEnabled': user['twoFactorEnabled'],
    }).toList();
  }

  Future<void> createTestUser(String email, String password) async {
    final userId = DateTime.now().millisecondsSinceEpoch.toString();
    _users[email] = {
      'id': userId,
      'email': email,
      'password': password,
      'firstName': 'Test',
      'lastName': 'User',
      'phone': '+250788000000',
      'isEmailVerified': true,
      'createdAt': DateTime.now().toIso8601String(),
      'twoFactorEnabled': false,
    };
    _logAuthEvent('Test user created', {'email': email});
  }

  void clearAuthAttempts() {
    _authAttempts.clear();
    _logAuthEvent('Auth attempts cleared', {});
  }
}

class AuthResult {
  final bool success;
  final String message;
  final AuthResultType type;

  AuthResult._(this.success, this.message, this.type);

  factory AuthResult.success(String message) => 
      AuthResult._(true, message, AuthResultType.success);
  
  factory AuthResult.error(String message) => 
      AuthResult._(false, message, AuthResultType.error);
  
  factory AuthResult.requiresTwoFactor(String message) => 
      AuthResult._(false, message, AuthResultType.requiresTwoFactor);
  
  factory AuthResult.emailNotVerified(String message) => 
      AuthResult._(false, message, AuthResultType.emailNotVerified);
}

enum AuthResultType {
  success,
  error,
  requiresTwoFactor,
  emailNotVerified,
}