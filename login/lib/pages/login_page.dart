import 'package:flutter/material.dart';

import '../ProgressHUD.dart';
import '../api/api_service.dart';
import '../model/login_model.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  late LoginRequestModel loginRequestModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    loginRequestModel = LoginRequestModel(email: '', password: '');
  }

  @override
  Widget build(BuildContext context) {
    return _uiSetup(context);

    // ProgressHUD(
    //   child: _uiSetup(context),
    //   inAsyncCall: isApiCallProcess,
    //   opacity: 0.3,
    // );
  }

  Widget _uiSetup(BuildContext context) {
    var hintColor;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).hintColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 10),
                          blurRadius: 20)
                    ],
                  ),
                  child: Form(
                    key: globalFormKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 25),
                        Text("Login",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium // headline2,弃用
                            ),
                        SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) =>
                              loginRequestModel.email = input.toString(),
                          validator: (input) => input!.contains('@')
                              ? "Email Id should be valid"
                              : null,
                          decoration: InputDecoration(
                            hintText: "Email Address",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).hintColor)),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          onSaved: (input) =>
                              loginRequestModel.password = input.toString(),
                          validator: (input) => input!.length < 3
                              ? "Password should be more than 3 characters"
                              : null,
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                            hintText: "Password",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).hintColor)),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Theme.of(context).hintColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.4),
                              icon: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        // FlatButton( // 弃用报红了 用 TextButton

                        // padding: EdgeInsets.symmetric(
                        //       vertical: 12, horizontal: 80),
                        // child:
                        TextButton(
                          style: flatButtonStyle,
                          onPressed: () {
                            if (validateAndSave()) {
                              print(loginRequestModel.toJson());

                              setState(() {
                                isApiCallProcess = true;
                              });

                              APIService apiService = APIService();
                              apiService.login(loginRequestModel).then((value) {
                                if (value != null) {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });

                                  if (value.token.isNotEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Login Successful"),
                                    ));

                                    // final snackBar = SnackBar(
                                    //     content: Text("Login Successful"));

                                    // scaffoldKey.currentState?.showSnackBar(snackBar);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(value.error)),
                                    );
                                    // flutter 2.0 以后通知栏消息管理
                                    // final snackBar =
                                    //     SnackBar(content: Text(value.error));

                                    // scaffoldKey.currentState!
                                    //     .showSnackBar(snackBar);
                                  }
                                  ;
                                  //   }
                                  // });
                                }
                                ;
                              });
                            }
                            ;
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Color.fromARGB(255, 24, 88, 121)),
                          ),
                          // color: Theme.of(context).hintColor,
                          // shape: StadiumBorder(),
                        ),

                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    textStyle: TextStyle(color: Colors.black),
    disabledBackgroundColor: Colors.blueAccent,
    foregroundColor: Color.fromARGB(221, 19, 199, 19),
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 80),
    shape: StadiumBorder(),
    // shape:
    // const RoundedRectangleBorder(
    //   borderRadius: BorderRadius.all(Radius.circular(2.0)),
    // ),
  );

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
