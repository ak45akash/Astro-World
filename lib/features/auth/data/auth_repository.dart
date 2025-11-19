import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../models/user_model.dart';
import '../../../core/constants/app_constants.dart';
import 'package:uuid/uuid.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _uuid = const Uuid();

  Stream<UserModel?> authStateChanges() {
    try {
      return _auth.authStateChanges().asyncMap((firebaseUser) async {
        if (firebaseUser == null) return null;
        try {
          return await getUserData(firebaseUser.uid);
        } catch (e) {
          return null;
        }
      });
    } catch (e) {
      // Return empty stream if Firebase fails
      return Stream.value(null);
    }
  }

  Future<UserModel?> getUserData(String userId) async {
    try {
      final doc = await _firestore
          .collection(AppConstants.collectionUsers)
          .doc(userId)
          .get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
    String? phoneNumber,
  }) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await userCredential.user?.updateDisplayName(displayName);

    final userModel = UserModel(
      id: userCredential.user!.uid,
      email: email,
      phoneNumber: phoneNumber,
      displayName: displayName,
      photoUrl: userCredential.user!.photoURL,
      role: AppConstants.roleEndUser,
      createdAt: DateTime.now(),
      referralCode: _generateReferralCode(),
    );

    await _firestore
        .collection(AppConstants.collectionUsers)
        .doc(userCredential.user!.uid)
        .set(userModel.toMap());

    return userCredential;
  }

  Future<UserCredential> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception('Google sign in cancelled');
    }

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);

    // Check if user exists
    final userDoc = await _firestore
        .collection(AppConstants.collectionUsers)
        .doc(userCredential.user!.uid)
        .get();

    if (!userDoc.exists) {
      // Create new user
      final userModel = UserModel(
        id: userCredential.user!.uid,
        email: userCredential.user!.email ?? '',
        displayName: userCredential.user!.displayName,
        photoUrl: userCredential.user!.photoURL,
        role: AppConstants.roleEndUser,
        createdAt: DateTime.now(),
        referralCode: _generateReferralCode(),
      );

      await _firestore
          .collection(AppConstants.collectionUsers)
          .doc(userCredential.user!.uid)
          .set(userModel.toMap());
    } else {
      // Update last login
      await _firestore
          .collection(AppConstants.collectionUsers)
          .doc(userCredential.user!.uid)
          .update({'lastLoginAt': FieldValue.serverTimestamp()});
    }

    return userCredential;
  }

  Future<void> signInWithPhone({
    required String phoneNumber,
    required Function(String) verificationIdCallback,
    required Function(String) codeSentCallback,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        verificationIdCallback(credential.verificationId ?? '');
      },
      verificationFailed: (FirebaseAuthException e) {
        throw e;
      },
      codeSent: (String verificationId, int? resendToken) {
        codeSentCallback(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationIdCallback(verificationId);
      },
    );
  }

  Future<UserCredential> verifyPhoneCode({
    required String verificationId,
    required String smsCode,
  }) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    final userCredential = await _auth.signInWithCredential(credential);

    // Check if user exists
    final userDoc = await _firestore
        .collection(AppConstants.collectionUsers)
        .doc(userCredential.user!.uid)
        .get();

    if (!userDoc.exists) {
      // Create new user
      final userModel = UserModel(
        id: userCredential.user!.uid,
        email: '',
        phoneNumber: userCredential.user!.phoneNumber,
        displayName: userCredential.user!.displayName,
        photoUrl: userCredential.user!.photoURL,
        role: AppConstants.roleEndUser,
        createdAt: DateTime.now(),
        referralCode: _generateReferralCode(),
      );

      await _firestore
          .collection(AppConstants.collectionUsers)
          .doc(userCredential.user!.uid)
          .set(userModel.toMap());
    }

    return userCredential;
  }

  Future<void> signOut() async {
    await Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<void> updateUserProfile({
    required String userId,
    required Map<String, dynamic> updates,
  }) async {
    await _firestore
        .collection(AppConstants.collectionUsers)
        .doc(userId)
        .update(updates);
  }

  String _generateReferralCode() {
    return _uuid.v4().substring(0, 8).toUpperCase();
  }
}
