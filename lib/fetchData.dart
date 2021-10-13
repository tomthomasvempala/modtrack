import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

getData() async {
  SharedPreferences sP = await SharedPreferences.getInstance();
  String dataAsJSON = sP.getString("myData");
  if (dataAsJSON == null) {
    return [];
  }
  var myData = json.decode(dataAsJSON);
  return myData;
}

void setData(List<Map> myList) async {
  SharedPreferences sP = await SharedPreferences.getInstance();
  String dataAsJSON = json.encode(myList);
  sP.setString("myData", dataAsJSON);
}
