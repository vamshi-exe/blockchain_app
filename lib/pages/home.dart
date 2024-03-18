// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'dart:convert';
import 'package:blockchain/model/userModel.dart';
import 'package:blockchain/pages/scanner.dart';
import 'package:blockchain/utils/urllist.dart';
import 'package:glassmorphism/glassmorphism.dart';
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
  List fields = <dynamic>[];
  late SharedPreferences prefs;
  String? aadharNum;
  final _prefs = SharedPreferences.getInstance();
  @override
  void initState() {
    super.initState();
    // details();
  }

  Future<void> aadhar() async {
    prefs = await _prefs;
    aadharNum = prefs.getString("aadhar_number")!;
  }

  Future<UserData> details() async {
    await aadhar();
    var url = Uri.parse(
        '${Urllist.base_url}api/auth/getData?adhaarNumber=$aadharNum');
    var res = await http.get(
      url,
    );

    if (res.statusCode == 200) {
      print(res.body);
      return UserData.fromJson(jsonDecode(res.body));
    } else {
      print(res.statusCode);
      print(res.body);
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final userData = Provider.of<UserProvider>(context, listen: false).userData;

    return Scaffold(
      extendBodyBehindAppBar: false,
      body: FutureBuilder(
        future: details(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            final userData = snapshot.data;
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        'assets/images/bg_image.jpg',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 30),
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
                              stops: const [
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
                              stops: const [
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
                                    builder: (context) => QRViewExample(
                                      adhaarNumber: aadharNum!,
                                    ),
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
                            top: MediaQuery.of(context).size.height * 0.2),
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
                              top: MediaQuery.of(context).size.height * 0.12),
                          child: Stack(
                            children: [
                              CircleAvatar(
                                  radius: 75,
                                  backgroundImage: Image.network(
                                    userData!.userImage,
                                  ).image),
                              Positioned(
                                top: 107,
                                left: 90,
                                child: Visibility(
                                  visible: userData.isVerified,
                                  child: Image.asset(
                                    'assets/images/green_tick.png',
                                    height: 55,
                                    width: 55,
                                  ),
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
                            Visibility(
                              visible: !userData.isVerified,
                              child: const Row(
                                children: [
                                  Text('Verification Pending'),
                                  Icon(
                                    Icons.warning,
                                    color: Colors.amber,
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Image.asset('assets/images/location.png',
                                    width: 35, height: 35),
                                Text(
                                  userData.state,
                                  style: const TextStyle(
                                      fontSize: 19, color: blueColor),
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
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Name: ${"${userData.firstname} ${userData.lastname}"} ',
                                    style: GoogleFonts.poppins(
                                        fontSize: 20, color: blueColor),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  'Middle Name: ${"${userData.middlename} ${userData.lastname}"}  ',
                                  style: GoogleFonts.poppins(
                                      fontSize: 20, color: blueColor),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  'Contact No: +91-${userData.contactNo} ',
                                  style: GoogleFonts.poppins(
                                      fontSize: 20, color: blueColor),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  'DOB: ${userData.dob}',
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
                                        "${userData.address1} , ${userData.address2}",
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
                                  'Pincode: ${userData.pincode} ',
                                  style: GoogleFonts.poppins(
                                      fontSize: 20, color: blueColor),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
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
                                                    prefs.setBool(
                                                        'isAuthenticated',
                                                        false);
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Logout',
                                          style: GoogleFonts.poppins(
                                              fontSize: 21,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        const Icon(
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
            );
          }
        },
      ),
    );
  }
}
