import 'dart:convert';
import 'dart:developer';
import 'package:blockchain/pages/scanner.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:blockchain/pages/login.dart';
import 'package:blockchain/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    required this.aadharNumber,
  });

  final String aadharNumber;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Future<void> scanning() async {
  //   print('this is ${widget.predata}');
  //   var url = Uri.parse('http://192.168.218.11:5000/api/verify-scan');
  //   final headers = {'Content-Type': 'application/json; charset=UTF-8'};
  //   var data = {
  //     "adhaarNumber": widget.predata,
  //   };

  //   print(data);
  //   try {
  //     var res = await http.post(url,
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //         },
  //         body: json.encode(data));
  //     print('this is res $res');
  //     if (res.statusCode == 200) {
  //       final snackbar = SnackBar(content: Text('scanned Successfully!'));
  //       ScaffoldMessenger.of(context).showSnackBar(snackbar);

  //       return jsonDecode(res.body)['success'];
  //     } else {
  //       final snackbar = SnackBar(content: Text('scanning failed! Try Again'));
  //       ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //       Text('Error sending data.');
  //       throw Exception('Failed to verify OTP');
  //     }
  //   } catch (err) {
  //     print('error was :$err');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          extendBodyBehindAppBar: true,

          // body: Padding(
          //   padding: const EdgeInsets.only(top: 20),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(predata.toString()),
          //       Padding(
          //         padding: const EdgeInsets.only(left: 10),
          //         child: Text(
          //           'Welcome Ashish!',
          //           style: GoogleFonts.poppins(fontSize: 24, color: blueColor),
          //         ),
          //       ),
          //       Center(
          //         child: Container(
          //           height: 220,
          //           width: MediaQuery.of(context).size.width * 0.98,
          //           decoration: BoxDecoration(
          //               color: blueColor,
          //               borderRadius: BorderRadius.circular(20)),
          //           child: Row(
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.all(8.0),
          //                 child: CircleAvatar(
          //                     radius: 64,
          //                     backgroundImage: NetworkImage(
          //                         'https://t3.ftcdn.net/jpg/03/46/83/96/240_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg')),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.only(top: 40),
          //                 child: Column(
          //                   mainAxisAlignment: MainAxisAlignment.start,
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     //Text(),
          //                     Text(
          //                       'Name: Ashish Sinha',
          //                       style: GoogleFonts.poppins(
          //                           fontSize: 15, color: Colors.white),
          //                     ),
          //                     Text(
          //                       'DOB: 21 NOV 2001',
          //                       style: GoogleFonts.poppins(
          //                           fontSize: 15, color: Colors.white),
          //                     ),
          //                     Text(
          //                       'Sex: Male',
          //                       style: GoogleFonts.poppins(
          //                           fontSize: 15, color: Colors.white),
          //                     ),
          //                     Text(
          //                       'Add: PHCET Rasayani',
          //                       style: GoogleFonts.poppins(
          //                           fontSize: 15, color: Colors.white),
          //                     ),
          //                     // SizedBox(
          //                     //   height: 10,
          //                     // ),
          //                     Row(
          //                       children: [
          //                         Text(
          //                           'Status: VERIFIED !',
          //                           style: GoogleFonts.poppins(
          //                               fontSize: 15, color: Colors.white),
          //                         ),
          //                         SizedBox(
          //                           width: 10,
          //                         ),
          //                         Image.asset(
          // 'assets/images/green_tick.png',
          // height: 45,
          // width: 45,
          //                         )
          //                       ],
          //                     )
          //                   ],
          //                 ),
          //               )
          //             ],
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            //  scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      'assets/images/bg_image.jpg',
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8, top: 10),
                      child: GlassmorphicContainer(
                        width: 40,
                        height: 40,
                        borderRadius: 5,
                        linearGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFffffff).withAlpha(0),
                              Color(0xFFffffff).withAlpha(0),
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
                              Color(0xFF4579C5).withAlpha(100),
                              Color(0xFFFFFFF).withAlpha(55),
                              Color(0xFFF75035).withAlpha(10),
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
                            icon: Icon(
                              Icons.qr_code_scanner,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 8, top: 10),
                    //   child: Container(
                    //     height: 35,
                    //     width: 35,
                    //     decoration: BoxDecoration(
                    //         color: Colors.white.withOpacity(0.25),
                    //         borderRadius: BorderRadius.circular(5)),
                    //     child: Center(
                    //       child: IconButton(
                    //         onPressed: () {
                    //           Navigator.push(
                    //               context,
                    //               MaterialPageRoute(
                    //                   builder: (context) => QRViewExample()));
                    //         },
                    //         icon: Icon(
                    //           Icons.qr_code_scanner,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 170),
                      child: Center(
                        child: Container(
                          //color: Colors.white,
                          height: MediaQuery.of(context).size.height,
                          //width: 100,
                          decoration: BoxDecoration(
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
                        padding: const EdgeInsets.only(top: 110),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundImage: NetworkImage(
                                  'https://t3.ftcdn.net/jpg/03/46/83/96/240_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
                            ),
                            Positioned(
                              top: 80,
                              left: 75,
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
                      top: 250,
                      left: 105,
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/location.png',
                            height: 30,
                            width: 30,
                          ),
                          Text(
                            'Maharashtra | 21',
                            style: GoogleFonts.poppins(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 300,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'First Name',
                                      style: GoogleFonts.poppins(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Center(
                                        child: Text(
                                          'Vamshi',
                                          style:
                                              GoogleFonts.poppins(fontSize: 20),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.12),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                ///// last name /////
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Last Name',
                                      style: GoogleFonts.poppins(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Center(
                                        child: Text(
                                          'Vadnala',
                                          style:
                                              GoogleFonts.poppins(fontSize: 20),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.12),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //////////////////////////////////
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Address',
                                  style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          '312/202, Ch Ramaiah Bldg, Padmanagar, Bhiwandi',
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style:
                                              GoogleFonts.poppins(fontSize: 17),
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.12),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Contact Number',
                                      style: GoogleFonts.poppins(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      width: MediaQuery.of(context).size.width *
                                          0.55,
                                      child: Center(
                                        child: Text(
                                          '+91-7620237601',
                                          style:
                                              GoogleFonts.poppins(fontSize: 19),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.12),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sex',
                                      style: GoogleFonts.poppins(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: Center(
                                        child: Text(
                                          'Male',
                                          style:
                                              GoogleFonts.poppins(fontSize: 20),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.12),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            ///////////////////////////////////////
                            SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                width: MediaQuery.of(context).size.width * 0.75,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: blueColor),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Logout ',
                                        style: GoogleFonts.poppins(
                                            fontSize: 24, color: Colors.white),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return SimpleDialog(
                                                children: [
                                                  SimpleDialogOption(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: const Text('Logout'),
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const LoginPage(),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  SimpleDialogOption(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: const Text('Cancel'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                      icon: Icon(
                                        Icons.logout,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
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
        ),
      ),
    );
  }
}

    // IconButton(
    //                           onPressed: () {
    //                             //print('this is adhaar no $predata');
    //                             showDialog(
    //                                 context: context,
    //                                 builder: (context) {
    //                                   return SimpleDialog(
    //                                     //title: const Text('Scan!'),
    //                                     children: [
    //                                       SimpleDialogOption(
    //                                         padding: const EdgeInsets.all(20),
    //                                         child: const Text('Logout'),
    //                                         onPressed: () {
    //                                           Navigator.pushReplacement(
    //                                               context,
    //                                               MaterialPageRoute(
    //                                                   builder: (context) =>
    //                                                       const LoginPage()));
    //                                         },
    //                                       ),
    //                                       SimpleDialogOption(
    //                                         padding: const EdgeInsets.all(20),
    //                                         child: const Text('Cancel'),
    //                                         onPressed: () {
    //                                           Navigator.of(context).pop();
    //                                         },
    //                                       )
    //                                     ],
    //                                   );
    //                                 });
    //                           },
    //                           icon: Icon(
    //                             Icons.more_vert_outlined,
    //                             color: Colors.white,
    //                           ),
    //                         )
                          