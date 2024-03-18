// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:blockchain/utils/urllist.dart';
import 'package:http/http.dart' as http;
import 'package:blockchain/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRViewExample extends StatefulWidget {
  final String adhaarNumber;
  const QRViewExample({
    super.key,
    required this.adhaarNumber,
  });
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;

  QRViewController? controller;

  late SharedPreferences prefs;
  String? aadharNum;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  void initState() {
    super.initState();
    setState(() {
      aadharNum = widget.adhaarNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    'Data: ${result!.code} ,$aadharNum',
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
        var url = Uri.parse('${Urllist.base_url}api/verify-scan');
        var data = {"id": scanData.code, "adhaarnumber": aadharNum};
        print(json.encode(data));
        print('this adhaar is from function $aadharNum');
        try {
          var res = await http.post(url,
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json.encode(data));
          if (res.statusCode == 200) {
            print(res.body);
            final snackbar =
                const SnackBar(content: Text('Scanned Successfully!'));
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
                const SnackBar(content: Text('Verification failed! Try Again'));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            const Text('Error sending data.');
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
