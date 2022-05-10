import 'package:flutter/material.dart';

const Color kMainColor = Color.fromARGB(181, 0, 0, 0);
const Color ktextBoxColor = Color.fromARGB(255, 17, 17, 17);
const Color kseconBtnColor = Color.fromARGB(255, 63, 63, 63);

const TextStyle kTxtStyleProfileName =
    TextStyle(fontSize: 25, fontWeight: FontWeight.bold);

const TextStyle kTxtStyleProfileEmail =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

const TextStyle kTxtStyleProfilesignin =
    TextStyle(fontSize: 17, fontStyle: FontStyle.italic);

const TextStyle kTxtStyleCommWarn = TextStyle(fontSize: 17, color: Colors.red);

const TextStyle kTxtStyleCommWarn2 =
    TextStyle(fontSize: 17, color: Colors.white);

const TextStyle kTxtStyleNotsafeCommTitle =
    TextStyle(fontSize: 19, color: Colors.black);

const TextStyle kTxtStyleNotsafeCommUser =
    TextStyle(fontSize: 15, color: Colors.grey);

const TextStyle kTxtStyleCommyellow =
    TextStyle(fontSize: 17, color: Color.fromARGB(255, 185, 182, 6));

const TextStyle kTxtStyleCommDisp = TextStyle(fontSize: 20);

const TextStyle kTxtStyleRedirectTitle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.w900);

const TextStyle kTxtStyleReidLink =
    TextStyle(fontSize: 18, color: Colors.blue, fontStyle: FontStyle.italic);

const TextStyle kTxtStyleReidLoading =
    TextStyle(fontSize: 20, fontWeight: FontWeight.w300);
const TextStyle kTxtStyleReidSafe = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w900,
    color: Color.fromARGB(255, 27, 94, 32));

const InputDecoration kinputDecComUrl = InputDecoration(
  hintText: "Add your URL",
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: ktextBoxColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: ktextBoxColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
);

const InputDecoration kinputDecComres = InputDecoration(
  hintText: "Reason",
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: ktextBoxColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: ktextBoxColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
);

enum RedirectState { loading, secure, notsecure }
