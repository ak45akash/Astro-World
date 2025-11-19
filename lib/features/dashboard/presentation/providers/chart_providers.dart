import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../data/chart_repository.dart';
import '../../domain/models/chart_models.dart';

final chartRepositoryProvider = Provider<ChartRepository>((ref) {
  return ChartRepository();
});

final chartBundleProvider = FutureProvider<ChartBundle>((ref) async {
  final authState = ref.watch(authStateProvider);
  final userId = authState.value?.id ?? 'demo-user';
  final repository = ref.watch(chartRepositoryProvider);
  return repository.loadChartsForUser(userId);
});
