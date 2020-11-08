import 'package:flutter/material.dart';
import 'package:kyc/common_widgets/alerts.dart';
import 'package:kyc/providers/profile_provider.dart';
import 'package:kyc/screens/upload_passport.dart';
import 'package:provider/provider.dart';

class ProfileOptions extends StatelessWidget {
  final IconData icon;
  final String levelText;
  final String subText;
  final Function onPressed;
  final int position;
  final TextEditingController controller;
  final TextEditingController dobController;
  final Function alertButtonPressed;
  final Function uploadPressed;

  ProfileOptions({
   @required this.icon,
   @required this.levelText,
   @required this.subText,
   this.onPressed,
   this.position,
   this.controller,
   this.dobController,
   this.alertButtonPressed,
   this.uploadPressed
});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(position == 0){
          if(Provider.of<ProfileProvider>(context, listen: false).userValidated){
            AlertDialogs.showBvn(
                context,
                'BVN Verification',
                'Confirm',
                controller,
                dobController ,
                alertButtonPressed
            );
          }else{
            AlertDialogs.showDialog(
                context,
                'Validation Required',
                'Please Validate Your Email before proceeding',
                Icons.close,
                'Okay',
                    (){
                  Navigator.pop(context);

                }
            );
          }
        }else{
          if(Provider.of<ProfileProvider>(context, listen: false).userValidated == true){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UploadPassportScreen()));

          }else{
            AlertDialogs.showDialog(
                context,
                'Validation Required',
                'Please Validate Your Email before proceeding',
                Icons.close,
                'Okay',
                    (){
                  Navigator.pop(context);

                }
            );
          }
        }
      },
      child: Container(
        color: Colors.grey.withOpacity(0.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30),

            Text(
              levelText,
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              subText,
              style: Theme.of(context).textTheme.headline3,
            )
          ],
        ),
      ),
    );
  }
}
