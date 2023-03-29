import 'package:flutter/material.dart';

const blueColor = Color.fromARGB(255, 11, 65, 109);
// Future<void> postData() async {
//     print(selectUserImage());
//     final dio = Dio();
//     final formData = FormData.fromMap({
//       'adhaarNumber': adhaarNo.text,
//       'phoneNumber': phoneNo.text,
//       'firstname': name.text,
//       'middlename': middlename.text,
//       'lastname': lastname.text,
//       'dob': date.text,
//       'add1': addline1.text,
//       'add2': addline2.text,
//       'pincode': pincode.text,
//       'adhaarImage': await MultipartFile.fromFile(''),
//       'userImage': await MultipartFile.fromFile(''),
//     });

//     Response response = await Dio()
//         .post('http://192.168.112.11:5000/api/auth/register/', data: formData);
//     print(response.data);
//   }