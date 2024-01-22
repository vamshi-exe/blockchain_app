// import 'package:flutter/material.dart';

// class UserDataProvider extends ChangeNotifier {
//   UserData? _userData;

//   UserData? get userData => _userData;

//   void setUserData(UserData newData) {
//     _userData = newData;
//     notifyListeners();
//   }
// }

// class UserData {
//   UserDataDetails? data;
//   String? message;

//   UserData({
//     this.data,
//     this.message,
//   });

//   factory UserData.fromJson(Map<String, dynamic> json) {
//     return UserData(
//       data: UserDataDetails.fromJson(json['data']),
//       message: json['message'],
//     );
//   }
// }

// class UserDataDetails {
//   // final String id;
//   // final String adhaarNumber;
//   final String firstname;
//   final String middlename;
//   final String lastname;
//   final String dob;
//   final String address1;
//   final String address2;
//   final String contactNo;
//   final String pincode;
//   final String state;
//   final String adhaarImage;
//   final String userImage;
//   final bool isVerified;
//   // final String createdAt;
//   // final int v;

//   UserDataDetails({
//     // required this.id,
//     // required this.adhaarNumber,
//     required this.firstname,
//     required this.middlename,
//     required this.lastname,
//     required this.dob,
//     required this.address1,
//     required this.address2,
//     required this.contactNo,
//     required this.pincode,
//     required this.state,
//     required this.adhaarImage,
//     required this.userImage,
//     required this.isVerified,
//     // required this.createdAt,
//     // required this.v,
//   });

//   factory UserDataDetails.fromJson(Map<String, dynamic>? json) {
//     if (json == null) {
//       // Handle the case where json is null
//       return UserDataDetails(
//         // id: '',
//         // adhaarNumber: '',
//         firstname: '',
//         middlename: '',
//         lastname: '',
//         dob: '',
//         address1: '',
//         address2: '',
//         contactNo: '',
//         pincode: '',
//         state: '',
//         adhaarImage: '',
//         userImage: '',
//         isVerified: false,
//         // createdAt: '',
//         // v: 0,
//       );
//     }

//     return UserDataDetails(
//       // id: json['_id'] ?? '',
//       // adhaarNumber: json['adhaarNumber'] ?? '',
//       firstname: json['firstname'].toString() ?? '',
//       middlename: json['middlename'].toString() ?? '',
//       lastname: json['lastname'].toString() ?? '',
//       dob: json['dob'].toString() ?? '',
//       address1: json['address_1'].toString() ?? '',
//       address2: json['address_2'].toString() ?? '',
//       contactNo: json['contactNo'].toString() ?? '',
//       pincode: json['pincode'].toString() ?? '',
//       state: json['state'].toString() ?? '',
//       adhaarImage: json['adhaar_image'].toString() ?? '',
//       userImage: json['user_image'].toString() ?? '',
//       isVerified: json['isVerified'] ?? false,
//       // createdAt: json['createdAt'] ?? '',
//       // v: json['__v'] ?? 0,
//     );
//   }
// }

import 'package:flutter/material.dart';

class UserData {
  final bool isVerified;
  final String adhaarNumber;
  final String firstname;
  final String middlename;
  final String lastname;
  final String dob;
  final String address1;
  final String address2;
  final String contactNo;
  final String pincode;
  final String adhaarImage;
  final String userImage;

  UserData({
    required this.isVerified,
    required this.adhaarNumber,
    required this.firstname,
    required this.middlename,
    required this.lastname,
    required this.dob,
    required this.address1,
    required this.address2,
    required this.contactNo,
    required this.pincode,
    required this.adhaarImage,
    required this.userImage,
  });

  // Add more fields as needed
}

class UserProvider with ChangeNotifier {
  UserData _userData = UserData(
      firstname: '',
      middlename: '',
      lastname: '',
      isVerified: false,
      adhaarNumber: '',
      dob: '',
      address1: '',
      address2: '',
      contactNo: '',
      pincode: '',
      adhaarImage: '',
      userImage: '');

  UserData get userData => _userData;

  void setUserData(UserData data) {
    _userData = data;
    notifyListeners();
  }
}
