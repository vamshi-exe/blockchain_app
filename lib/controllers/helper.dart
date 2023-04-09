// import 'dart:convert';

// import 'package:blockchain/model/userModel.dart';
// import 'package:http/http.dart' as http;

// class User {
//   List<UserModel> data = [];
//   Future<void> getUserDetails() async {
//     String url = "http://192.168.0.103:5000/api/auth/user/";
//     var res = await http.get(Uri.parse(url));
//     var jsonData = json.decode(res.body);
//     if (jsonData['status'] == "ok") {
//       jsonData["fields"].forEach((element) {
//         if (element['adhaarNumber'] != null) {
//           UserModel userModel = UserModel(
//             firstname: element['firstname'],
//             middlename: element['middlename'],
//             lastname: element['lastname'],
//             dob: element['dob'],
//             address_1: element['address_1'],
//             address_2: element['address_2'],
//             contactNo: element['contactNo'],
//             pincode: element['pincode'],
//             state: element['state'],
//             user_image: element['user_image'],
//             isVerified: element['isVerified'],
//           );
//           data.add(userModel);
//         }
//       });
//     }
//   }
// }


