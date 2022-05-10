import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/authentication_service.dart';
import 'package:qrscanner/pages/communitypage.dart';
import 'package:qrscanner/pages/homepage.dart';
import 'package:qrscanner/pages/profilepage.dart';
import 'package:qrscanner/pages/redirectPage.dart';
import 'package:qrscanner/pages/signInpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // name: 'qrscanner',
    options: FirebaseOptions(
        apiKey: "AIzaSyBHdD4NQ6GszLd5hjAvVsweccse7iELTmQ",
        authDomain: "qrsacanner.firebaseapp.com",
        projectId: "qrsacanner",
        storageBucket: "qrsacanner.appspot.com",
        messagingSenderId: "167119050043",
        appId: "1:167119050043:web:1646385c7701811d5fd31e",
        measurementId: "G-XPE9M03ZL8"),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance)),
        StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges,
            initialData: null)
      ],
      child: MaterialApp(
          title: 'QR scanner',
          theme: ThemeData(
            primarySwatch: Colors.grey,
          ),
          home: AuthenticationWrapper()),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return HomePage();
      // return RedirectPage(url: "https://stackoverflow.com/");
    }

    return SignInPage();

    // return RedirectPage();
  }
}
