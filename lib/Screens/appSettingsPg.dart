import 'dart:convert';

import 'package:crush_notion/Constants/constants.dart';
import 'package:crush_notion/Screens/splashScreen.dart';
import 'package:crush_notion/util/App_constants/appconstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:http/http.dart' as http;

class appSettingsPg extends StatefulWidget {
  final String user_id;
  const appSettingsPg({Key? key, required this.user_id}) : super(key: key);

  @override
  _appSettingsPgState createState() => _appSettingsPgState();
}

class _appSettingsPgState extends State<appSettingsPg> {
  Future deleteUser() async {
    var Response = await http.post(
        Uri.parse(BASE_URL + AppConstants.DELETE_ACCOUNT),
        body: {'token': '123456789', 'user_id': widget.user_id});
    var response = jsonDecode(Response.body);
    if (response['status']) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => splashScreen()),
          (route) => route.isFirst);
      Navigator.pop(context);
    }
  }

  bool online_offline_Swith = false;
  bool voice_call_Swith = false;
  bool video_call_Swith = false;
  TextStyle reportText =
      TextStyle(color: Color(0xff0B0D0F).withOpacity(0.8), fontSize: 16);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'App Settings',
              style: TextStyle(
                  color: appThemeColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text('Notification', style: TextStyle(fontSize: 16)),
            Text(
              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea.',
              style: TextStyle(
                  color: Color(0xff0B0D0F).withOpacity(0.6), fontSize: 14),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Online & Offline',
                  style: reportText,
                ),
                FlutterSwitch(
                    activeIcon: Icon(
                      Icons.circle,
                      color: appThemeColor,
                    ),
                    toggleSize: 12,
                    height: 20,
                    width: 30,
                    activeColor: appThemeColor,
                    value: online_offline_Swith,
                    onToggle: (value) {
                      setState(() {
                        online_offline_Swith = value;
                      });
                    })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Voice Call Notification',
                  style: reportText,
                ),
                FlutterSwitch(
                    activeIcon: Icon(
                      Icons.circle,
                      color: appThemeColor,
                    ),
                    toggleSize: 12,
                    height: 20,
                    width: 30,
                    activeColor: appThemeColor,
                    value: voice_call_Swith,
                    onToggle: (value) {
                      setState(() {
                        voice_call_Swith = value;
                      });
                    })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Video Call Notification',
                  style: reportText,
                ),
                FlutterSwitch(
                    activeIcon: Icon(
                      Icons.circle,
                      color: appThemeColor,
                    ),
                    toggleSize: 12,
                    height: 20,
                    width: 30,
                    activeColor: appThemeColor,
                    value: video_call_Swith,
                    onToggle: (value) {
                      setState(() {
                        video_call_Swith = value;
                      });
                    })
              ],
            ),
            GestureDetector(
              onTap: () {
                // Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (context) => splashScreen()));
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => splashScreen()),
                    (route) => route.isFirst);
                Navigator.pop(context);
              },
              child: Text(
                'Logout',
                style: TextStyle(
                    color: appThemeColor.withOpacity(0.8), fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 66),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    deleteUser();
                  });
                },
                child: Text(
                  'Delete My Account',
                  style: TextStyle(
                      color: Colors.red.withOpacity(0.8), fontSize: 16),
                ),
              ),
            ),
            Text(
              'Terms and Conditions of Use',
              style: TextStyle(
                  color: Color(0xff0B0D0F).withOpacity(0.6), fontSize: 16),
            ),
            Text('Privacy Policy',
                style: TextStyle(
                    color: Color(0xff0B0D0F).withOpacity(0.6), fontSize: 16)),
            Text('Help Centre',
                style: TextStyle(
                    color: Color(0xff0B0D0F).withOpacity(0.6), fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
