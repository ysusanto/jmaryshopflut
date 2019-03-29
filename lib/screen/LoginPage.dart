import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jmaryshop/tools/AppTools.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext context;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   this.context = context;
    return new Scaffold(
       key: scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: new AppBar(
        title: new Text("Login"),
        centerTitle: false,
        elevation: 0.0,
      ),
       body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: "Phone Number",
                textIcon: Icons.phone,
                textType: TextInputType.number,
                controller: phoneNumber),
            new SizedBox(
              height: 30.0,
            ),
           
            appButton(
                btnTxt: "Login",
                onBtnclicked: verifyLoggin,
                btnPadding: 20.0,
                btnColor: Theme.of(context).primaryColor),
            new GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) => null));
              },
              child: new Text(
                "Not Registered? Sign Up Here",
                style: new TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
  verifyLoggin() async {
    if (phoneNumber.text == "") {
      showSnackBar("phone cannot be empty", scaffoldKey);
      return;
    }

    if (password.text == "") {
      showSnackBar("Password cannot be empty", scaffoldKey);
      return;
    }

    displayProgressDialog(context);
    // String response = await appMethod.logginUser(
    //     email: email.text.toLowerCase(), password: password.text.toLowerCase());
    // if (response == successful) {
    //   closeProgressDialog(context);
    //   Navigator.of(context).pop(true);
    // } else {
    //   closeProgressDialog(context);
    //   showSnackBar(response, scaffoldKey);
    // }
  }
}
