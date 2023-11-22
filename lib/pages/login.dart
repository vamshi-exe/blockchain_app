import 'dart:convert';
import 'package:blockchain/pages/scanner.dart';
import 'package:http/http.dart' as http;
import 'package:blockchain/pages/otpScreen.dart';
import 'package:blockchain/utils/colors.dart';
import 'package:blockchain/utils/functions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _prefs = SharedPreferences.getInstance();

  TextEditingController _adhaarNo = TextEditingController();
  FocusNode myFocusNode = new FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final text = _adhaarNo.text;
      if (text.length == 12) {
        _isloading
            ? CircularProgressIndicator(
                color: Colors.blue,
              )
            : _startLoading();
        //navigate();
        // Navigate to another page
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const OTPScreen()),
        // );
      }
    }
  }

  bool _isloading = false;
  void _startLoading() {
    setState(() {
      _isloading = true;
    });
    Future.delayed(Duration(seconds: 0), () {
      setState(() {
        _isloading = false;
      });
      navigate();
    });
  }

  Future<void> Login(
    String adhaarNumber,
  ) async {
    var prefs = await _prefs;
    prefs.setString("aadhar_number", adhaarNumber);
    // print(adhaarNumber);
    if (adhaarNumber == "") return;

    try {
      //http://192.168.0.103:5000
      var url = Uri.parse('http://192.168.0.203:5000/api/auth/login/');
      var res = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({'adhaarNumber': adhaarNumber}));
      if (res.statusCode == 200) {
        final snackbar = SnackBar(content: Text('OTP SENT!'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
      if (res.statusCode == 401) {
        final snackbar = SnackBar(content: Text('OTP Failed!'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      } else {
        // print(res.statusCode);
      }
    } catch (err) {
      print(err);
    }
  }

  void navigate() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OTPScreen(
          predata: _adhaarNo.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: loginUI(context),
      ),
    );
  }

  Widget loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
            child: Center(
              child: Image.asset(
                "assets/images/login.png",
                width: 250,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 20,
              top: 50,
              bottom: 30,
            ),
            child: Text(
              'Login',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Color.fromARGB(255, 23, 76, 119)),
            ),
          ),
          //Login
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: _formKey,
              child: TextFormField(
                focusNode: myFocusNode,
                controller: _adhaarNo,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(12),
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter 12 numbers';
                  }
                  if (value.length != 12) {
                    return 'Please enter exactly 12 numbers';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Adhaar Number",
                  labelStyle: TextStyle(
                      color: myFocusNode.hasFocus ? blueColor : blueColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 23, 76, 119),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Color.fromARGB(255, 23, 76, 119),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                _submitForm();
                // navigate();
                Login(_adhaarNo.text);
                // Navigator.pushNamed(context, '/otp');
              },
              child: Container(
                height: 45,
                width: 100,
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor),
                child: Center(
                  child: Text(
                    'Send OTP',
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              "OR",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color.fromARGB(255, 23, 76, 119),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 25, top: 10),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                      color: Color.fromARGB(176, 23, 76, 119), fontSize: 14),
                  children: [
                    TextSpan(text: "Don't have an account? "),
                    TextSpan(
                        text: "SignUp!",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 23, 76, 119),
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, "/details");
                          })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
