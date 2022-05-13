import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:qrscanner/components/styles.dart';
import 'package:qrscanner/pages/redirectPage.dart';

final String safeBrowsingUrl =
    "https://safebrowsing.googleapis.com/v4/threatMatches:find?key=AIzaSyCatXR9IJ38MNu0AfVmJevUZ7_ns8KMSig";

final String reqbody1 =
    '{"client":{"clientId":"qrscannerapp","clientVersion":"1.5.2"},"threatInfo":{"threatTypes": ["MALWARE", "SOCIAL_ENGINEERING","POTENTIALLY_HARMFUL_APPLICATION","UNWANTED_SOFTWARE"],"platformTypes":["ANY_PLATFORM"],"threatEntryTypes":["URL"],"threatEntries":[{"url":"';
final String reqbody2 = '" }]}}';
Map<String, String> headers = Map<String, String>();

Future<http.Response> checkUrlIsSafe(String url) {
  String reqbody = reqbody1 + url + reqbody2;
  headers['Content-Type'] = 'application/json';
  return http.post(Uri.parse(safeBrowsingUrl), headers: headers, body: reqbody);
}

Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> checkCommunityRecords(
    String url) async {
  String hostname = validateAndGetHost(url);
  final db = FirebaseFirestore.instance;
  final comrecords =
      await db.collection("community").where('url', isEqualTo: hostname).get();
  return comrecords.docs;
}

Future<void> showMyDialog(BuildContext context) async {}

Widget floatBtn(BuildContext context) => SizedBox(
      width: 70,
      height: 70,
      child: FittedBox(
          child: FloatingActionButton(
        backgroundColor: kseconBtnColor,
        foregroundColor: Colors.white,
        shape: Border.all(style: BorderStyle.none),
        tooltip: "Scan QR code",
        onPressed: () async {
          String qrcode = await FlutterBarcodeScanner.scanBarcode(
              "#ff6666", "Cancel", true, ScanMode.QR);
          print(qrcode);
          if (qrcode != '-1') {
            String hostname = validateAndGetHost(qrcode);
            if (hostname != 'null') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RedirectPage(url: qrcode)));
            } else {
              // Show a msgbox with qrcode
              return showDialog<void>(
                context: context,
                barrierDismissible: true, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('QRcode does not contain an URL'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text(
                            'This is the content in QR code',
                            style: TextStyle(color: Colors.brown),
                          ),
                          SizedBox(height: 10),
                          Text(qrcode),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Copy content'),
                        onPressed: () async {
                          await Clipboard.setData(ClipboardData(text: qrcode));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Copied to clipboard'),
                          ));
                          // Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          }

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             RedirectPage(url: "https://stackoverflow.com/")));
        },
        child: Icon(Icons.qr_code_scanner, size: 40),
      )),
    );

String validateAndGetHost(String url) {
  Uri? _url = Uri.tryParse(url);
  if (_url != null) {
    if (_url.host == "") {
      return 'null';
    }
    return _url.host;
  } else {
    return 'null';
  }
}
