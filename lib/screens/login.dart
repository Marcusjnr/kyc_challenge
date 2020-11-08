import 'package:flutter/material.dart';
import 'package:kyc/common_widgets/app_button.dart';
import 'package:kyc/mixins/authentication/authentication_helper.dart';
import 'package:kyc/models/login_model/login_request_model.dart';
import 'package:kyc/providers/app_provider.dart';
import 'package:kyc/providers/authentication_provider.dart';
import 'package:kyc/utils/validator.dart';
import 'package:provider/provider.dart';

import 'common/auth_textfield.dart';

class LoginScreen extends StatelessWidget with AuthenticationHelper{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, AuthenticationProvider loginProvider, Widget child){
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
                    children: [
                      SizedBox(height: 50,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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

                      SizedBox(height: 40,),
                      Text(
                        'Welcome Back',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(height: 20,),

                      Text(
                        'Please sign in',
                        style: Theme.of(context).textTheme.headline2,
                      ),

                      SizedBox(height: 30,),

                      AppTextField(
                        controller: emailController,
                        hintText: 'Email Address',
                        password: false,
                        validatorCallback: formValidator.emailValidator,
                        hasTitle: false,
                      ),

                      AppTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          password: true,
                          validatorCallback: formValidator.singleInputValidator,
                          hasTitle: false
                      ),

                      loginProvider.isLoading
                          ?
                      Container(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue)))
                          :
                      AppSolidButton(
                        text: 'Sign in',
                        style: Theme.of(context).textTheme.subtitle1,
                        onPressed: (){
                          if(formKey.currentState.validate()){
                            doSignIn(
                                Provider.of<AppProvider>(context, listen: false).dio,
                                LoginRequest(
                                    email: emailController.text,
                                    password: passwordController.text
                                ),
                                Provider.of<AppProvider>(context, listen: false).baseUrl,
                                context
                            );
                          }
                        },
                      ),

                      SizedBox(height: 18,),

                      Divider(color: Colors.black.withOpacity(0.5),),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                              );
                            },
                            child: Text(
                              'Forgot Password ?',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ),

                          RichText(
                            text: TextSpan(
                                text: 'New user ?',
                                style: Theme.of(context).textTheme.headline3,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' Sign up',
                                    style: Theme.of(context).textTheme.subtitle2,
                                  )
                                ]
                            ),
                          ),
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
