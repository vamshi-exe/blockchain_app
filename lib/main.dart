import 'package:blockchain/pages/details.dart';
import 'package:blockchain/pages/home.dart';
import 'package:blockchain/pages/login.dart';
import 'package:blockchain/pages/otpScreen.dart';
import 'package:blockchain/pages/scanner.dart';
import 'package:blockchain/utils/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          // primarySwatch: Colors.red,
          ),
      //home: LoginPage(),
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => HomePage(
              aadharNumber: '',
            ),
        '/details': (context) => const Details(),
        '/otp': (context) => OTPScreen(
              predata: '',
            ),
      },
      // home: StreamBuilder(
      //   // stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.active) {
      //       if (snapshot.hasData) {
      //         return const HomePage();
      //       } else if (snapshot.hasError) {
      //         return Center(
      //           child: Text('${snapshot.error}'),
      //         );
      //       }
      //     }
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //         child: CircularProgressIndicator(
      //           color: blueColor,
      //         ),
      //       );
      //     }
      //     return const LoginPage();
      //   },
      // ),
    );
  }
}
