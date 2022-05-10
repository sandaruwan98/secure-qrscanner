import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qrscanner/authentication_service.dart';
import 'package:qrscanner/components/navigationdrawer.dart';
import 'package:qrscanner/components/styles.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/components/utils.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _switchValue = true;
  bool _nameEditToggle = false;
  final TextEditingController nameController = TextEditingController();
  String name = "Name";
  String email = "Email";

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    if (user != null) {
      if (user.displayName != null) {
        name = user.displayName!;
      }
      email = user.email!;
    }
    nameController.value = TextEditingValue(text: name);

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      drawer: NavigationDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 100),
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.black12,
            ),
            SizedBox(
              height: 20,
            ),
            !_nameEditToggle
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(name,
                          textAlign: TextAlign.center,
                          style: kTxtStyleProfileName),
                      SizedBox(width: 10),
                      Material(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _nameEditToggle = true;
                            });
                          },
                          child: Icon(Icons.edit_note),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 60),
                      Expanded(
                        child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: 'Edit name',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ktextBoxColor, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ktextBoxColor, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0)),
                              ),
                            ),
                            textAlign: TextAlign.center,
                            style: kTxtStyleProfileName),
                      ),
                      SizedBox(width: 10),
                      Material(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                            border: Border.all(color: Colors.black),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _nameEditToggle = false;

                                context
                                    .read<AuthenticationService>()
                                    .updateName(nameController.text);

                                name = nameController.text;
                              });
                            },
                            child: Icon(
                              Icons.done,
                              color: Colors.green,
                              size: 46,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Material(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                            border: Border.all(color: Colors.black),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _nameEditToggle = false;
                              });
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 46,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 60),
                    ],
                  ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Signed In",
              style: kTxtStyleProfilesignin,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              email,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Join The Community Program"),
                Switch(
                    value: _switchValue,
                    onChanged: (val) {
                      setState(() {
                        _switchValue = val;
                      });
                    })
              ],
            ),
            SizedBox(
              height: 150,
            ),
          ],
        ),
      ),
      floatingActionButton: floatBtn(context),
    );
  }
}
