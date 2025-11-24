import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Professional Color Palette - Astrotalk Inspired
class ProfessionalColors {
  // Primary - Teal (Astrotalk style)
  static const Color primary = Color(0xFF00A896); // Teal
  static const Color primaryDark = Color(0xFF007A6B);
  static const Color primaryLight = Color(0xFF00C9B1);
  
  // Secondary - Navy
  static const Color secondary = Color(0xFF2C3E50);
  static const Color secondaryLight = Color(0xFF34495E);
  
  // Accent - Teal (matching primary)
  static const Color accent = Color(0xFF00A896);
  static const Color accentDark = Color(0xFF007A6B);
  
  // Background
  static const Color background = Color(0xFFFFFFFF); // White background like Astrotalk
  static const Color backgroundDark = Color(0xFF1A1D29);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF252836);
  
  // Text
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);
  static const Color textLight = Color(0xFFFFFFFF);
  
  // Status Colors
  static const Color success = Color(0xFF27AE60);
  static const Color error = Color(0xFFE74C3C);
  static const Color warning = Color(0xFFF39C12);
  static const Color info = Color(0xFF3498DB);
  
  // Borders & Dividers
  static const Color border = Color(0xFFE1E8ED);
  static const Color divider = Color(0xFFE1E8ED);
  
  // Chart Colors
  static const List<Color> chartColors = [
    Color(0xFF3498DB),
    Color(0xFF2ECC71),
    Color(0xFFE67E22),
    Color(0xFF9B59B6),
    Color(0xFF1ABC9C),
    Color(0xFF34495E),
  ];
}

// Professional Theme Provider
final professionalThemeProvider = StateNotifierProvider<ProfessionalThemeNotifier, ProfessionalThemeState>(
  (ref) => ProfessionalThemeNotifier(),
);

class ProfessionalThemeState {
  final ThemeMode themeMode;
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  ProfessionalThemeState({
    required this.themeMode,
    required this.lightTheme,
    required this.darkTheme,
  });
}

class ProfessionalThemeNotifier extends StateNotifier<ProfessionalThemeState> {
  ProfessionalThemeNotifier() : super(
    ProfessionalThemeState(
      themeMode: ThemeMode.light,
      lightTheme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
    ),
  );

  void setThemeMode(ThemeMode mode) {
    state = ProfessionalThemeState(
      themeMode: mode,
      lightTheme: state.lightTheme,
      darkTheme: state.darkTheme,
    );
  }

  static ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: ProfessionalColors.primary,
        secondary: ProfessionalColors.secondary,
        surface: ProfessionalColors.surface,
        background: ProfessionalColors.background,
        error: ProfessionalColors.error,
      ),
      scaffoldBackgroundColor: ProfessionalColors.background,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: ProfessionalColors.primary,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        color: ProfessionalColors.surface,
        shadowColor: Colors.black.withOpacity(0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: ProfessionalColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: ProfessionalColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: ProfessionalColors.accent, width: 2),
        ),
        filled: true,
        fillColor: ProfessionalColors.surface,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: ProfessionalColors.primary,
          foregroundColor: ProfessionalColors.textLight,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: ProfessionalColors.divider,
        thickness: 1,
        space: 1,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(Colors.white),
        ),
      ),
      fontFamily: 'Poppins',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: ProfessionalColors.textPrimary,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: ProfessionalColors.textPrimary,
          letterSpacing: -0.5,
        ),
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: ProfessionalColors.textPrimary,
          letterSpacing: -0.3,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: ProfessionalColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: ProfessionalColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: ProfessionalColors.textSecondary,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: ProfessionalColors.textPrimary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  static ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: ProfessionalColors.accent,
        secondary: ProfessionalColors.secondaryLight,
        surface: ProfessionalColors.surfaceDark,
        background: ProfessionalColors.backgroundDark,
        error: ProfessionalColors.error,
      ),
      scaffoldBackgroundColor: ProfessionalColors.backgroundDark,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: ProfessionalColors.primaryDark,
        foregroundColor: ProfessionalColors.textLight,
        iconTheme: IconThemeData(color: ProfessionalColors.textLight),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        color: ProfessionalColors.surfaceDark,
        shadowColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: ProfessionalColors.accent, width: 2),
        ),
        filled: true,
        fillColor: ProfessionalColors.surfaceDark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: ProfessionalColors.accent,
          foregroundColor: ProfessionalColors.textLight,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: Colors.white.withOpacity(0.1),
        thickness: 1,
        space: 1,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(ProfessionalColors.surfaceDark),
        ),
      ),
      fontFamily: 'Poppins',
      textTheme: TextTheme(
        displayLarge: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: ProfessionalColors.textLight,
          letterSpacing: -0.5,
        ),
        displayMedium: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: ProfessionalColors.textLight,
          letterSpacing: -0.5,
        ),
        headlineLarge: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: ProfessionalColors.textLight,
          letterSpacing: -0.3,
        ),
        headlineMedium: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: ProfessionalColors.textLight,
        ),
        bodyLarge: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: ProfessionalColors.textLight,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.white.withOpacity(0.7),
        ),
        labelLarge: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: ProfessionalColors.textLight,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

