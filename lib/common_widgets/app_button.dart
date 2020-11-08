import 'package:flutter/material.dart';

class AppSolidButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final double height;
  final TextStyle style;

  AppSolidButton({
    this.text,
    this.onPressed,
    this.height = 50,
    this.style
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5.0) ),
      onPressed:(){
        onPressed();
      },
      color: Theme.of(context).primaryColor,
      minWidth: MediaQuery.of(context).size.width,
      height: height,
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
