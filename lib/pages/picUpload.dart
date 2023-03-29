// import 'dart:io';
// import 'package:http/http.dart' as http;

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:snippet_coder_utils/FormHelper.dart';
// import 'package:snippet_coder_utils/hex_color.dart';

// import '../utils/functions.dart';

// class PicUpload extends StatefulWidget {
//   const PicUpload({super.key});

//   @override
//   State<PicUpload> createState() => _PicUploadState();
// }

// class _PicUploadState extends State<PicUpload> {
//   File? _image;
//   PickedFile? _pickedFile;
//   final _picker = ImagePicker();
//   Future<void> _pickImage() async {
//     _pickedFile = await _picker.getImage(source: ImageSource.camera);
//     if (_pickedFile != null) {
//       setState(() {
//         _image = File(_pickedFile!.path);
//       });
//     }
//   }

//   File? _adhaarImage;
//   PickedFile? _pickedAdhaarFile;
//   final _adhaarPicker = ImagePicker();
//   Future<void> _pickAdhaarImage() async {
//     _pickedAdhaarFile =
//         (await _adhaarPicker.getImage(source: ImageSource.camera));
//     if (_pickedAdhaarFile != null) {
//       setState(() {
//         _adhaarImage = File(_pickedAdhaarFile!.path);
//       });
//     }
//   }

//   // Future<void> sendImageToServer(File imageFile) async {
//   //   var req = http.MultipartRequest(
//   //       'POST', Uri.parse('http://192.168.0.106:5000/api/auth/register'));

//   //   var image = await http.MultipartFile.fromPath('image', imageFile.path);

//   //   // Send the request
//   //   var response = await req.send();

//   //   // Check the status code of the response
//   //   if (response.statusCode == 200) {
//   //     // Image was successfully uploaded
//   //     print('Image uploaded successfully!');
//   //   } else {
//   //     // Error uploading image
//   //     throw Exception('Error uploading image: ${response.statusCode}');
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Column(
//           children: [
//             // const Text(
//             //   'Enter your existing Adhaar Info',
//             //   style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
//             // ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 _pickedAdhaarFile != null
//                     ? Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 45),
//                             child: Container(
//                               height: MediaQuery.of(context).size.height * 0.20,
//                               width: MediaQuery.of(context).size.width * 0.65,
//                               child: Image.file(
//                                 File(_pickedAdhaarFile!.path),
//                                 //fit: BoxFit.,
//                               ),
//                             ),
//                           ),
//                           TextButton(
//                               onPressed: () => _pickAdhaarImage(),
//                               child: const Text(
//                                 'Retake',
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     color: Color.fromARGB(255, 11, 65, 109)),
//                               ))
//                         ],
//                       )
//                     : Padding(
//                         padding: const EdgeInsets.only(top: 45),
//                         child: Container(
//                           height: MediaQuery.of(context).size.height * 0.20,
//                           width: MediaQuery.of(context).size.width * 0.6,
//                           decoration: BoxDecoration(
//                               image: const DecorationImage(
//                                 image: NetworkImage(
//                                     'https://upload.wikimedia.org/wikipedia/en/thumb/c/cf/Aadhaar_Logo.svg/375px-Aadhaar_Logo.svg.png'),
//                               ),
//                               border: Border.all(
//                                   width: 2,
//                                   color:
//                                       const Color.fromARGB(255, 23, 76, 119)),
//                               borderRadius: BorderRadius.circular(15)),
//                           child: IconButton(
//                               onPressed: () => _pickAdhaarImage(),
//                               icon: const Icon(
//                                 Icons.upload,
//                                 size: 50,
//                               )),
//                         ),
//                       ),
//                 const Text('Upload your Adhaar Card')
//               ],
//             ),
//             const SizedBox(
//               height: 35,
//             ),
//             Column(
//               children: [
//                 _pickedFile != null
//                     ? Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Container(
//                             height: MediaQuery.of(context).size.height * 0.20,
//                             width: MediaQuery.of(context).size.width * 0.65,
//                             child: Image.file(
//                               File(_pickedFile!.path),
//                               //fit: BoxFit.cover,
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () => _pickImage(),
//                             child: const Text(
//                               'Retake',
//                               style: TextStyle(
//                                   fontSize: 20,
//                                   color: Color.fromARGB(255, 11, 65, 109)),
//                             ),
//                           ),
//                         ],
//                       )
//                     : Container(
//                         height: MediaQuery.of(context).size.height * 0.20,
//                         width: MediaQuery.of(context).size.width * 0.6,
//                         decoration: BoxDecoration(
//                             image: const DecorationImage(
//                                 image: NetworkImage(
//                                   'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg',
//                                 ),
//                                 fit: BoxFit.cover),
//                             border: Border.all(
//                                 width: 2,
//                                 color: const Color.fromARGB(255, 23, 76, 119)),
//                             borderRadius: BorderRadius.circular(15)),
//                         child: IconButton(
//                           onPressed: () => _pickImage(),
//                           icon: const Icon(
//                             Icons.upload,
//                             size: 50,
//                           ),
//                         ),
//                       ),
//                 const Text('Upload your Photo')
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
