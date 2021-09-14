import 'dart:convert';
import 'dart:ui';
import 'package:crush_notion/Constants/constants.dart';
import 'package:crush_notion/Model/homeModel.dart';
import 'package:crush_notion/Services/homeServices.dart';
import 'package:crush_notion/util/App_constants/appconstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'VideoCallPg.dart';

const appId = '2a15c26a752c4cd4844461b23da32c55';
const token =
    '0062a15c26a752c4cd4844461b23da32c55IAD99EGody/N+2ZQII53w/a+HgcYOO8wVdrCukAV4hRPDHfUBg0AAAAAEAA8nW45qf0pYQEAAQCo/Slh';

class homePg extends StatefulWidget {
  final String user_id;
  const homePg({Key? key, required this.user_id}) : super(key: key);

  @override
  _homePgState createState() => _homePgState();
}

class _homePgState extends State<homePg> {
  Future addFavourites(String fav_id) async {
    var response = await http
        .post(Uri.parse(BASE_URL + AppConstants.ADD_FAVOURITES), body: {
      'token': '123456789',
      'user_id': widget.user_id,
      'fav_user_id': fav_id
    });
    if (response.statusCode == 200 &&
        startIndex < gethomeDetails.data.length - 1) {
      setState(() {
        startIndex++;
      });
    }
  }

  bool loading = false;
  late Future<Home> home;
  late Home gethomeDetails;
  int startIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    home = HomeService().getHomeDetails(widget.user_id).then((value) {
      setState(() {
        gethomeDetails = value;
        loading = true;
      });
      return gethomeDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (!loading)
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            //extendBody: true,
            resizeToAvoidBottomInset: false,

            backgroundColor: Colors.white,
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          gethomeDetails.data[startIndex].profileImage),
                      fit: BoxFit.cover)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            (gethomeDetails.data[startIndex].status
                                        .toString() ==
                                    'Online')
                                ? 'Online  '
                                : 'Offline  ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'SegoeUI',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.circle,
                            color: (gethomeDetails.data[startIndex].status
                                        .toString() ==
                                    'Online')
                                ? Color(0xff0FD97B)
                                : Colors.red,
                            size: 10,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${gethomeDetails.data[startIndex].fullName}, ${gethomeDetails.data[startIndex].age}',
                            style: TextStyle(
                              color: Color(0xffF0EEEF),
                              fontSize: 22,
                              fontFamily: 'SegoeUI',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Icon(Icons.location_on,
                                  size: 20, color: Colors.grey),
                            ),
                            Text(
                              '${gethomeDetails.data[startIndex].city}',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (startIndex <
                                      gethomeDetails.data.length - 1) {
                                    setState(() {
                                      startIndex++;
                                      print(gethomeDetails.data.length
                                          .toString());
                                    });
                                  }
                                },
                                child: homeIconBtn(
                                  icon: Icons.close,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      barrierColor:
                                          Colors.white.withOpacity(0.4),
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: appThemeColor,
                                                  width: 2),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20.0),
                                              ),
                                            ),
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      gradient: RadialGradient(
                                                          colors: [
                                                            Colors.orange,
                                                            Colors.yellow
                                                          ]),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Icon(
                                                    Icons.star_rounded,
                                                    size: 20,
                                                    color: Colors
                                                        .yellowAccent.shade100,
                                                  ),
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '4',
                                                      style: TextStyle(
                                                          color: appThemeColor,
                                                          fontFamily: 'SegoeUI',
                                                          letterSpacing: 1,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 30),
                                                    ),
                                                    Text(
                                                      ' / min',
                                                      style: TextStyle(
                                                          color: Color(
                                                                  0xff0B0D0F)
                                                              .withOpacity(0.8),
                                                          fontFamily: 'SegoeUI',
                                                          letterSpacing: 1,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  'For voice call',
                                                  style: TextStyle(
                                                      color: Color(0xff0B0D0F)
                                                          .withOpacity(0.6),
                                                      fontFamily: 'SegoeUI',
                                                      letterSpacing: 1,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                )
                                              ],
                                            ),
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: FlatButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'Cancel',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  'SegoeUI',
                                                              letterSpacing: 1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  appThemeColor),
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      height: 40,
                                                      width: 102,
                                                      decoration: BoxDecoration(
                                                          color: appThemeColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: FlatButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            'Ok',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontFamily:
                                                                    'SegoeUI',
                                                                letterSpacing:
                                                                    1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white),
                                                          )),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ));
                                },
                                child: homeIconBtn(
                                  icon: Icons.call,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      barrierColor:
                                          Colors.white.withOpacity(0.4),
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: appThemeColor,
                                                  width: 2),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20.0),
                                              ),
                                            ),
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      gradient: RadialGradient(
                                                          colors: [
                                                            Colors.orange,
                                                            Colors.yellow
                                                          ]),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Icon(
                                                    Icons.star_rounded,
                                                    size: 20,
                                                    color: Colors
                                                        .yellowAccent.shade100,
                                                  ),
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '6',
                                                      style: TextStyle(
                                                          color: appThemeColor,
                                                          fontFamily: 'SegoeUI',
                                                          letterSpacing: 1,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 30),
                                                    ),
                                                    Text(
                                                      '/ min',
                                                      style: TextStyle(
                                                          color: Color(
                                                                  0xff0B0D0F)
                                                              .withOpacity(0.8),
                                                          fontFamily: 'SegoeUI',
                                                          letterSpacing: 1,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  'For video call',
                                                  style: TextStyle(
                                                      color: Color(0xff0B0D0F)
                                                          .withOpacity(0.6),
                                                      fontFamily: 'SegoeUI',
                                                      letterSpacing: 1,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                )
                                              ],
                                            ),
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: FlatButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'Cancel',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  'SegoeUI',
                                                              letterSpacing: 1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  appThemeColor),
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      height: 40,
                                                      width: 102,
                                                      decoration: BoxDecoration(
                                                          color: appThemeColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: FlatButton(
                                                          onPressed: () {
                                                            Navigator
                                                                .pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            videoCallPg(
                                                                              user_id: widget.user_id,
                                                                            )));
                                                          },
                                                          child: Text(
                                                            'Ok',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontFamily:
                                                                    'SegoeUI',
                                                                letterSpacing:
                                                                    1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white),
                                                          )),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ));
                                },
                                child: homeIconBtn(
                                  icon: Icons.videocam,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  addFavourites(
                                      gethomeDetails.data[startIndex].userId);
                                },
                                child: homeIconBtn(
                                  icon: Icons.favorite,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }
}

class homeIconBtn extends StatelessWidget {
  final IconData icon;
  const homeIconBtn({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white54, width: 1)),
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                // gradient: LinearGradient(
                //     colors: [
                //       Colors.white.withOpacity(0.75),
                //       Colors.white.withOpacity(0.75),
                //     ],
                //     begin: Alignment.topLeft,
                //     end: Alignment.bottomRight,
                //     stops: [0.0, 1.0]),

                color: Colors.grey.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Center(
                  child: Icon(
                icon,
                color: Colors.white,
                size: 40,
              )),
            ),
          ),
        ));
  }
}
