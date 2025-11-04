import 'package:firebase_auth/firebase_auth.dart';
import '../../features/auth/data/auth_repository.dart';
import '../../models/user_model.dart';
import '../config/test_constants.dart';
import '../config/app_constants.dart' as constants;
import 'dart:async';

/// Mock implementation of AuthRepository for testing
class MockAuthRepository extends AuthRepository {
  final Map<String, UserModel> _mockUsers = {};
  UserModel? _currentUser;

  MockAuthRepository() {
    // Initialize with test user
    _mockUsers[TestConstants.testUserId] = UserModel(
      id: TestConstants.testUserId,
      email: TestConstants.testUserEmail,
      displayName: TestConstants.testUserName,
      phoneNumber: TestConstants.testUserPhone,
      role: constants.AppConstants.roleEndUser,
      createdAt: DateTime.now(),
      referralCode: 'TEST123',
    );

    _mockUsers[TestConstants.testAstrologerId] = UserModel(
      id: TestConstants.testAstrologerId,
      email: TestConstants.testAstrologerEmail,
      displayName: TestConstants.testAstrologerName,
      role: constants.AppConstants.roleAstrologer,
      createdAt: DateTime.now(),
      referralCode: 'ASTRO123',
    );
  }

  @override
  Stream<UserModel?> authStateChanges() {
    return Stream.value(_currentUser);
  }

  @override
  Future<UserModel?> getUserData(String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _mockUsers[userId];
  }

  @override
  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (email == TestConstants.testUserEmail &&
        password == TestConstants.testUserPassword) {
      _currentUser = _mockUsers[TestConstants.testUserId];
      // Return a mock UserCredential
      return _MockUserCredential(_currentUser!);
    }

    throw FirebaseAuthException(
      code: 'wrong-password',
      message: 'Invalid email or password',
    );
  }

  @override
  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
    String? phoneNumber,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final newUserId = 'user_${DateTime.now().millisecondsSinceEpoch}';
    final newUser = UserModel(
      id: newUserId,
      email: email,
      displayName: displayName,
      phoneNumber: phoneNumber,
      role: constants.AppConstants.roleEndUser,
      createdAt: DateTime.now(),
      referralCode: 'REF${newUserId.substring(0, 6).toUpperCase()}',
    );

    _mockUsers[newUserId] = newUser;
    _currentUser = newUser;

    return _MockUserCredential(newUser);
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = _mockUsers[TestConstants.testUserId];
    return _MockUserCredential(_currentUser!);
  }

  @override
  Future<void> signInWithPhone({
    required String phoneNumber,
    required Function(String) verificationIdCallback,
    required Function(String) codeSentCallback,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final verificationId = 'mock_verification_${DateTime.now().millisecondsSinceEpoch}';
    verificationIdCallback(verificationId);
    codeSentCallback(verificationId);
  }

  @override
  Future<UserCredential> verifyPhoneCode({
    required String verificationId,
    required String smsCode,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (smsCode == '123456') {
      _currentUser = _mockUsers[TestConstants.testUserId];
      return _MockUserCredential(_currentUser!);
    }
    throw FirebaseAuthException(
      code: 'invalid-verification-code',
      message: 'Invalid verification code',
    );
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _currentUser = null;
  }

  @override
  Future<void> updateUserProfile({
    required String userId,
    Map<String, dynamic> updates,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final user = _mockUsers[userId];
    if (user != null) {
      // Update user data
      _mockUsers[userId] = user.copyWith(
        displayName: updates['displayName'] ?? user.displayName,
        phoneNumber: updates['phoneNumber'] ?? user.phoneNumber,
        photoUrl: updates['photoUrl'] ?? user.photoUrl,
      );
    }
  }

  // Helper method to get all mock users (for testing)
  Map<String, UserModel> get mockUsers => Map.unmodifiable(_mockUsers);
}

class _MockUserCredential implements UserCredential {
  final UserModel _userModel;

  _MockUserCredential(this._userModel);

  @override
  User? get user => _MockUser(_userModel);

  @override
  AdditionalUserInfo? get additionalUserInfo => null;

  @override
  OAuthCredential? get credential => null;
}

class _MockUser implements User {
  final UserModel _userModel;

  _MockUser(this._userModel);

  @override
  String get uid => _userModel.id;

  @override
  String? get email => _userModel.email;

  @override
  String? get displayName => _userModel.displayName;

  @override
  String? get photoURL => _userModel.photoUrl;

  @override
  String? get phoneNumber => _userModel.phoneNumber;

  // Implement other required properties and methods
  @override
  bool get emailVerified => false;

  @override
  bool get isAnonymous => false;

  @override
  UserMetadata get metadata => throw UnimplementedError();

  @override
  MultiFactor get multiFactor => throw UnimplementedError();

  @override
  String? get refreshToken => null;

  @override
  String get tenantId => '';

  @override
  Future<void> delete() => throw UnimplementedError();

  @override
  Future<String> getIdToken([bool forceRefresh = false]) => Future.value('mock_token');

  @override
  Future<IdTokenResult> getIdTokenResult([bool forceRefresh = false]) =>
      throw UnimplementedError();

  @override
  Future<UserCredential> linkWithCredential(AuthCredential credential) =>
      throw UnimplementedError();

  @override
  Future<ConfirmationResult> linkWithPhoneNumber(
    String phoneNumber, [
    RecaptchaVerifier? verifier,
  ]) =>
      throw UnimplementedError();

  @override
  Future<UserCredential> linkWithPopup(AuthProvider provider) =>
      throw UnimplementedError();

  @override
  Future<void> linkWithRedirect(AuthProvider provider) =>
      throw UnimplementedError();

  @override
  Future<UserCredential> reauthenticateWithCredential(
    AuthCredential credential,
  ) =>
      throw UnimplementedError();

  @override
  Future<UserCredential> reauthenticateWithPopup(AuthProvider provider) =>
      throw UnimplementedError();

  @override
  Future<void> reauthenticateWithRedirect(AuthProvider provider) =>
      throw UnimplementedError();

  @override
  Future<void> reload() => Future.value();

  @override
  Future<void> sendEmailVerification([ActionCodeSettings? actionCodeSettings]) =>
      Future.value();

  @override
  Future<User> unlink(String providerId) => throw UnimplementedError();

  @override
  Future<void> updateDisplayName(String? displayName) => Future.value();

  @override
  Future<void> updateEmail(String newEmail) => Future.value();

  @override
  Future<void> updatePassword(String newPassword) => Future.value();

  @override
  Future<void> updatePhoneNumber(PhoneAuthCredential phoneCredential) =>
      Future.value();

  @override
  Future<void> updatePhotoURL(String? photoURL) => Future.value();

  @override
  Future<void> updateProfile({String? displayName, String? photoURL}) =>
      Future.value();

  @override
  Future<void> verifyBeforeUpdateEmail(
    String newEmail, [
    ActionCodeSettings? actionCodeSettings,
  ]) =>
      Future.value();
}

