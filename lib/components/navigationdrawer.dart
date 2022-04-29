import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/components/styles.dart';
import 'package:qrscanner/pages/aboutuspage.dart';
import 'package:qrscanner/pages/communitypage.dart';
import 'package:qrscanner/pages/homepage.dart';
import 'package:qrscanner/pages/profilepage.dart';

import '../authentication_service.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildHeader(BuildContext context) => Container(
          color: kMainColor,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  "QR Scanner",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        );
    Widget buildMenus(BuildContext context) => Column(
          children: [
            ListTile(
              leading: Icon(Icons.home_outlined),
              title: Text("Home"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.fact_check),
              title: Text("Community"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CommunityPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.face),
              title: Text("Profile"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.api),
              title: Text("About Us"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Sign Out"),
              onTap: () {
                context.read<AuthenticationService>().signOut();
              },
            ),
          ],
        );

    return Drawer(
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeader(context),
          buildMenus(context),
        ],
      )),
    );
  }
}
