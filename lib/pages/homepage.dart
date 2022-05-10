import 'package:flutter/material.dart';
import 'package:qrscanner/components/navigationdrawer.dart';
import 'package:qrscanner/components/styles.dart';
import 'package:qrscanner/components/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR scanner"),
      ),
      drawer: NavigationDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Welcome to Secure QR scanner",
            style: kTxtStyleRedirectTitle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      floatingActionButton: floatBtn(context),
    );
  }
}
