import 'dart:convert';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:qrscanner/components/button.dart';
import 'package:qrscanner/components/styles.dart';
import 'package:http/http.dart' as http;
import 'package:qrscanner/components/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class RedirectPage extends StatefulWidget {
  final String url;

  RedirectPage({Key? key, required this.url}) : super(key: key);
  @override
  State<RedirectPage> createState() => _RedirectPageState();
}

class _RedirectPageState extends State<RedirectPage> {
  RedirectState redirectState = RedirectState.loading;
  var commRecords = <String>[];
  var googleRecords = <String>[];

  @override
  initState() {
    super.initState();
    redirectState = RedirectState.loading;
    searchMalwares();
  }

  Future<void> searchMalwares() async {
    http.Response res = await checkUrlIsSafe(widget.url);
    print(res.body);
    List<QueryDocumentSnapshot<Map<String, dynamic>>> communityRecords =
        await checkCommunityRecords(widget.url);
    // print(communityRecords.length);
    //  print(communityRecords[0].data().toString());
    Iterable<String> temp = communityRecords.map((doc) => doc.data()['reason']);
    print(temp.toList());
    setState(() {
      if (res.body.trim() == '{}' && communityRecords.length == 0) {
        redirectState = RedirectState.secure;
      } else {
        if (res.body.trim() != '{}') {
          print(res.body);
          var jsondata = jsonDecode(res.body);
          List<dynamic> threatArray = jsondata['matches'];
          Iterable<String> threatArrayMapped =
              threatArray.map((e) => e['threatType']);
          print(threatArrayMapped.toList());

          googleRecords = threatArrayMapped.toList();
        }

        redirectState = RedirectState.notsecure;
        commRecords = temp.toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget buildLoading(BuildContext context) => Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  "Please wait, Checking for malicious record for this website",
                  textAlign: TextAlign.center,
                  style: kTxtStyleReidLoading),
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator()
            ],
          ),
        );
    Widget buildSafe(BuildContext context) => Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                  "This website is not recorded as a malicious website, You are good to go !!",
                  textAlign: TextAlign.center,
                  style: kTxtStyleReidSafe),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        );
    Widget buildNonSafe(BuildContext context) => Expanded(
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Text("This URL Contains :", textAlign: TextAlign.left),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.black)),
                  // height: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Wrap(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Warning!",
                          textAlign: TextAlign.left,
                          style: kTxtStyleCommWarntitle,
                        ),
                        SizedBox(height: 10),
                        googleRecords.length == 0
                            ? Text(
                                "This website is not recorded as a Malicious website in official records but there are malicious records added by our Community members",
                                style: kTxtStyleCommyellow,
                                textAlign: TextAlign.left)
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("This is Malicious a Website",
                                      style: kTxtStyleCommWarntitle1,
                                      textAlign: TextAlign.left),
                                  SizedBox(height: 10),
                                  Text("This website is marked as ",
                                      style: kTxtStyleCommbb,
                                      textAlign: TextAlign.left),
                                  Wrap(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: googleRecords
                                        .map(
                                          (reason) => Container(
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 105, 32, 27),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(reason,
                                                    style: kTxtStyleCommWarn3,
                                                    overflow: TextOverflow.fade,
                                                    textAlign: TextAlign.left),
                                              )),
                                        )
                                        .toList(),
                                  )
                                ],
                              ),
                        Divider(),
                        Text("Records from Community",
                            textAlign: TextAlign.left,
                            style: kTxtStyleNotsafeCommTitle),
                        SizedBox(height: 25),
                        commRecords.length != 0
                            ? Wrap(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: commRecords
                                    .map(
                                      (reason) => Container(
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 218, 69, 58),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(reason,
                                                style: kTxtStyleCommWarn2,
                                                overflow: TextOverflow.fade,
                                                textAlign: TextAlign.left),
                                          )),
                                    )
                                    .toList(),
                              )
                            : Text("There's no records")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("You are about to redirect into this website?",
                  textAlign: TextAlign.center, style: kTxtStyleRedirectTitle),
              SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 224, 224, 224),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  // border: Border.all(color: Colors.black)
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(widget.url,
                      style: kTxtStyleReidLink, textAlign: TextAlign.center),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),

              AnyLinkPreview(
                link: widget.url,
                displayDirection: uiDirection.uiDirectionHorizontal,
                cache: Duration(hours: 1),
                backgroundColor: Colors.grey[300],
                errorWidget: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 224, 224, 224),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // border: Border.all(color: Colors.black)
                  ),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline),
                      SizedBox(width: 5),
                      Text('Failed load preview of the URL'),
                    ],
                  ),
                ),
                // errorImage: _errorImage,
              ),
              // MButton(
              //   text: "Preview WebSite",
              //   btnColor: Color.fromARGB(255, 51, 50, 49),
              //   textColor: Colors.white,
              //   radius: 10,
              //   // minWidth: 150,
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
              // ),
              SizedBox(
                height: 15.0,
              ),
              redirectState == RedirectState.loading
                  ? buildLoading(context)
                  : redirectState == RedirectState.secure
                      ? buildSafe(context)
                      : buildNonSafe(context),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MButton(
                    text: "Accept",
                    btnColor: Colors.green,
                    textColor: Colors.white,
                    radius: 10,
                    minWidth: 150,
                    onTap: () async {
                      final Uri _url = Uri.parse(widget.url);
                      if (await canLaunchUrl(_url)) {
                        await launchUrl(_url,
                            mode: LaunchMode.externalApplication);
                      } else {
                        throw 'Could not launch $_url';
                      }
                    },
                  ),
                  MButton(
                    text: "Decline",
                    btnColor: Colors.red,
                    textColor: Colors.white,
                    radius: 10,
                    minWidth: 150,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
