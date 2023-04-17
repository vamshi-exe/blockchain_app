import 'dart:convert';
import 'dart:developer';
import 'package:blockchain/controllers/helper.dart';
import 'package:blockchain/model/userModel.dart';
import 'package:blockchain/pages/details.dart';
import 'package:blockchain/pages/scanner.dart';
import 'package:flutter/gestures.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:blockchain/pages/login.dart';
import 'package:blockchain/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  String? recievedData;
  final String? aadharNumber,
      firstname,
      middlename,
      lastname,
      dob,
      address_1,
      address_2,
      contactNo,
      pincode,
      state,
      user_image,
      isVerified;

  HomePage(
      {super.key,
      this.aadharNumber,
      this.firstname,
      this.middlename,
      this.lastname,
      this.dob,
      this.address_1,
      this.address_2,
      this.contactNo,
      this.pincode,
      this.state,
      this.user_image,
      this.isVerified,
      this.recievedData});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  int? _age;

  //List<UserModel> user = <UserModel>[];
  List fields = <dynamic>[];
  late SharedPreferences prefs;
  String? aadharNum;
  final _prefs = SharedPreferences.getInstance();

  //bool _isLoading = false;
  @override
  void initState() {
    // dynamic response = details(aadharNum.toString());
    super.initState();
    print('hiii from init state');
    aadhar();
    details();

    // getDetails();
  }

  // getDetails() async {
  //   User newUser = User();
  //   await newUser.getUserDetails();
  //   fields = newUser.data;
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  Future<void> aadhar() async {
    prefs = await _prefs;
    aadharNum = prefs.getString("aadhar_number")!;
    //print("The String is ${prefs.getString("aadhar_number")}");
  }

  /// posting adhaarNO to fetch data present in api
  ///
  Future<Map<String, dynamic>?> details() async {
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

        // print('user ======> ${jsonDecode(res.body)['user']['firstname']}');
        // print('user ======> ${jsonDecode(res.body)['user']['middlename']}');
        // print('user ======> ${jsonDecode(res.body)['user']['lastname']}');
        // print('user ======> ${jsonDecode(res.body)['user']['dob']}');
        // print('user ======> ${jsonDecode(res.body)['user']['address_1']}');
        // print('user ======> ${jsonDecode(res.body)['user']['address_2']}');
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

        //
        //print('tis is from setstate ${_responseText.toString()}');
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

  var _responseText;

  Future makeRequest() async {
    var getUrl = Uri.parse('http://192.168.0.103:5000/api/auth/user');
    var getResponse = await http.get(getUrl);
    setState(() {
      _responseText = getResponse.body;
    });
  }

  ///req data from api///
//how to fetch data from api in flutter?

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            //  scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      'assets/images/bg_image.jpg',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 10),
                      child: GlassmorphicContainer(
                        width: 40,
                        height: 40,
                        borderRadius: 5,
                        linearGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFFffffff).withAlpha(0),
                              const Color(0xFFffffff).withAlpha(0),
                            ],
                            stops: [
                              0.3,
                              1,
                            ]),
                        border: 0,
                        blur: 7,
                        borderGradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            colors: [
                              const Color(0xFF4579C5).withAlpha(100),
                              const Color(0x0fffffff).withAlpha(55),
                              const Color(0xFFF75035).withAlpha(10),
                            ],
                            stops: [
                              0.06,
                              0.95,
                              1
                            ]),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QRViewExample(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.qr_code_scanner,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.16),
                      child: Center(
                        child: Container(
                          //color: Colors.white,
                          height: MediaQuery.of(context).size.height,
                          //width: 100,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35),
                                topRight: Radius.circular(35)),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.10),
                        child: Stack(
                          children: [
                            CircleAvatar(
                                radius: 64,
                                backgroundImage:
                                    // NetworkImage('$_response_user_image'),
                                    Image.network(_response_user_image).image),
                            Positioned(
                              top: MediaQuery.of(context).size.height * 0.12,
                              left: MediaQuery.of(context).size.width * 0.2,
                              child: Image.asset(
                                'assets/images/green_tick.png',
                                height: 55,
                                width: 55,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.3,
                      left: MediaQuery.of(context).size.width * 0.3,
                      child: Column(
                        children: [
                          Text(
                            '${_response_verified}',
                            style: GoogleFonts.poppins(
                                fontSize: 18, color: Colors.green),
                          ),
                          Row(
                            children: [
                              Image.asset('assets/images/location.png',
                                  width: 35, height: 35),
                              Text(
                                '$_response_state',
                                style:
                                    TextStyle(fontSize: 19, color: blueColor),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.4,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Name: ${_response_Fname + " " + _response_Lname} ',
                                  style: GoogleFonts.poppins(
                                      fontSize: 20, color: blueColor),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Middle Name: ${_response_Mname + " " + _response_Lname}  ',
                                style: GoogleFonts.poppins(
                                    fontSize: 20, color: blueColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Contact No: +91-$_response_contact_no ',
                                style: GoogleFonts.poppins(
                                    fontSize: 20, color: blueColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'DOB: $_response_DOB',
                                style: GoogleFonts.poppins(
                                    fontSize: 20, color: blueColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Gender : Male ',
                                style: GoogleFonts.poppins(
                                    fontSize: 20, color: blueColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'Address: ',
                                    style: GoogleFonts.poppins(
                                        fontSize: 20, color: blueColor),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      '${_response_add_1 + " " + "," + " " + _response_add_2}',
                                      //maxLines: 1,
                                      style: GoogleFonts.poppins(
                                          fontSize: 19, color: blueColor),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Pincode: $_response_pincode ',
                                style: GoogleFonts.poppins(
                                    fontSize: 20, color: blueColor),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: details,
                              child: Text('data'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                    color: blueColor,
                                    borderRadius: BorderRadius.circular(50)),
                                child: IconButton(
                                  onPressed: () {
                                    //print('this is adhaar no $predata');
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return SimpleDialog(
                                            //title: const Text('Scan!'),
                                            children: [
                                              SimpleDialogOption(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: const Text('Logout'),
                                                onPressed: () {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const LoginPage()));
                                                },
                                              ),
                                              SimpleDialogOption(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: const Text('Cancel'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  icon: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Logout',
                                        style: GoogleFonts.poppins(
                                            fontSize: 21, color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Icon(
                                        Icons.logout,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //////////////////////////////////
          // body: Column(
          //   children: [
          //     ElevatedButton(
          //       onPressed: () {
          //         details();
          //       },
          //       child: Text('send'),
          //     ),
          //     Text(widget.recievedData.toString()),
          //     Text(
          //       'this is name${_response_Fname}',
          //       style: TextStyle(color: Colors.black),
          //     ),
          //     SizedBox(
          //       height: 20,
          //     ),
          //     Text(_response)
          //     // Text(
          //     //   _response,
          //     //   style: GoogleFonts.poppins(color: Colors.black, fontSize: 21),
          //     // ),
          //     //Text(_responseText!)
          //   ],
          // )
          //ApiCall(response: response),
        ),
      ),
    );
  }
}

class ApiCall extends StatelessWidget {
  const ApiCall({
    super.key,
    required this.response,
  });

  final response;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: response,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(children: [
                ListTile(
                  title: Text(snapshot.data[index]['firstname']),
                )
              ]),
            );
          });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
