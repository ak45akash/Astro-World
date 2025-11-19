import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user_model.dart';
import '../../features/auth/data/auth_repository.dart';
import '../config/app_config.dart';

final authStateProvider = StreamProvider<UserModel?>((ref) {
  if (AppConfig.isTesting) {
    return Stream.value(
      UserModel(
        id: 'demo-user',
        email: 'demo@astrology.app',
        displayName: 'Demo User',
        role: 'end_user', // Changed to end_user to show user-facing UI
        createdAt: DateTime.now(),
      ),
    );
  }

  try {
    return ref.watch(authRepositoryProvider).authStateChanges();
  } catch (e) {
    // Return empty stream if Firebase/auth fails
    return Stream.value(null);
  }
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});
