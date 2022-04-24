import 'package:flutter/material.dart';
import 'package:qrscanner/components/navigationdrawer.dart';

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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text("signed in"),
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
        tooltip: "Scan QR code",
        onPressed: (() {}),
        child: Icon(Icons.fact_check),
      ),
    );
  }
}
