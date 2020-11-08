import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kyc/providers/app_provider.dart';
import 'package:kyc/providers/authentication_provider.dart';
import 'package:kyc/providers/profile_provider.dart';
import 'package:kyc/screens/sign_up.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
      ChangeNotifierProvider(create: (_) => ProfileProvider()),
      Provider(create: (_) => AppProvider()),
    ],
    child: MaterialApp(
      title: 'Kyc Challenge',
      theme: ThemeData(
          primaryColor: Colors.blue,
          accentColor: Colors.white,
          textTheme: TextTheme(
            headline1: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
            headline2: GoogleFonts.montserrat(
                color: Colors.black.withOpacity(0.5),
                fontSize: 16
            ),
            headline3: GoogleFonts.montserrat(
                color: Colors.black.withOpacity(0.5),
                fontSize: 14
            ),

            headline4: GoogleFonts.montserrat(
                color: Colors.green,
                fontSize: 14
            ),
            subtitle1: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 14
            ),

            subtitle2: GoogleFonts.montserrat(
                color: Colors.blue,
                fontSize: 14
            ),
          )
      ),
      home: SignUpScreen(),
    ),
    );
  }
}

