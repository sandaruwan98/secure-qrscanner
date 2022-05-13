import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qrscanner/components/navigationdrawer.dart';
import 'package:qrscanner/components/styles.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/components/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class CommunityPage extends StatefulWidget {
  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final TextEditingController urlController = TextEditingController();

  final TextEditingController resController = TextEditingController();

  String userid = "";
  bool commMembership = false;

  @override
  initState() {
    super.initState();

    setCommMembership();
  }

  Future<void> setCommMembership() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      commMembership = prefs.getBool('communitymember') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    if (user != null) {
      userid = user.uid;
    }
    CollectionReference community =
        FirebaseFirestore.instance.collection('community');

    Future<void> addNewUrl(String userid, String url, String reason) {
      // Call the user's CollectionReference to add a new user
      return community
          .add({
            'user_id': userid,
            'url': url,
            'reason': reason,
          })
          .then((value) => print("URL Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Community"),
        ),
        floatingActionButton: floatBtn(context),
        drawer: navigationDrawer(context),
        body: Padding(
          padding: const EdgeInsets.all(44.0),
          child: SingleChildScrollView(
            child: commMembership
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                          "Help other to discover more malicious websites by adding your own websites you suspect as malicious",
                          textAlign: TextAlign.center,
                          style: kTxtStyleCommDisp),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        "Warning!",
                        textAlign: TextAlign.left,
                        style: kTxtStyleCommWarn,
                      ),
                      Text("*Please Add Malicious Websites Only",
                          style: kTxtStyleCommWarn, textAlign: TextAlign.left),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextField(
                        controller: urlController,
                        maxLines: 5,
                        decoration: kinputDecComUrl,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextField(
                        controller: resController,
                        maxLines: 5,
                        decoration: kinputDecComres,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Material(
                        color: kseconBtnColor,
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        elevation: 5.0,
                        child: MaterialButton(
                          onPressed: () async {
                            String snackMsg = '';
                            String hostname =
                                validateAndGetHost(urlController.text.trim());

                            if (hostname != 'null') {
                              await addNewUrl(
                                  userid, hostname, resController.text.trim());

                              urlController.value = TextEditingValue(text: "");
                              resController.value = TextEditingValue(text: "");
                              snackMsg =
                                  'Malicious website added to community database successfully!';
                            } else {
                              snackMsg =
                                  'URL you entered is invalid, Please enter valid URL';
                              urlController.value = TextEditingValue(text: "");
                            }

                            final snackBar = SnackBar(content: Text(snackMsg));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          // minWidth:
                          height: 42.0,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Add URL',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Please join the community program to add Urls",
                          textAlign: TextAlign.center,
                          style: kTxtStyleCommDisp),
                    ],
                  ),
          ),
        ));
  }
}
