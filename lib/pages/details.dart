import 'dart:convert';
import 'dart:io';

import 'package:blockchain/pages/login.dart';
import 'package:blockchain/utils/colors.dart';
import 'package:blockchain/utils/utils.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../utils/functions.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  File? _image;
  PickedFile? _pickedFile;
  final _picker = ImagePicker();
  Future<void> _pickImage() async {
    _pickedFile = await _picker.getImage(source: ImageSource.camera);
    if (_pickedFile != null) {
      setState(() {
        _image = File(_pickedFile!.path);
      });
    }
  }

  File? adhaarImage;
  PickedFile? _pickedAdhaarFile;
  final _adhaarPicker = ImagePicker();
  Future<void> _pickAdhaarImage() async {
    _pickedAdhaarFile =
        (await _adhaarPicker.getImage(source: ImageSource.camera));
    if (_pickedAdhaarFile != null) {
      setState(() {
        adhaarImage = File(_pickedAdhaarFile!.path);
      });
    }
  }

  // Future<void> uploadImages() async {
  //   var stream = http.ByteStream(_image!.openRead());
  //   stream.cast();
  //   var length = await _image!.length();
  //   var uri = Uri.parse('http://192.168.0.106:5000/api/auth/register');
  //   var req = http.MultipartRequest('POST', uri);
  //   var multipart = http.MultipartFile('_image', stream, length);
  //   req.files.add(multipart);
  //   var res = await req.send();
  //   if (res.statusCode == 200) {
  //     print('images uploaded');
  //   } else {
  //     print('Failed');
  //   }
  // }
  // Uint8List? userimage;
  // Uint8List? adhaarimage;
  // selectUserImage() async {
  //   Uint8List im = await pickImage(ImageSource.camera);
  //   setState(() {
  //     userimage = im;
  //   });
  // }
  // selectAdhaarImage() async {
  //   Uint8List im = await pickImage(ImageSource.camera);
  //   setState(() {
  //     adhaarimage = im;
  //   });
  // }

  String countryValue = "";
  String? stateValue = "";

  final TextEditingController adhaarNo = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController middlename = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController addline1 = TextEditingController();
  final TextEditingController addline2 = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  bool _isLoading = false;
  //@override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   adhaarNo.dispose();
  //   phoneNo.dispose();
  //   name.dispose();
  //   middlename.dispose();
  //   lastname.dispose();
  //   date.dispose();
  //   addline1.dispose();
  //   addline2.dispose();
  //   pincode.dispose();
  // }

  final cloudinary = CloudinaryPublic('drcymcfus', 'my-uploads', cache: false);

  Future<void> postData(
    String adhaarNo,
    String phoneNo,
    String name,
    String middlename,
    String lastname,
    String date,
    String addline1,
    String addline2,
    // String stateValue,
    String pincode,
    File adhaarimage,
    File userimage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    if (adhaarNo == "") return;

    //

    CloudinaryResponse adhaarResponse = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(adhaarimage.path,
          resourceType: CloudinaryResourceType.Image),
    );
    CloudinaryResponse userImageRes = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(userimage.path,
          resourceType: CloudinaryResourceType.Image),
    );

    debugPrint("uploaded url == > ${adhaarResponse.secureUrl}");
    debugPrint("uploaded url == > ${userImageRes.secureUrl}");

    var url = Uri.parse('http://192.168.0.106:5000/api/auth/register/');
    final headers = {'Content-Type': 'application/json'};

    var data = {
      "adhaarNumber": adhaarNo,
      "phoneNumber": phoneNo,
      "firstname": name,
      "middlename": middlename,
      "lastname": lastname,
      "dob": date,
      "add1": addline1,
      "add2": addline2,
      "state": stateValue,
      "pincode": pincode,
      "adhaarImage": adhaarResponse.secureUrl,
      'userImage': userImageRes.secureUrl,
    };

    print(data);
    setState(() {
      _isLoading = false;
    });

    try {
      var res = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(data));
      print(res);
      // setState(() {

      // });
      if (res.statusCode == 200) {
        final snackbar = SnackBar(content: Text('Upload successful!'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
        print('Data sent successfully!');
      } else {
        final snackbar = SnackBar(content: Text('Upload failed! Try Again'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        Text('Error sending data.');
        print('Error sending data.');
      }
    } catch (err) {
      final snackbar = SnackBar(content: Text('Upload failed!Try Again'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      print('error was :$err');
    }
  }

  bool validateAdhaarNumber = false;
  bool validatePhoneNumber = false;
  bool validatePincodeNumber = false;

  bool isAdhaarNumberValid(String number) {
    // Insert your number validation logic here
    return number.length == 12;
  }

  bool isPhoneNumberValid(String number) {
    // Insert your number validation logic here
    return number.length == 10;
  }

  bool isPincodeValid(String number) {
    // Insert your number validation logic here
    return number.length == 6;
  }

  void navigateToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  void validateInputs() {
    setState(() {
      validateAdhaarNumber = !isAdhaarNumberValid(adhaarNo.text);
      validatePhoneNumber = !isPhoneNumberValid(phoneNo.text);
      validatePincodeNumber = !isPincodeValid(pincode.text);
    });
    if (!validateAdhaarNumber &&
        !validatePhoneNumber &&
        !validatePincodeNumber) {
      // navigateToNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'Enter your existing Adhaar Info',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 45),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    // width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    child: Form(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: adhaarNo,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(12),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          // hintText: 'Name',
                          labelText: "Adhaar Number",
                          errorText: validateAdhaarNumber
                              ? 'Please enter a 12 numbers'
                              : null,
                          //labelStyle: ,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 23, 76, 119),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 23, 76, 119),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    // width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    child: Form(
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phoneNo,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          // hintText: 'Name',
                          labelText: "Mobile Number",
                          errorText: validateAdhaarNumber
                              ? 'Please enter 10 numbers'
                              : null,
                          //labelStyle: ,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 23, 76, 119),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 23, 76, 119),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        width: MediaQuery.of(context).size.width * 0.5,
                        // height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                        child: Form(
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            controller: name,
                            decoration: InputDecoration(
                              // hintText: 'Name',
                              labelText: "Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 23, 76, 119),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 23, 76, 119),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        width: MediaQuery.of(context).size.width * 0.5,
                        // height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                        child: Form(
                          child: TextFormField(
                            controller: middlename,
                            decoration: InputDecoration(
                              // hintText: 'Name',
                              labelText: "Middle Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 23, 76, 119),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 23, 76, 119),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        width: MediaQuery.of(context).size.width * 0.5,
                        // height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                        child: Form(
                          child: TextFormField(
                            controller: lastname,
                            decoration: InputDecoration(
                              // hintText: 'Name',
                              labelText: "Last Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 23, 76, 119),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 23, 76, 119),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        width: MediaQuery.of(context).size.width * 0.5,
                        // height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                        child: Form(
                          child: TextField(
                            controller: date,
                            decoration: InputDecoration(
                              // hintText: 'Name',
                              labelText: "D-O-B",
                              suffixIcon:
                                  const Icon(Icons.calendar_today_rounded),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 23, 76, 119),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 23, 76, 119),
                                ),
                              ),
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1901),
                                  lastDate: DateTime.now());
                              if (pickedDate != null) {
                                setState(() {
                                  // _date.text = DateFormat('yyyy-MM-dd').format
                                  date.text = DateFormat('dd-MM-yyyy')
                                      .format(pickedDate);
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    // width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    child: Form(
                      child: TextFormField(
                        controller: addline1,
                        decoration: InputDecoration(
                          // hintText: 'Name',
                          labelText: "Address line 1",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 23, 76, 119),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 23, 76, 119),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    // width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    child: Form(
                      child: TextFormField(
                        controller: addline2,
                        decoration: InputDecoration(
                          // hintText: 'Name',
                          labelText: "Address line 2",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 23, 76, 119),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 23, 76, 119),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    //width: MediaQuery.of(context).size.width * 0.5,
                    // height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    child: CSCPicker(
                      disableCountry: true,
                      defaultCountry: CscCountry.India,
                      onStateChanged: (state) {
                        setState(() {
                          stateValue = state;
                        });
                      },
                      onCountryChanged: (countryValue) {},
                      onCityChanged: (city) {},
                      showCities: false,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    //width: MediaQuery.of(context).size.width * 0.5,
                    // height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    child: Form(
                      child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(6),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: pincode,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          // hintText: 'Name',
                          labelText: "Pincode",
                          errorText: validateAdhaarNumber
                              ? 'Please enter a 12 numbers'
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 23, 76, 119),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 23, 76, 119),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Column(
                      children: [
                        // const Text(
                        //   'Enter your existing Adhaar Info',
                        //   style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                        // ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _pickedAdhaarFile != null
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 45),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.20,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.65,
                                          child: Image.file(File(
                                            _pickedAdhaarFile!.path,
                                          )

                                              //fit: BoxFit.,
                                              ),
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () => _pickImage(),
                                          child: const Text(
                                            'Retake',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 11, 65, 109)),
                                          ))
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(top: 45),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.20,
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      decoration: BoxDecoration(
                                          image: const DecorationImage(
                                            image: NetworkImage(
                                                'https://upload.wikimedia.org/wikipedia/en/thumb/c/cf/Aadhaar_Logo.svg/375px-Aadhaar_Logo.svg.png'),
                                          ),
                                          border: Border.all(
                                              width: 2,
                                              color: const Color.fromARGB(
                                                  255, 23, 76, 119)),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: IconButton(
                                          onPressed: () => _pickAdhaarImage(),
                                          icon: const Icon(
                                            Icons.upload,
                                            size: 50,
                                          )),
                                    ),
                                  ),
                            const Text('Upload your Adhaar Card')
                          ],
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Column(
                          children: [
                            _pickedFile != null
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.20,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.65,
                                        child:
                                            Image.file(File(_pickedFile!.path)),
                                      ),
                                      TextButton(
                                        onPressed: () => _pickImage(),
                                        child: const Text(
                                          'Retake',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 11, 65, 109)),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.20,
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    decoration: BoxDecoration(
                                        image: const DecorationImage(
                                            image: NetworkImage(
                                              'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg',
                                            ),
                                            fit: BoxFit.cover),
                                        border: Border.all(
                                            width: 2,
                                            color: const Color.fromARGB(
                                                255, 23, 76, 119)),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: IconButton(
                                      onPressed: () => _pickImage(),
                                      icon: const Icon(
                                        Icons.upload,
                                        size: 50,
                                      ),
                                    ),
                                  ),
                            const Text('Upload your Photo')
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      //validateInputs();
                      postData(
                          adhaarNo.text,
                          phoneNo.text,
                          name.text,
                          middlename.text,
                          lastname.text,
                          date.text,
                          addline1.text,
                          addline2.text,
                          //stateValue,
                          pincode.text,
                          adhaarImage!,
                          _image!);

                      print(stateValue);

                      //uploadImages();
                      //Navigator.pushNamed(context, '/');
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 60,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          color: blueColor),
                      child: Center(
                          child: _isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.blue,
                                  ),
                                )
                              : Text(
                                  'NEXT',
                                  style: GoogleFonts.poppins(
                                      fontSize: 20, color: Colors.white),
                                )),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
