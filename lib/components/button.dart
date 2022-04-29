import 'package:flutter/material.dart';

class MButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? btnColor;
  final double? fontSize;
  final double? minWidth;
  final double radius;
  final Function()? onTap;

  const MButton({
    Key? key,
    required this.text,
    this.textColor,
    this.btnColor,
    this.fontSize,
    required this.radius,
    this.onTap,
    this.minWidth,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: btnColor,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      elevation: 5.0,
      child: MaterialButton(
        onPressed: onTap,
        minWidth: minWidth,
        height: 42.0,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
