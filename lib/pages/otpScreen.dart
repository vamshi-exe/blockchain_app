import 'dart:async';
import 'dart:convert';
import 'package:blockchain/pages/home.dart';
import 'package:blockchain/pages/login.dart';
import 'package:http/http.dart' as http;
import 'package:blockchain/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

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

  Future<void> verifyOTP(String enteredOtp) async {
    print(otp.text);
    print(widget.predata);
    // var url = Uri.parse('http://192.168.218.11:5000/api/auth/otp/verify');
    var url = Uri.parse('http://192.168.0.103:5000/api/auth/otp/verify');
    final headers = {'Content-Type': 'application/json; charset=UTF-8'};
    var data = {"adhaarNumber": widget.predata, "otp": otp.text};
    print(data);
    try {
      var res = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(data));
      print('this is res $res');
      if (res.statusCode == 200) {
        print(res);
        final snackbar = SnackBar(content: Text('Verified Successfully!'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(aadharNumber: widget.predata),
          ),
        );
        return jsonDecode(res.body)['success'];
      } else {
        final snackbar =
            SnackBar(content: Text('Verification failed! Try Again'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        Text('Error sending data.');
        throw Exception('Failed to verify OTP');
      }
    } catch (err) {
      print('error was :$err');
    }
  }

  void navigate() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => LoginPage(), maintainState: false),
    );
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
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
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
                    padding: EdgeInsets.only(left: 05),
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
                  SizedBox(
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
                      // onTap: () => Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(
                      //     builder: (context) => HomePage(),
                      //   ),
                      // ),
                      onTap: () {
                        verifyOTP(otp.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // settings: RouteSettings(arguments: widget.predata),
                            builder: (context) {
                              return HomePage(
                                aadharNumber: widget.predata,
                              );
                            },
                          ),
                        );
                        // verifyOTP(otp.text);
                        // Navigator.of(context).pushReplacement(
                        //   MaterialPageRoute(
                        //     builder: (context) => const HomePage(),
                        //   ),
                        // );
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
