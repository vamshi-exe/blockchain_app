// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'package:blockchain/model/userModel.dart';
import 'package:blockchain/pages/home.dart';
import 'package:blockchain/pages/login.dart';
import 'package:blockchain/utils/urllist.dart';
import 'package:http/http.dart' as http;
import 'package:blockchain/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPScreen extends StatefulWidget {
  String predata;

  OTPScreen({
    super.key,
    required this.predata,
  });

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otp = TextEditingController();

  @override
  void initState() {
    aadhar();
    super.initState();
  }

  late SharedPreferences prefs;
  String? aadharNum;
  final _prefs = SharedPreferences.getInstance();

  Future<void> aadhar() async {
    prefs = await _prefs;
    aadharNum = prefs.getString("aadhar_number")!;
  }

  Future<UserData> fetchData(BuildContext context) async {
    var data = {
      "adhaarNumber": aadharNum,
      "otp": otp.text,
    };
    final response = await http.post(
      Uri.parse("${Urllist.base_url}api/auth/otp/verify"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print(response.body);
      forwardNav();
      await saveAuthenticationStatus(true);
      return UserData.fromJson(jsonDecode(response.body));
    } else {
      // Handle errors
      print("Failed to load data. Status code: ${response.statusCode}");
      throw Exception('Failed to fetch data');
    }
  }

  void navigate() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  void forwardNav() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
            // recievedData: _response,
            ),
      ),
    );
  }

  Future<void> saveAuthenticationStatus(bool isAuthenticated) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isAuthenticated', isAuthenticated);
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 23, 76, 119),
          fontWeight: FontWeight.w500),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 173, 181, 187)),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromARGB(255, 23, 76, 119)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Center(
                      child: Image.asset(
                        "assets/images/login.png",
                        width: 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 50,
                      bottom: 30,
                    ),
                    child: Center(
                      child: Text(
                        'Enter the OTP !',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color: const Color.fromARGB(255, 23, 76, 119)),
                      ),
                    ),
                  ),
                  Text(
                    "We need to verify your phone number before getting started!",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: const Color.fromARGB(255, 23, 76, 119)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 05),
                    child: InkWell(
                      onTap: navigate,
                      //onTap: Navigator.pushNamed(context, '/');,
                      child: Text(
                        "Not ${widget.predata} ?",
                        style: GoogleFonts.poppins(
                            decoration: TextDecoration.underline,
                            decorationColor: blueColor,
                            decorationThickness: 1,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: const Color.fromARGB(255, 23, 76, 119)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Pinput(
                      defaultPinTheme: defaultPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      controller: otp,
                      length: 6,
                      showCursor: true,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // forwardNav();
                        // verifyOTP(otp.text);
                        fetchData(context);
                        // details(aadharNum.toString());
                      },
                      child: Container(
                          width: 100,
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color.fromARGB(255, 23, 76, 119)),
                          child: Center(
                            child: Text(
                              'Verify',
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 21),
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        GestureDetector(
                          // onTap: ,
                          child: Text(
                            'Resend OTP ',
                            style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                                color: blueColor),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
