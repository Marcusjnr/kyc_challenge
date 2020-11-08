import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kyc/common_widgets/app_button.dart';
import 'package:kyc/mixins/bvn_validation_helper/bvn_validation_helper.dart';
import 'package:kyc/models/bvn_validation_model/bvn_validation_request.dart';
import 'package:kyc/providers/app_provider.dart';
import 'package:kyc/providers/profile_provider.dart';
import 'package:kyc/screens/common/profile_options.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final String fullName;
  final String userName;
  final String email;

  ProfileScreen({
    @required this.fullName,
    @required this.userName,
    @required this.email
});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with ProfileHelper{

  TextEditingController bvnController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context){
    return Consumer(
        builder: (BuildContext context, ProfileProvider profileProvider, Widget child){
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Theme.of(context).accentColor,
                  padding: EdgeInsets.all(18.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50,),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 36,
                              backgroundColor: Colors.black38.withOpacity(0.5),
                              child: Icon(Icons.person, size: 50,),
                            ),

                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.fullName ?? '',
                                  style: Theme.of(context).textTheme.headline2,
                                ),

                                SizedBox(height: 12,),

                                Text(
                                  widget.email ?? '',
                                  style: Theme.of(context).textTheme.headline2,
                                ),

                                SizedBox(height: 12,),

                              ],
                            )
                          ],
                        ),

                        SizedBox(height: 20,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              widget.userName ?? '',
                              style: Theme.of(context).textTheme.headline2,
                            ),

                            Container(
                              width: 80,
                              height: 30,
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xff757575).withOpacity(0.5))
                              ),
                              child: Center(
                                child: Text(
                                    'KYC LV 0'
                                ),
                              ),
                            ),

                            Text(
                              'Upgrade to level 1',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),

                        SizedBox(height: 30,),

                        Text(
                          'Verification',
                          style: Theme.of(context).textTheme.headline2,
                        ),

                        Text(
                          'Complete steps below to get verified',
                          style: Theme.of(context).textTheme.headline2,
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: GridView.count(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1,
                            crossAxisCount: 3 ,
                            children: [
                              ProfileOptions(
                                icon: Icons.add,
                                levelText: 'Level 1',
                                subText: 'BVN Verification',
                                position: 0,
                                controller: bvnController,
                                dobController: dateController,
                                alertButtonPressed: (){
                                  Navigator.pop(context);
                                  String date = dateController.text;
                                  List<String> dateSplit = date.split(' ');
                                  String dateReal = dateSplit[0];
                                  doBvnValidation(
                                      Provider.of<AppProvider>(context, listen: false).dio,
                                      BvnValidationRequest(
                                        dob: dateReal,
                                      ),
                                      Provider.of<AppProvider>(context, listen: false).baseUrl,
                                      context
                                  );
                                },
                              ),

                              ProfileOptions(
                                icon: Icons.add,
                                levelText: 'Level 2',
                                subText: 'Passport Verification',
                                position: 1,
                              ),

                              ProfileOptions(
                                icon: Icons.add,
                                levelText: 'Level 3',
                                subText: 'Link Bank Account',
                              )
                            ],
                          ),
                        ),

                        AppSolidButton(
                          style: Theme.of(context).textTheme.subtitle1,
                          text: 'Begin Verification',
                        )
                      ],
                    ),
                  ),
                ),

                Visibility(
                  visible: profileProvider.isLoading,
                  child: WillPopScope(
                    onWillPop: () async => false,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black38,
                      child: Container(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),),
                      )),
                    ),
                  ),
              ],
            ),
          );
        }
    );
  }


}
