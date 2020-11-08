import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

typedef ValidatorCallback(String value);

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool password;
  final ValidatorCallback validatorCallback;
  final String title;
  final bool hasTitle;
  final bool isDate;


  AppTextField({
    @required this.controller,
    @required this.hintText,
    @required this.password,
    @required this.validatorCallback,
    this.title,
    this.hasTitle = true,
    this.isDate = false
  });
  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final format = DateFormat("dd-MM-yyyy");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.hasTitle
          ?
          Text(
              widget.title,
            style: Theme.of(context).textTheme.headline3,
          )
          :
          Container(),

          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 45.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: const Color(0xff757575).withOpacity(0.5)),
              color: Theme.of(context).accentColor,
            ),
            child: widget.isDate
              ?
            DateTimeField(
              style: GoogleFonts.montserrat(
                fontSize: 12,
                color: const Color(0x4d575960).withOpacity(0.9),
                fontWeight: FontWeight.normal,
              ),
              format: format,
              onShowPicker: (context, currentValue) async {
                widget.controller.text = currentValue.toString();
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
              },

              onChanged: (currentValue){
                widget.controller.text = currentValue.toString();
              },
            )
            :
            TextFormField(
              controller: widget.controller,
              validator: widget.validatorCallback,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                hintText: widget.hintText,
                hintStyle: GoogleFonts.openSans(
                    color: const Color(0xff757575).withOpacity(0.5)
                ),
                labelStyle: GoogleFonts.openSans(
                    color: Colors.black.withOpacity(0.7)
                ),

              ),
              obscureText: widget.password,
            )
          )
        ],
      ),
    );
  }
}