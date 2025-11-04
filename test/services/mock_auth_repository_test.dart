import 'package:flutter_test/flutter_test.dart';
import 'package:astrology_app/core/services/mock_auth_repository.dart';
import 'package:astrology_app/core/config/test_constants.dart';
import '../helpers/test_setup.dart';

void main() {
  late MockAuthRepository repository;

  setUp(() {
    setupTestEnvironment();
    repository = MockAuthRepository();
  });

  tearDown(() {
    teardownTestEnvironment();
  });

  group('MockAuthRepository', () {
    test('should sign in with email and password', () async {
      final credential = await repository.signInWithEmail(
        email: TestConstants.testUserEmail,
        password: TestConstants.testUserPassword,
      );

      expect(credential.user, isNotNull);
      expect(credential.user?.email, TestConstants.testUserEmail);
    });

    test('should throw error for invalid credentials', () async {
      expect(
        () => repository.signInWithEmail(
          email: TestConstants.testUserEmail,
          password: 'wrong_password',
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('should sign up new user', () async {
      final credential = await repository.signUpWithEmail(
        email: 'newuser@example.com',
        password: 'password123',
        displayName: 'New User',
      );

      expect(credential.user, isNotNull);
      expect(credential.user?.email, 'newuser@example.com');
      expect(credential.user?.displayName, 'New User');
    });

    test('should sign in with Google', () async {
      final credential = await repository.signInWithGoogle();

      expect(credential.user, isNotNull);
      expect(credential.user?.email, TestConstants.testUserEmail);
    });

    test('should verify phone code', () async {
      await repository.signInWithPhone(
        phoneNumber: TestConstants.testUserPhone,
        verificationIdCallback: (_) {},
        codeSentCallback: (_) {},
      );

      final credential = await repository.verifyPhoneCode(
        verificationId: 'mock_verification_id',
        smsCode: '123456',
      );

      expect(credential.user, isNotNull);
    });

    test('should throw error for invalid phone code', () async {
      await repository.signInWithPhone(
        phoneNumber: TestConstants.testUserPhone,
        verificationIdCallback: (_) {},
        codeSentCallback: (_) {},
      );

      expect(
        () => repository.verifyPhoneCode(
          verificationId: 'mock_verification_id',
          smsCode: '000000',
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('should sign out user', () async {
      await repository.signInWithEmail(
        email: TestConstants.testUserEmail,
        password: TestConstants.testUserPassword,
      );

      await repository.signOut();

      final authState = await repository.authStateChanges().first;
      expect(authState, isNull);
    });

    test('should get user data', () async {
      final user = await repository.getUserData(TestConstants.testUserId);

      expect(user, isNotNull);
      expect(user?.id, TestConstants.testUserId);
      expect(user?.email, TestConstants.testUserEmail);
    });

    test('should update user profile', () async {
      await repository.updateUserProfile(
        userId: TestConstants.testUserId,
        updates: {
          'displayName': 'Updated Name',
        },
      );

      final user = await repository.getUserData(TestConstants.testUserId);
      expect(user?.displayName, 'Updated Name');
    });
  });
}

