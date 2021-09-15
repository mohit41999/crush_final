import 'package:crush_notion/Constants/constants.dart';
import 'package:crush_notion/Model/coinsModel.dart';
import 'package:crush_notion/Services/coinsServices.dart';
import 'package:flutter/material.dart';

class coinsPg extends StatefulWidget {
  const coinsPg({
    Key? key,
  }) : super(key: key);

  @override
  _coinsPgState createState() => _coinsPgState();
}

class _coinsPgState extends State<coinsPg> {
  List coinsDetails = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      coinsService().getCoins().then((value) {
        setState(() {
          coinsDetails = value.data;

          print(value);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Coins',
              style: TextStyle(color: appThemeColor, fontSize: 20),
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.23,
            color: appThemeColor,
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('200',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Coins Balance',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    width: 118,
                    height: 36,
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Withdraw',
                          style: TextStyle(color: appThemeColor, fontSize: 14),
                        )),
                  )
                ],
              ),
            )),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            child: Center(
                child: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.06,
              //height: 50,
              decoration: BoxDecoration(
                  border: Border.symmetric(
                horizontal: BorderSide(color: Colors.grey),
                vertical: BorderSide(color: Colors.grey),
              )),
              child: Center(
                  child: Text(
                '1 Coin = \u{20B9} 1',
                style: TextStyle(
                    color: Color(0xff0B0D0F).withOpacity(0.4),
                    fontSize: 20,
                    fontFamily: 'SegoeUI'),
              )),
            )),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: coinsDetails.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20.0),
                    child: Container(
                      width: double.infinity,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: appThemeColor)),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SizedBox(
                              width: 100,
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        gradient: RadialGradient(colors: [
                                          Colors.orange,
                                          Colors.yellow
                                        ]),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Icon(
                                      Icons.star_rounded,
                                      size: 20,
                                      color: Colors.yellowAccent.shade100,
                                    ),
                                  ),
                                  Text(
                                    coinsDetails[index].totalCoin,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'SegoeUI',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SizedBox(
                              width: 90,
                              height: 40,
                              child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              appThemeColor),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ))),
                                  onPressed: () {},
                                  child: Text(
                                    '\u{20B9}' + coinsDetails[index].amount,
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                          )
                        ],
                      )),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
