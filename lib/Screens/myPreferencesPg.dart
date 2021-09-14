import 'package:crush_notion/Constants/constants.dart';
import 'package:crush_notion/util/App_constants/appconstants.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:http/http.dart' as http;

class myPreferencesPg extends StatefulWidget {
  final String user_id;
  final String interested;
  const myPreferencesPg(
      {Key? key, required this.user_id, required this.interested})
      : super(key: key);

  @override
  _myPreferencesPgState createState() => _myPreferencesPgState();
}

class _myPreferencesPgState extends State<myPreferencesPg> {
  Future mypreferences() async {
    if (ischangesapplied) {
      var Response = await http
          .post(Uri.parse(BASE_URL + AppConstants.MY_PREFERENCES), body: {
        'token': '123456789',
        'user_id': widget.user_id,
        'city': cityValue.toString(),
        'interested': gender.toString(),
        'age': currentRangeValues.end.toString()
      });
      if (Response.statusCode == 200) {
        setState(() {
          Navigator.pop(context);
        });
      }
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('no changes made'),
          duration: Duration(seconds: 1),
        ));
        Navigator.pop(context);
      });
    }
  }

  late String gender = widget.interested.toString();
  late bool womenSwith;
  late bool menSwith;
  late bool bothSwith;

  String countryValue = '';
  String? stateValue = '';
  String? cityValue = '';
  bool ischangesapplied = false;
  RangeValues currentRangeValues = const RangeValues(18, 40);
  RangeValues ageBetween = const RangeValues(0, 33);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    womenSwith = (widget.interested.toString() == 'women') ? true : false;
    menSwith = (widget.interested.toString() == 'men') ? true : false;
    bothSwith = (widget.interested.toString() == 'both') ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 25, 8, 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: Text(
                  'My Preferences',
                  style: TextStyle(
                    color: appThemeColor,
                    fontSize: 20,
                    fontFamily: 'SegoeUI',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CSCPicker(
                  showCities: true,

                  flagState: CountryFlag.DISABLE,

                  dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      border: Border.all(color: appThemeColor, width: 1)),

                  disabledDropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey,
                      border: Border.all(color: Colors.white, width: 1)),

                  ///Default Country

                  ///selected item style [OPTIONAL PARAMETER]
                  selectedItemStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),

                  ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                  dropdownHeadingStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),

                  ///DropdownDialog Item style [OPTIONAL PARAMETER]
                  dropdownItemStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),

                  ///Dialog box radius [OPTIONAL PARAMETER]
                  dropdownDialogRadius: 10.0,

                  ///Search bar radius [OPTIONAL PARAMETER]
                  searchBarRadius: 10.0,

                  ///triggers once country selected in dropdown
                  onCountryChanged: (value) {
                    setState(() {
                      ///store value in country variable
                      countryValue = value;
                      print(countryValue);
                    });
                  },

                  ///triggers once state selected in dropdown
                  onStateChanged: (value) {
                    setState(() {
                      ///store value in state variable
                      stateValue = value;
                    });
                  },

                  ///triggers once city selected in dropdown
                  onCityChanged: (value) {
                    setState(() {
                      ///store value in city variable
                      cityValue = value;
                      ischangesapplied = true;
                    });
                  },
                ),
              ),
              // Container(
              //   height: 50,
              //   decoration: BoxDecoration(
              //       border: Border.all(color: appThemeColor),
              //       borderRadius: BorderRadius.circular(10)),
              //   child: DropdownButtonHideUnderline(
              //     child: DropdownButton(
              //       isExpanded: true,
              //       icon: Padding(
              //         padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
              //         child: Icon(
              //           Icons.keyboard_arrow_down,
              //           color: Colors.grey,
              //         ),
              //       ),
              //       hint: Text(
              //         '      Select City',
              //         style: TextStyle(color: Colors.grey),
              //       ),
              //       items: [],
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text('I want to find.....',
                    style: TextStyle(
                      color: appThemeColor.withOpacity(0.8),
                      fontSize: 16,
                      fontFamily: 'SegoeUI',
                      fontWeight: FontWeight.w700,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Women',
                        style: TextStyle(
                            color: appThemeColor.withOpacity(0.8),
                            fontFamily: 'SegoeUI',
                            fontWeight: FontWeight.w700,
                            fontSize: 16)),
                    FlutterSwitch(
                        activeIcon: Icon(
                          Icons.circle,
                          color: appThemeColor,
                        ),
                        toggleSize: 12,
                        height: 20,
                        width: 30,
                        activeColor: appThemeColor,
                        value: womenSwith,
                        onToggle: (value) {
                          setState(() {
                            (value)
                                ? gender = 'women'
                                : gender = widget.interested.toString();
                            womenSwith = value;
                            menSwith = false;
                            bothSwith = false;
                          });
                        })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Men',
                        style: TextStyle(
                            color: appThemeColor.withOpacity(0.8),
                            fontFamily: 'SegoeUI',
                            fontWeight: FontWeight.w700,
                            fontSize: 16)),
                    FlutterSwitch(
                        activeIcon: Icon(
                          Icons.circle,
                          color: appThemeColor,
                        ),
                        toggleSize: 12,
                        height: 20,
                        width: 30,
                        activeColor: appThemeColor,
                        value: menSwith,
                        onToggle: (value) {
                          setState(() {
                            (value)
                                ? gender = 'men'
                                : gender = widget.interested.toString();
                            womenSwith = false;
                            bothSwith = false;
                            menSwith = value;
                          });
                        })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Both',
                        style: TextStyle(
                            color: appThemeColor.withOpacity(0.8),
                            fontFamily: 'SegoeUI',
                            fontWeight: FontWeight.w700,
                            fontSize: 16)),
                    FlutterSwitch(
                        activeIcon: Icon(
                          Icons.circle,
                          color: appThemeColor,
                        ),
                        toggleSize: 12,
                        height: 20,
                        width: 30,
                        activeColor: appThemeColor,
                        value: bothSwith,
                        onToggle: (value) {
                          setState(() {
                            menSwith = false;
                            womenSwith = false;
                            bothSwith = value;
                          });
                        })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  children: [
                    Text(
                        '${currentRangeValues.start.round().toString()} - ${currentRangeValues.end.round().toString()} ',
                        style: TextStyle(
                            color: appThemeColor.withOpacity(0.8),
                            fontFamily: 'SegoeUI',
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    Text('  years old'),
                  ],
                ),
              ),
              RangeSlider(
                activeColor: appThemeColor,
                values: currentRangeValues,
                min: 18,
                max: 100,
                //divisions: 5,
                labels: RangeLabels(
                  currentRangeValues.start.round().toString(),
                  currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    currentRangeValues = values;
                  });
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: commonBtn(
                    s: 'ApplyChanges',
                    bgcolor: appThemeColor,
                    textColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        mypreferences();
                      });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
