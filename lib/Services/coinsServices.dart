import 'dart:convert';

import 'package:crush_notion/Model/coinsModel.dart';
import 'package:crush_notion/util/App_constants/appconstants.dart';
import 'package:http/http.dart' as http;

class coinsService {
  Future<Coins> getCoins() async {
    var Response = await http.post(Uri.parse(BASE_URL + AppConstants.COINS),
        body: {'token': '123456789'});
    return Coins.fromJson(jsonDecode(Response.body));
  }
}
