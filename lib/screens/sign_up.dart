
import 'package:flutter/material.dart';
import 'package:kyc/common_widgets/app_button.dart';
import 'package:kyc/mixins/authentication/authentication_helper.dart';
import 'package:kyc/models/signup_model/signup_request_model.dart';
import 'package:kyc/providers/app_provider.dart';
import 'package:kyc/providers/authentication_provider.dart';
import 'package:kyc/screens/common/auth_textfield.dart';
import 'package:kyc/screens/login.dart';
import 'package:kyc/utils/validator.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget with AuthenticationHelper{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, AuthenticationProvider signUpProvider, Widget child){
          return Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Theme.of(context).accentColor,
              padding: EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50,),

                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).primaryColor
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text(
                            'HACATHON',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ],
                      ),

                      SizedBox(height: 20,),

                      Text(
                        'Create your hackathon account',
                        style: Theme.of(context).textTheme.headline2,
                      ),

                      SizedBox(height: 30,),

                      AppTextField(
                          controller: emailController,
                          hintText: 'Email Address',
                          password: false,
                          validatorCallback: formValidator.emailValidator,
                          title: 'Email Address'
                      ),

                      AppTextField(
                          controller: firstNameController,
                          hintText: 'First Name',
                          password: false,
                          validatorCallback: formValidator.singleInputValidator,
                          title: 'First Name'
                      ),

                      AppTextField(
                          controller: lastNameController,
                          hintText: 'Last Name',
                          password: false,
                          validatorCallback: formValidator.singleInputValidator,
                          title: 'Last Name'
                      ),

                      AppTextField(
                          controller: userNameController,
                          hintText: 'Username',
                          password: false,
                          validatorCallback: formValidator.singleInputValidator,
                          title: 'Username'
                      ),

                      AppTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          password: true,
                          validatorCallback: formValidator.singleInputValidator,
                          title: 'Password'
                      ),

                      Text(
                        'Use 8 or more characters with a mix of letters, numbers & symbols',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(height: 30,),

                      AppTextField(
                          controller: confirmPasswordController,
                          hintText: 'Confirm Password',
                          password: true,
                          validatorCallback: formValidator.singleInputValidator,
                          title: 'Confirm Password'
                      ),

                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                              );
                            },
                            child: Text(
                              'Sign in instead?',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ),

                          SizedBox(width: 40,),

                          Expanded(
                            child: signUpProvider.isLoading
                            ?
                            Container(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),),
                                ))
                            :
                            AppSolidButton(
                              text: 'Sign up',
                              height: 40,
                              style: Theme.of(context).textTheme.subtitle1,
                              onPressed: (){
                                if(formKey.currentState.validate()){

                                  doSignUp(
                                      Provider.of<AppProvider>(context, listen: false).dio,
                                      SignUpRequest(
                                          firstName: firstNameController.text,
                                          lastName: lastNameController.text,
                                          username: userNameController.text,
                                          email: emailController.text,
                                          password: passwordController.text
                                      ),
                                      Provider.of<AppProvider>(context, listen: false).baseUrl,
                                      context
                                  );
                                }
                              },
                            )
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
