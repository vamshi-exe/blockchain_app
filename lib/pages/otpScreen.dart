import 'dart:async';
import 'dart:convert';
import 'package:blockchain/pages/home.dart';
import 'package:blockchain/pages/login.dart';
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
  String _response = "";
  String _response_Fname = "";
  String _response_Mname = "";
  String _response_Lname = "";
  String _response_add_1 = "";
  String _response_add_2 = "";
  String _response_user_image = "";
  String _response_contact_no = "";
  String _response_state = "";
  String _response_DOB = "";
  String _response_verified = "";
  String _response_pincode = "";
  DateTime? _selectedDate;

  TextEditingController otp = TextEditingController();

  @override
  void initState() {
    aadhar();
    print('initstate');
    print(widget.predata);
    super.initState();
  }

  late SharedPreferences prefs;
  String? aadharNum;
  final _prefs = SharedPreferences.getInstance();

  Future<void> aadhar() async {
    prefs = await _prefs;
    aadharNum = prefs.getString("aadhar_number")!;
    //print("The String is ${prefs.getString("aadhar_number")}");
  }

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
        forwardNav();
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

  String? resobj;

  Future<Map<String, dynamic>?> details(String resobj) async {
    try {
      var url = Uri.parse('http://192.168.0.103:5000/api/auth/user');
      final headers = {'Content-Type': 'application/json; charset=UTF-8'};
      var postdata = {
        "adhaarNumber": aadharNum,
      };
      var res = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(postdata));
      print('this is data $postdata');
      print('this is res $res');
      if (res.statusCode == 200) {
        //print('this is response object ${json.decode(res.body)}');

        //dynamic ud = json.decode(res.body.toString());

        Map<String, dynamic> resobj = jsonDecode(res.body)['user'];
        var fname = jsonDecode(res.body)['user']['firstname'];
        var mname = jsonDecode(res.body)['user']['middlename'];
        var lname = jsonDecode(res.body)['user']['lastname'];
        var dob = jsonDecode(res.body)['user']['dob'];
        var add1 = jsonDecode(res.body)['user']['address_1'];
        var add2 = jsonDecode(res.body)['user']['address_2'];
        var contact = jsonDecode(res.body)['user']['contactNo'];
        var state = jsonDecode(res.body)['user']['state'];
        var verified = jsonDecode(res.body)['user']['isVerified'];
        var pincode = jsonDecode(res.body)['user']['pincode'];
        var userimage = jsonDecode(res.body)['user']['user_image'];
        var adhaarimage = jsonDecode(res.body)['user']['adhaar_image'];

        print('user ======> $resobj');
        print('user ======> $fname');
        print('user ======> $mname');
        print('user ======> $lname');
        print('user ======> $dob');
        print('user ======> $add1');
        print('user ======> $add2');
        print('user ======> ${verified.toString()}');
        print('user ======> $userimage');
        print('user ======> $adhaarimage');
        print('user ======> $pincode');
        print('user ======> $state');
        print('user ======> $contact');

        setState(() {
          _response = resobj.toString();
        });
        setState(() {
          _response_Fname = fname;
        });
        setState(() {
          _response_Mname = mname;
        });
        setState(() {
          _response_Lname = lname;
        });
        setState(() {
          _response_contact_no = contact;
        });
        setState(() {
          _response_DOB = dob;
        });
        setState(() {
          _response_state = state;
        });
        setState(() {
          _response_add_1 = add1;
        });
        setState(() {
          _response_add_2 = add2;
        });
        setState(() {
          _response_verified = verified.toString();
        });
        setState(() {
          _response_pincode = pincode;
        });
        setState(() {
          _response_user_image = userimage;
        });
        // print('user ======> $resobj');
        setState(() {
          _response = resobj.toString();
        });
        // print('tis is from setstate ${_responseText.toString()}');
        dynamic user = res.body;
        print('${json.decode(user.body)}');
        print('qwrtyuiop ${user.user}');

        return resobj;
      } else {
        throw Exception('Failed to verify OTP');
      }
    } catch (err) {
      print('error was :$err');
    }
    return null;
  }

  void navigate() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  void forwardNav() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          recievedData: _response,
        ),
      ),
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
        border: Border.all(color: Color.fromARGB(255, 173, 181, 187)),
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
                        details(aadharNum.toString());
                        // forwardNav();
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     // settings: RouteSettings(arguments: widget.predata),
                        //     builder: (context) {
                        //       return HomePage();
                        //     },
                        //   ),
                        // );
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
                  // Text(
                  //   _response.toString(),
                  //   style:
                  //       GoogleFonts.poppins(color: Colors.black, fontSize: 21),
                  // ),
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
