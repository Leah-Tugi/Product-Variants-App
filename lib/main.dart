import 'package:flutter/material.dart';
import 'package:product_variants_app/screens/product_option_screen.dart';

void main() {
  runApp( ProductVariantsApp());
}

class ProductVariantsApp extends StatelessWidget {
   ProductVariantsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Variants App',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: ProductOptionScreen(),
    );
  }

  final ThemeData appTheme = ThemeData(
    primaryColor: const Color(0xFF9584D8),
    fontFamily: 'Roboto',

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF9584D8),
        side: const BorderSide(color: Color(0xFF9584D8)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        minimumSize: const Size(double.infinity, 50),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF9584D8)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF9584D8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF9584D8), width: 2),
      ),
    ),
  );


}

