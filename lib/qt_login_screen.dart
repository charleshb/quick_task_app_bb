import 'package:flutter/material.dart';
import 'package:quick_task_app_bb/quick_task_api.dart';

class QTLoginScreen extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

//class QTLoginScreen extends StatelessWidget {

class LoginState extends State<QTLoginScreen> {
  var emailInputController = TextEditingController(); //TextEditingController(text: "bcharles@gmail.com")
  var passwordInputController = TextEditingController(); //TextEditingController(text: "12345")
  var qtApiController = QuickTaskAPIController();

  void loginOnPressed() async {
    var username = emailInputController.text;
    var password = passwordInputController.text;

    if (username.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please provide the username/email"),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    if (password.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please provide the password."),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    var userId = qtApiController.validateUserLogin(username, password);

    if (userId.toString() != "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Login was successful"),
        duration: Duration(seconds: 2),
      ));

      // Navigate to the Task screen
      Navigator.pushNamed(context, '/Tasks');
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Login failed"),
        duration: Duration(seconds: 2),
      ));
    }

    return;
  }

  void signUpOnPressed() async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Coming soon!"),
        duration: Duration(seconds: 2),
      ));
      return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                ///***If you have exported images you must have to copy those images in assets/images directory.
                Image(
                  image: AssetImage("assets/images/gavel_24dp.png"),
                  // height: 90,
                  // width: 90,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 30),
                  child: Text(
                    "Quick Task",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      color: Color(0xff3a57e8),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 30),
                  child: Text(
                    "2022MT12258",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color.fromARGB(255, 64, 42, 92),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sign In",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 24,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                  child: TextField(
                    controller: emailInputController,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      color: Color(0xff000000),
                    ),
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide:
                            BorderSide(color: Color(0xff9e9e9e), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide:
                            BorderSide(color: Color(0xff9e9e9e), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide:
                            BorderSide(color: Color(0xff9e9e9e), width: 1),
                      ),
                      labelText: "Email",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        color: Color(0xff9e9e9e),
                      ),
                      filled: true,
                      fillColor: Color(0x00f2f2f3),
                      isDense: false,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    ),
                  ),
                ),
                TextField(
                  controller: passwordInputController,
                  obscureText: true,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    color: Color(0xff000000),
                  ),
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide:
                          BorderSide(color: Color(0xff9e9e9e), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide:
                          BorderSide(color: Color(0xff9e9e9e), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide:
                          BorderSide(color: Color(0xff9e9e9e), width: 1),
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      color: Color(0xff9e9e9e),
                    ),
                    filled: true,
                    fillColor: Color(0x00f2f2f3),
                    isDense: false,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password ?",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff9e9e9e),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          onPressed: signUpOnPressed,//() {},
                          color: Color(0xffffffff),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side:
                                BorderSide(color: Color(0xff9e9e9e), width: 1),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          textColor: Color(0xff000000),
                          height: 40,
                          minWidth: 140,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          onPressed: loginOnPressed,//() {}
                          color: Color(0xff3a57e8),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          textColor: Color(0xffffffff),
                          height: 40,
                          minWidth: 140,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
