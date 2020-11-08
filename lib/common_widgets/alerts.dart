import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kyc/common_widgets/app_button.dart';
import 'package:kyc/providers/profile_provider.dart';
import 'package:kyc/screens/common/auth_textfield.dart';
import 'package:kyc/utils/validator.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertDialogs{
  static showDialog(
      BuildContext context,
      String title,
      String bodyText,
      IconData icon,
      String buttonText,
      Function buttonPressed
      ){
    Alert(
        context: context,
        title: title,
        closeIcon: Icon(Icons.add, size: 0,),
        content: Column(
          children: <Widget>[
            Icon(icon, size: 80, color: Colors.grey,),
            Text(
              bodyText,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                  fontSize: 16
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: AppSolidButton(
              text: 'Okay',
              height: 50,
              style: Theme.of(context).textTheme.headline1,
              onPressed: (){
                buttonPressed();
              },
            ),
          )
        ]).show();
  }

  static showBvn(
      BuildContext context,
      String title,
      String buttonText,
      TextEditingController bvnController,
      TextEditingController dateController,
      Function buttonPressed
      ){
    Alert(
        context: context,
        title: title,
        closeIcon: Icon(Icons.add, size: 0,),
        content: Column(
          children: <Widget>[

            AppTextField(
                controller: bvnController,
                hintText: '',
                password: false,
                validatorCallback: formValidator.singleInputValidator,
                title: 'BVN Number'
            ),

            AppTextField(
                controller: dateController,
                hintText: '',
                isDate: true,
                password: false,
                validatorCallback: formValidator.singleInputValidator,
                title: 'Date of Birth'
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: AppSolidButton(
              text: 'Confirm',
              height: 50,
              style: Theme.of(context).textTheme.subtitle1,
              onPressed: (){
                buttonPressed();
              },
            ),
          )
        ]).show();
  }

  static uploadPassport(
      BuildContext context,
      String title,
      Function buttonPressed,
      Function uploadClicked
      ){
    Alert(
        context: context,
        title: title,
        closeIcon: Icon(Icons.add, size: 0,),
        content: GestureDetector(
          onTap: (){
            uploadClicked();
          },
          child: Provider.of<ProfileProvider>(context, listen: false).profile == null
            ?
          Column(
            children: <Widget>[
              Icon(Icons.cloud_upload, size: 30,),

              Text(
                'Upload your passport',
                style: Theme.of(context).textTheme.headline3,
              )
            ],
          )
            :
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(
                    Provider.of<ProfileProvider>(context, listen: false).profile
                ),
                fit: BoxFit.cover
              )
            ),
          )
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: AppSolidButton(
              text: 'Confirm',
              height: 50,
              style: Theme.of(context).textTheme.subtitle1,
              onPressed: (){
                buttonPressed();
              },
            ),
          )
        ]).show();
  }
}