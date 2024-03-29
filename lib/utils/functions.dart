import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:io';
import 'dart:typed_data';
import 'package:blockchain/utils/urllist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:shared_preferences/shared_preferences.dart';

// final cloudinary = CloudinaryPublic('drcymcfus', 'my-uploads', cache: false);

// Future<void> postData(
//   String adhaarNo,
//   String phoneNo,
//   String name,
//   String middlename,
//   String lastname,
//   String date,
//   String addline1,
//   String addline2,
//   // String stateValue,
//   String pincode,
//   File userimage,
//   File adhaarimage,
// ) async {
//   if (adhaarNo == "") return;

//   //

//   CloudinaryResponse adhaarResponse = await cloudinary.uploadFile(
//     CloudinaryFile.fromFile(adhaarimage.path,
//         resourceType: CloudinaryResourceType.Image),
//   );
//   // CloudinaryResponse userResponse = await cloudinary.uploadFile(
//   //   CloudinaryFile.fromFile(userimage.path,
//   //       resourceType: CloudinaryResourceType.Image),
//   // );
//   debugPrint("url is ::::::::::::::::::::::${adhaarResponse.secureUrl}");
//   // debugPrint("url is ::::::::::::::::::::::${userResponse.secureUrl}");
//   // List<CloudinaryResponse> uploadImages = await cloudinary.multiUpload(

//   // )
//   debugPrint("this is the path${adhaarimage.path}");
//   debugPrint(userimage.path);
//   var url = Uri.parse('http://192.168.112.11:5000/api/auth/register/');

//   var res = await http.post(url, body: {
//     'adhaarNumber': adhaarNo,
//     'phoneNumber': phoneNo,
//     'firstname': name,
//     'middlename': middlename,
//     'lastname': lastname,
//     'dob': date,
//     'add1': addline1,
//     'add2': addline2,
//     //'state': stateValue,
//     'pincode': pincode,
//     'adhaarImage': adhaarimage,
//     'userImage': userimage,
//   });

//   if (res.statusCode == 200) {
//     print('Data sent successfully!');
//   } else {
//     print('Error sending data.');
//   }
// }

Future ipAddress() async {
  for (var interface in await NetworkInterface.list()) {
    print(interface.addresses);
    for (var addr in interface.addresses) {
      print(
          '${addr.address} ${addr.host} ${addr.isLoopback} ${addr.type.name}');
    }
  }
}

/// we should be adding the implementait part by adding mongo db
/// etc, our own custom server

// Future<void> requestData(
//   String adhaarNumber,
// ) async {
//   print(adhaarNumber);
//   if (adhaarNumber == "") return;
//   var url = Uri.parse('http://192.168.112.11:5000/api/auth/login/');

//   var res = await http.post(url, body: {'adhaarNumber': adhaarNumber});

//   if (res.statusCode == 200) {
//     //save the data to state

//     //Navigator.pushNamed(,'/otp');
//   } else {}
// }

// write a functon to post otp and then if the res.statusCode == 200 => redirect to home else show invalid otp

/////////////////////////////////////
late SharedPreferences prefs;
String? aadharNum;
final _prefs = SharedPreferences.getInstance();

Future<void> aadhar() async {
  prefs = await _prefs;
  aadharNum = prefs.getString("aadhar_number")!;
  //print("The String is ${prefs.getString("aadhar_number")}");
}

Future<void> details(String adhaarNumber) async {
  var url = Uri.parse('${Urllist.base_url}api/auth/user');
  var postdata = {
    "adhaarNumber": aadharNum,
  };

  try {
    var res = await http.post(url, body: json.encode(postdata));
    print('this is data $postdata');
    print('this is res $res');
    if (res.statusCode == 200) {
      //print('this is response object ${json.decode(res.body)}');

      //dynamic ud = json.decode(res.body.toString());
      var resobj = jsonDecode(res.body)['user'];
      print('user ======> ${jsonDecode(res.body)['user']}');
      dynamic user = res.body;
      print('${json.decode(user.body)}');
      // print('qwrtyuiop ${user.user}');
      // setState(() {
      //   _responseText = jsonDecode(res.body)[user];
      // });

      return resobj;
    } else {
      throw Exception('Failed to verify OTP');
    }
  } catch (err) {
    print('error was :$err');
  }
}
