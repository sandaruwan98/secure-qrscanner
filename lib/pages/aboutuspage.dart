import 'package:flutter/material.dart';

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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [],
      ),
      floatingActionButton: FloatingActionButton.large(
        tooltip: "Scan QR code",
        onPressed: (() {}),
        child: Icon(Icons.fact_check),
      ),
    );
  }
}
