import 'dart:convert';

import 'package:crush_notion/Constants/constants.dart';
import 'package:crush_notion/Screens/secureAccountPg.dart';
import 'package:crush_notion/util/App_constants/appconstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class recoveryEmailPg extends StatefulWidget {
  final String user_id;
  const recoveryEmailPg({Key? key, required this.user_id}) : super(key: key);

  @override
  _recoveryEmailPgState createState() => _recoveryEmailPgState();
}

class _recoveryEmailPgState extends State<recoveryEmailPg> {
  late String recoveryEmail;
  TextEditingController recoveryEmailController = TextEditingController();
  Future addRecoveyEmail() async {
    var Response = await http
        .post(Uri.parse(BASE_URL + AppConstants.RECOVEY_EMAIL), body: {
      'token': '123456789',
      'user_id': widget.user_id,
      'email': recoveryEmail
    });
    var response = jsonDecode(Response.body);
    if (response['status']) {
      setState(() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    secureAccountPg(user_id: widget.user_id)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 106,
                    width: 262,
                    child: Text(
                      'Add Recovery Email',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: appThemeColor,
                        fontSize: 40,
                        fontFamily: 'SegoeUI',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 400,
                      height: 73,
                      child: Text(
                        'You can recover your username with the email address or mobile number associated with your account profile.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff0B0D0F).withOpacity(0.6),
                          fontFamily: 'SegoeUI',
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  'Email',
                  style: TextStyle(
                    color: appThemeColor,
                    fontSize: 18,
                    fontFamily: 'SegoeUI',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                TextField(
                  controller: recoveryEmailController,
                  onChanged: (value) {
                    setState(() {
                      value = recoveryEmailController.text.toString();
                      recoveryEmail = value;
                      print(recoveryEmail);
                    });
                  },
                  onSubmitted: (value) {
                    setState(() {
                      value = recoveryEmailController.text.toString();
                      recoveryEmail = value;
                    });
                  },
                  decoration: InputDecoration(
                    enabled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: new BorderSide(color: appThemeColor)),
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: appThemeColor)),
                    hintTextDirection: TextDirection.ltr,
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'SegoeUI',
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: '     Lorem ipsum@lorem.com',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.28,
                ),
                Center(
                  child: commonBtn(
                    bgcolor: appThemeColor,
                    s: 'Continue',
                    textColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        addRecoveyEmail();
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Center(
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Skip',
                      style: TextStyle(
                          color: Color(0xff0B0D0F).withOpacity(0.6),
                          fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
