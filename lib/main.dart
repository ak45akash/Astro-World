import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/config/firebase_config.dart';
import 'core/config/app_config.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set environment (can be changed based on build flavor or environment variable)
  // For production, set: AppConfig.setEnvironment(Environment.production);
  AppConfig.setEnvironment(Environment.development);
  
  // Initialize Firebase with error handling
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // If Firebase initialization fails, continue anyway for UI testing
    debugPrint('Firebase initialization error: $e');
    debugPrint('App will continue without Firebase (UI mode)');
  }
  
  // Initialize notification service (skip in test mode)
  if (!AppConfig.isTesting) {
    try {
      await NotificationService.initialize();
    } catch (e) {
      debugPrint('Notification service initialization error: $e');
    }
  }
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(
    const ProviderScope(
      child: AstrologyApp(),
    ),
  );
}

class AstrologyApp extends ConsumerWidget {
  const AstrologyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final theme = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'Astrology App',
      debugShowCheckedModeBanner: false,
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      themeMode: theme.themeMode,
      routerConfig: router,
    );
  }
}

