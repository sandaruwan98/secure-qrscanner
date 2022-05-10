import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:qrscanner/pages/redirectPage.dart';

final String safeBrowsingUrl =
    "https://safebrowsing.googleapis.com/v4/threatMatches:find?key=AIzaSyCatXR9IJ38MNu0AfVmJevUZ7_ns8KMSig";

final String reqbody1 =
    '{"client":{"clientId":"yourcompanyname","clientVersion":"1.5.2"},"threatInfo":{"threatTypes":["MALWARE","SOCIAL_ENGINEERING"],"platformTypes":["WINDOWS"],"threatEntryTypes":["URL"],"threatEntries":[{"url":"';
final String reqbody2 = '" }]}}';
Map<String, String> headers = Map<String, String>();

Future<http.Response> checkUrlIsSafe(String url) {
  String reqbody = reqbody1 + url + reqbody2;
  headers['Content-Type'] = 'application/json';
  return http.post(Uri.parse(safeBrowsingUrl), headers: headers, body: reqbody);
}

Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> checkCommunityRecords(
    String url) async {
  final db = FirebaseFirestore.instance;
  final comrecords =
      await db.collection("community").where('url', isEqualTo: url).get();
  return comrecords.docs;
}

Widget floatBtn(BuildContext context) => SizedBox(
      width: 70,
      height: 70,
      child: FittedBox(
          child: FloatingActionButton(
        shape: Border.all(style: BorderStyle.none),
        tooltip: "Scan QR code",
        onPressed: () async {
          // String qrcode = await FlutterBarcodeScanner.scanBarcode(
          //     "#ff6666", "Cancel", true, ScanMode.QR);

          // if (qrcode != '-1') {
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => RedirectPage(url: qrcode)));
          // }

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      RedirectPage(url: "https://stackoverflow.com/")));
        },
        child: Icon(Icons.qr_code_scanner, size: 40),
      )),
    );
