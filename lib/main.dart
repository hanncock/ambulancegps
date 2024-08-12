import 'package:ambulance/pages/Admin%20Page/adminPage.dart';
import 'package:ambulance/pages/Login.dart';
import 'package:ambulance/pages/bookings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ambulance Dispacch',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
            fontSizeFactor: .9,
            fontSizeDelta: 0.1,
            fontFamily: GoogleFonts.poppins().fontFamily
        ),
        useMaterial3: true,
      ),
      home: Login(),
      // home: Bookings(),
      // home: AdminHome(),
    );
  }
}
