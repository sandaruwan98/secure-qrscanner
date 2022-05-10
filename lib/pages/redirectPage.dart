import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qrscanner/components/button.dart';
import 'package:qrscanner/components/styles.dart';
import 'package:http/http.dart' as http;
import 'package:qrscanner/components/utils.dart';

class RedirectPage extends StatefulWidget {
  final String url;

  RedirectPage({Key? key, required this.url}) : super(key: key);
  @override
  State<RedirectPage> createState() => _RedirectPageState();
}

class _RedirectPageState extends State<RedirectPage> {
  RedirectState redirectState = RedirectState.loading;
  var commRecords = <String>[];
  String googleRecords = '';
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
    print(communityRecords.length);
    //  print(communityRecords[0].data().toString());
    Iterable<String> temp = communityRecords.map((doc) => doc.data()['reason']);
    print(temp.toList());
    setState(() {
      if (res.body.trim() == '{}' && communityRecords.length == 0) {
        redirectState = RedirectState.secure;
      } else {
        if (res.body.trim() == '{}') {
          googleRecords =
              'This website is not recorded as a Malicious website in official records';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("This URL Contains :", textAlign: TextAlign.left),
              SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.black)),
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Warning!",
                        textAlign: TextAlign.left,
                        style: kTxtStyleCommWarn,
                      ),
                      Text("This is Malicious a Website",
                          style: kTxtStyleCommWarn, textAlign: TextAlign.left),
                      Column(
                        children:
                            commRecords.map((reason) => Text(reason)).toList(),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );

    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: Padding(
          padding: const EdgeInsets.all(44.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("You are about to redirect into this website?",
                  textAlign: TextAlign.center, style: kTxtStyleRedirectTitle),
              SizedBox(
                height: 30.0,
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
                height: 30.0,
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
                    radius: 24,
                    minWidth: 150,
                    onTap: () {},
                  ),
                  MButton(
                    text: "Decline",
                    btnColor: Colors.red,
                    textColor: Colors.white,
                    radius: 24,
                    minWidth: 150,
                    onTap: () async {},
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
