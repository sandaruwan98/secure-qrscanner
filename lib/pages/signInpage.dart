import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/authentication_service.dart';
import 'package:qrscanner/components/button.dart';
import 'package:qrscanner/components/styles.dart';
import 'package:qrscanner/pages/homepage.dart';
import 'package:qrscanner/pages/signuppage.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: 'applogo',
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 200,
                    width: 200,
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ktextBoxColor, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ktextBoxColor, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ktextBoxColor, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ktextBoxColor, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: MButton(
                    text: "Log In",
                    btnColor: kseconBtnColor,
                    textColor: Colors.white,
                    radius: 24,
                    onTap: () async {
                      //Implement login functionality.

                      String? message = await context
                          .read<AuthenticationService>()
                          .signIn(emailController.text.trim(),
                              passwordController.text.trim());
                      if (message != null && message != 'success') {
                        final snackBar = SnackBar(content: Text(message));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      // if (message == 'success') {
                      //   Navigator.pushReplacement(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => HomePage()));
                      // }
                    },
                  ),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Divider(),
                SizedBox(
                  height: 6.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text("Don't have an accunt?"),
                    ),
                    Material(
                      color: Color.fromARGB(255, 90, 90, 90),
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      elevation: 5.0,
                      child: MaterialButton(
                        onPressed: () {
                          //Implement login functionality.

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()));
                        },
                        minWidth: 150.0,
                        height: 36.0,
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
