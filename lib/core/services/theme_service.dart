import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService extends GetxService {
  late GetStorage _box;

  ThemeService() {
    _box = GetStorage();
  }

  ThemeData getLightTheme() {
    return ThemeData(
      primaryColor: const Color(0xffe82c2e),
      secondaryHeaderColor: const Color(0xff066834),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 0, foregroundColor: Color(0xffe82c2e)),
      scaffoldBackgroundColor: const Color(0xff1F1D47),
      brightness: Brightness.light,
      dividerColor: Colors.grey.shade800,
      focusColor: const Color(0xffe82c2e),
      hoverColor: const Color(0xffe82c2e), //for error and delete
      hintColor: const Color(0xff9f9f9f),
      splashColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade50,
      cardColor: Color.fromARGB(255, 74, 69, 179),
      primaryColorDark: Color.fromARGB(255, 3, 0, 66),
    );
    // colorScheme: const ColorScheme.light(
    //     primary: Color(0xffe82c2e), secondary: Color(0xffe82c2e),));
    // textTheme: GoogleFonts.getTextTheme(
    //     'Poppins',
    //     const TextTheme(
    //       titleLarge: TextStyle(
    //           fontSize: 15.0,
    //           fontWeight: FontWeight.w500,
    //           color: Color(0xffe82c2e),
    //           height: 1.3),
    //       headlineSmall: TextStyle(
    //           fontSize: 16.0,
    //           fontWeight: FontWeight.w500,
    //           color: Colors.black,
    //           height: 1.3),
    //       headlineMedium: TextStyle(
    //           fontSize: 18.0,
    //           fontWeight: FontWeight.w200,
    //           color: Colors.black,
    //           height: 1.3),
    //       displaySmall: TextStyle(
    //           fontSize: 20.0,
    //           fontWeight: FontWeight.w500,
    //           color: Colors.black,
    //           height: 1.3),
    //       displayMedium: TextStyle(
    //           fontSize: 22.0,
    //           fontWeight: FontWeight.w500,
    //           color: Color(0xffe82c2e),
    //           height: 1.4),
    //       displayLarge: TextStyle(
    //           fontSize: 24.0,
    //           fontWeight: FontWeight.w200,
    //           color: Colors.black,
    //           height: 1.4),
    //       titleSmall: TextStyle(
    //           fontSize: 15.0,
    //           fontWeight: FontWeight.w400,
    //           color: Colors.black,
    //           height: 1.2),
    //       titleMedium: TextStyle(
    //           fontSize: 13.0,
    //           fontWeight: FontWeight.w200,
    //           color: Color(0xffe82c2e),
    //           height: 1.2),
    //       bodyMedium: TextStyle(
    //           fontSize: 13.0,
    //           fontWeight: FontWeight.w400,
    //           color: Colors.black,
    //           height: 1.2),
    //       bodyLarge: TextStyle(
    //           fontSize: 12.0,
    //           fontWeight: FontWeight.w200,
    //           color: Colors.black,
    //           height: 1.2),
    //       bodySmall: TextStyle(
    //           fontSize: 12.0,
    //           fontWeight: FontWeight.w100,
    //           color: Color(0xffe82c2e),
    //           height: 1.2),
    //     )));
  }

  ThemeData getDarkTheme() {
    return ThemeData(
      primaryColor: const Color(0xffe82c2e),
      secondaryHeaderColor: const Color(0xffe82c2e),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 0, foregroundColor: Color(0xffe82c2e)),
      scaffoldBackgroundColor: const Color(0xFF2C2C2C),
      brightness: Brightness.dark,
      dividerColor: Colors.white38,
      focusColor: const Color(0xffe95434),
      hintColor: Colors.white38,
      splashColor: const Color(0xFF2C2C2C),
      highlightColor: Colors.grey.shade800,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xffe95434),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF2C2C2C),
      ),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xffe95434),
        secondary: Colors.white38,
      ),
    );

    // textTheme: GoogleFonts.getTextTheme(
    //     "Poppins",
    //     const TextTheme(
    //       titleLarge: TextStyle(
    //           fontSize: 15.0,
    //           fontWeight: FontWeight.w700,
    //           color: Color(0xffe95434),
    //           height: 1.3),
    //       headlineSmall: TextStyle(
    //           fontSize: 16.0,
    //           fontWeight: FontWeight.w700,
    //           color: Color(0xffe95434),
    //           height: 1.3),
    //       headlineMedium: TextStyle(
    //           fontSize: 18.0,
    //           fontWeight: FontWeight.w400,
    //           color: Colors.white,
    //           height: 1.3),
    //       displaySmall: TextStyle(
    //           fontSize: 20.0,
    //           fontWeight: FontWeight.w700,
    //           color: Colors.white,
    //           height: 1.3),
    //       displayMedium: TextStyle(
    //           fontSize: 22.0,
    //           fontWeight: FontWeight.w700,
    //           color: Color(0xffe95434),
    //           height: 1.4),
    //       displayLarge: TextStyle(
    //           fontSize: 24.0,
    //           fontWeight: FontWeight.w300,
    //           color: Colors.white,
    //           height: 1.4),
    //       titleSmall: TextStyle(
    //           fontSize: 15.0,
    //           fontWeight: FontWeight.w600,
    //           color: Colors.white,
    //           height: 1.2),
    //       titleMedium: TextStyle(
    //           fontSize: 13.0,
    //           fontWeight: FontWeight.w400,
    //           color: Color(0xffe95434),
    //           height: 1.2),
    //       bodyMedium: TextStyle(
    //           fontSize: 13.0,
    //           fontWeight: FontWeight.w600,
    //           color: Colors.white,
    //           height: 1.2),
    //       bodyLarge: TextStyle(
    //           fontSize: 12.0,
    //           fontWeight: FontWeight.w400,
    //           color: Colors.white,
    //           height: 1.2),
    //       bodySmall: TextStyle(
    //           fontSize: 12.0,
    //           fontWeight: FontWeight.w300,
    //           color: Color(0xffe95434),
    //           height: 1.2),
    //     ),),

    //   thumbColor: MaterialStateProperty.resolveWith<Color?>(
    //       (Set<MaterialState> states) {
    //     if (states.contains(MaterialState.disabled)) {
    //       return null;
    //     }
    //     if (states.contains(MaterialState.selected)) {
    //       return const Color(0xffe95434);
    //     }
    //     return null;
    //   }),
    //   trackColor: MaterialStateProperty.resolveWith<Color?>(
    //       (Set<MaterialState> states) {
    //     if (states.contains(MaterialState.disabled)) {
    //       return null;
    //     }
    //     if (states.contains(MaterialState.selected)) {
    //       return const Color(0xffe95434);
    //     }
    //     return null;
    //   }),
    // ));
  }

  ThemeMode getThemeMode() {
    String? themeMode = GetStorage().read<String>('theme_mode');
    switch (themeMode) {
      case 'ThemeMode.light':
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.light
              .copyWith(systemNavigationBarColor: Colors.white),
        );
        return ThemeMode.light;
      case 'ThemeMode.dark':
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.dark
              .copyWith(systemNavigationBarColor: Colors.black87),
        );
        return ThemeMode.dark;
      default:
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.light
              .copyWith(systemNavigationBarColor: Colors.white),
        );
        return ThemeMode.light;
    }
  }
}
