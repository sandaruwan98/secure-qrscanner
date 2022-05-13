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
      drawer: navigationDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 30),
              Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 200,
                  width: 200,
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Welcome to Secure QR scanner",
                style: kTxtStyleRedirectTitle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                "Secure QR scanner helps you avoid Malicious URLs from QR codes",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 150, 147, 9)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: floatBtn(context),
    );
  }
}
