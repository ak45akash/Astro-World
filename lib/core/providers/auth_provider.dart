import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user_model.dart';
import '../../features/auth/data/auth_repository.dart';

final authStateProvider = StreamProvider<UserModel?>((ref) {
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

