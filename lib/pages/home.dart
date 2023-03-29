import 'dart:convert';
import 'dart:developer';
import 'package:blockchain/pages/scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:blockchain/pages/login.dart';
import 'package:blockchain/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

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
          //                           'assets/images/green_tick.png',
          //                           height: 45,
          //                           width: 45,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 10),
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.23),
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 2,
                              right: 1,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => QRViewExample(
                                                predata: '',
                                              )));
                                },
                                icon: Icon(
                                  Icons.qr_code_scanner,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Stack(
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.only(left: 11, top: 8),
                        //       child: Container(
                        //         height: 35,
                        //         width: 25,
                        //         decoration: BoxDecoration(
                        //             color: Colors.white.withOpacity(0.25),
                        //             borderRadius: BorderRadius.circular(5)),
                        //       ),
                        //     ),
                        //     IconButton(
                        //       onPressed: () {
                        //         //print('this is adhaar no $predata');
                        //         showDialog(
                        //             context: context,
                        //             builder: (context) {
                        //               return SimpleDialog(
                        //                 //title: const Text('Scan!'),
                        //                 children: [
                        //                   SimpleDialogOption(
                        //                     padding: const EdgeInsets.all(20),
                        //                     child: const Text('Logout'),
                        //                     onPressed: () {
                        //                       Navigator.pushReplacement(
                        //                           context,
                        //                           MaterialPageRoute(
                        //                               builder: (context) =>
                        //                                   const LoginPage()));
                        //                     },
                        //                   ),
                        //                   SimpleDialogOption(
                        //                     padding: const EdgeInsets.all(20),
                        //                     child: const Text('Cancel'),
                        //                     onPressed: () {
                        //                       Navigator.of(context).pop();
                        //                     },
                        //                   )
                        //                 ],
                        //               );
                        //             });
                        //       },
                        //       icon: Icon(
                        //         Icons.more_vert_outlined,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 170),
                      child: Center(
                        child: Container(
                          //color: Colors.white,
                          height: MediaQuery.of(context).size.height * 0.75,
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
                        child: CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                'https://t3.ftcdn.net/jpg/03/46/83/96/240_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg')),
                      ),
                    ),
                    Positioned(
                      top: 250,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'First Name',
                              style: GoogleFonts.poppins(
                                  fontSize: 17, fontWeight: FontWeight.w200),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Center(
                                child: Text(
                                  'Vamshi',
                                  style: GoogleFonts.poppins(fontSize: 20),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ],
                        ),
                      ),
                    )
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
