// class UserModel {
//   late String? adhaarNumber;
//   late String? firstname;
//   late String? middlename;
//   late String? lastname;
//   late String? dob;
//   late String? address_1;
//   late String? address_2;
//   late String? contactNo;
//   late String? pincode;
//   late String? state;
//   late String? user_image;
//   late bool? isVerified;

//   UserModel(
//       {this.adhaarNumber,
//       this.firstname,
//       this.middlename,
//       this.lastname,
//       this.dob,
//       this.address_1,
//       this.address_2,
//       this.contactNo,
//       this.pincode,
//       this.state,
//       this.user_image,
//       this.isVerified});

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       adhaarNumber: json['adhaarNumber'],
//       firstname: json['firstname'],
//       middlename: json['middlename'],
//       lastname: json['lastname'],
//       dob: json['dob'],
//       address_1: json['address_1'],
//       address_2: json['address_2'],
//       contactNo: json['contactNo'],
//       pincode: json['pincode'],
//       state: json['state'],
//       user_image: json['user_image'],
//       isVerified: json['isVerified'],
//     );
//   }
// }

import 'dart:convert';

// final userModel = userModelFromJson(jsonString);
UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.status,
    required this.user,
  });

  int status;
  User user;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "user": user.toJson(),
      };
}

class User {
  User({
    this.id,
    this.adhaarNumber,
    required this.firstname,
    required this.middlename,
    required this.lastname,
    required this.dob,
    required this.address1,
    required this.address2,
    required this.contactNo,
    required this.pincode,
    required this.state,
    required this.adhaarImage,
    required this.userImage,
    required this.isVerified,
    this.createdAt,
    this.v,
  });

  String? id;
  String? adhaarNumber;
  String firstname;
  String middlename;
  String lastname;
  String dob;
  String address1;
  String address2;
  String contactNo;
  String pincode;
  String state;
  String adhaarImage;
  String userImage;
  bool isVerified;
  DateTime? createdAt;
  int? v;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        adhaarNumber: json["adhaarNumber"],
        firstname: json["firstname"],
        middlename: json["middlename"],
        lastname: json["lastname"],
        dob: json["dob"],
        address1: json["address_1"],
        address2: json["address_2"],
        contactNo: json["contactNo"],
        pincode: json["pincode"],
        state: json["state"],
        adhaarImage: json["adhaar_image"],
        userImage: json["user_image"],
        isVerified: json["isVerified"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "adhaarNumber": adhaarNumber,
        "firstname": firstname,
        "middlename": middlename,
        "lastname": lastname,
        "dob": dob,
        "address_1": address1,
        "address_2": address2,
        "contactNo": contactNo,
        "pincode": pincode,
        "state": state,
        "adhaar_image": adhaarImage,
        "user_image": userImage,
        "isVerified": isVerified,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}
