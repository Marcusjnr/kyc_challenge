import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kyc/common_widgets/app_button.dart';
import 'package:kyc/mixins/level_upgrade/level_upgrade_helper.dart';
import 'package:kyc/models/level_upgrade/level_upgrade_request.dart';
import 'package:kyc/providers/app_provider.dart';
import 'package:kyc/providers/profile_provider.dart';
import 'package:kyc/storage/shared_preferences_helper.dart';
import 'package:provider/provider.dart';

class UploadPassportScreen extends StatelessWidget with LevelUpgradeHelper{
  File imagePicked;
  Uint8List _image;
  Future<File> imageFile;

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, ProfileProvider profileProvider, Widget child){
          return Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(18.0),
              child: Column(
                children: [
                  SizedBox(height: 50),

                  GestureDetector(
                    onTap: (){
                      _pickImage(profileProvider);
                    },
                    child: Provider.of<ProfileProvider>(context, listen: false).profile == null
                    ?
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: Column(
                        children: [
                          Icon(Icons.cloud_upload, size: 30,),

                          Text(
                            'Upload your passport',
                            style: Theme.of(context).textTheme.headline3,
                          )
                        ],
                      ),
                    )
                    :
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
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

                  SizedBox(height: 50,),

                  profileProvider.uploadingPassportLoading
                  ?
                  Container(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),),
                  )
                  :
                  AppSolidButton(
                    text: 'Upload',
                    style: Theme.of(context).textTheme.subtitle1,
                    onPressed: (){

                      profileProvider.updatePassportLoading(true);
                      uploadStatusImage(context);
                    },
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  _pickImage(ProfileProvider profileProvider) async {
    imagePicked = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(imagePicked != null){
      _image = imagePicked.readAsBytesSync();

      if (imagePicked.path
          .substring(imagePicked.path.lastIndexOf('.'))
          .toLowerCase()
          .contains('jpg') ||
          imagePicked.path
              .substring(imagePicked.path.lastIndexOf('.'))
              .toLowerCase()
              .contains('png') ||
          imagePicked.path
              .substring(imagePicked.path.lastIndexOf('.'))
              .toLowerCase()
              .contains('jpeg')){
        profileProvider.updateProfilePic(_image);
      }
    }

  }

  void uploadStatusImage(BuildContext context) async {

    await Firebase.initializeApp();
    String email = await SharedHelper.getUserDetailsSpecific('email', context);
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child("images");
    var timeKey = DateTime.now();
    firebase_storage.UploadTask uploadTask = ref.child('${timeKey.toString()}.jpg').putFile(imagePicked);
    uploadTask.whenComplete(() => {

      doLevelUpgrade(
          Provider.of<AppProvider>(context, listen: false).dio,
          LevelUpgradeRequest(
            email: email,
            level: '2'
          ),
          Provider.of<AppProvider>(context, listen: false).baseUrl,
          context
      ),
    });

  }
}
