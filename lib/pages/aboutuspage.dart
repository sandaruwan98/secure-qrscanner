import 'package:flutter/material.dart';
import 'package:qrscanner/components/styles.dart';
import 'package:qrscanner/components/utils.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 30),
          Hero(
            tag: 'logo',
            child: Image.asset(
              'assets/images/logo.png',
              height: 150,
              width: 150,
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Created By",
            style: kTxtStyleRedirectTitle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            "Menura Maneth Jayasekara",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 150, 147, 9)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      floatingActionButton: floatBtn(context),
    );
  }
}
