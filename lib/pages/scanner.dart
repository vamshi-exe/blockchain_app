import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:blockchain/pages/home.dart';
import 'package:blockchain/utils/colors.dart';
import 'package:blockchain/utils/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRViewExample extends StatefulWidget {
  QRViewExample({
    super.key,
  });
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;

  QRViewController? controller;

  late SharedPreferences prefs;
  String? aadharNum;
  final _prefs = SharedPreferences.getInstance();

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    aadhar();
    // print('this isssssss ${prefs.getString("aadhar_number")}');
  }

  Future<void> aadhar() async {
    prefs = await _prefs;
    aadharNum = prefs.getString("aadhar_number")!;
    // print("The String is ${prefs.getString("aadhar_number")}");
  }

  @override
  Widget build(BuildContext context) {
    Object? predata = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 5, child: _buildQrView(context)),
          FittedBox(
            fit: BoxFit.contain,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (result != null)
                  Text(
                    'Data: ${result!.code} ,${aadharNum}',
                  )
                // Navigator.pushNamed(context, '/otp');
                else
                  const Text('Scan a code'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // print('${aadharNum}');
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: blueColor,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 13,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    //Object? predata = ModalRoute.of(context)!.settings.arguments;
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      print(scanData.code);

      /// function for sending scanned data
      Future<void> scanningFun() async {
        //print(otp.text);

        // var url = Uri.parse('http://192.168.218.11:5000/api/auth/otp/verify');
        var url = Uri.parse('http://192.168.0.103:5000/api/verify-scan');
        var data = {"adhaarNumber": aadharNum, "code": scanData.code};
        print('this adhaar is from function $aadharNum');
        try {
          var res = await http.post(url,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json.encode(data));
          if (res.statusCode == 200) {
            final snackbar = SnackBar(content: Text('Verified Successfully!'));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     settings: RouteSettings(arguments: widget.predata),
            //     builder: (context) {
            //       return HomePage(
            //         predata: '',
            //       );
            //     },
            //   ),
            // );
            return jsonDecode(res.body)['success'];
          } else {
            final snackbar =
                SnackBar(content: Text('Verification failed! Try Again'));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            Text('Error sending data.');
            throw Exception('Failed to verify OTP');
          }
        } catch (err) {
          print('error was :$err');
        }
      }

      scanningFun();
      controller.pauseCamera();
      Navigator.pushNamed(context, '/home');

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomePage()),
      // );
      // scanner(scanData);
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
