import 'dart:convert';

class UserData {
  final String id;
  final String adhaarNumber;
  final String firstname;
  final String middlename;
  final String lastname;
  final String dob;
  final String address1;
  final String address2;
  final String contactNo;
  final String pincode;
  final String state;
  final String adhaarImage;
  final String userImage;
  final bool isVerified;
  final DateTime createdAt;
  final int v;

  UserData({
    required this.id,
    required this.adhaarNumber,
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
    required this.createdAt,
    required this.v,
  });

  factory UserData.fromRawJson(String str) =>
      UserData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}
