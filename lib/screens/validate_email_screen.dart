import 'package:flutter/material.dart';
import 'package:kyc/common_widgets/app_button.dart';
import 'package:kyc/mixins/authentication/authentication_helper.dart';
import 'package:kyc/models/email_validation_model/email_validation_request.dart';
import 'package:kyc/providers/app_provider.dart';
import 'package:kyc/providers/authentication_provider.dart';
import 'package:kyc/screens/common/auth_textfield.dart';
import 'package:kyc/storage/shared_preferences_helper.dart';
import 'package:kyc/utils/validator.dart';
import 'package:provider/provider.dart';

class ValidateEmailScreen extends StatelessWidget with AuthenticationHelper{
  TextEditingController tokenController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, AuthenticationProvider authenticationProvider, Widget child){
          return Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTextField(
                      controller: tokenController,
                      hintText: 'Enter code sent to your email',
                      password: false,
                      keyboardType: TextInputType.number,
                      hasTitle: false,
                      validatorCallback: formValidator.singleInputValidator
                  ),

                  authenticationProvider.isLoading
                  ?
                  Container(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue)))
                  :
                  AppSolidButton(
                    style: Theme.of(context).textTheme.subtitle1,
                    text: 'Validate Email',
                    onPressed: () async{
                      String email = await SharedHelper.getUserDetailsSpecific('email', context);
                      doEmailValidation(
                          Provider.of<AppProvider>(context, listen: false).dio,
                          EmailValidationRequest(
                            email: email,
                            token: tokenController.text
                          ),
                          Provider.of<AppProvider>(context, listen: false).baseUrl,
                          context
                      );
                    },
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}
