import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> lastFile() async {
  var url = 'http://192.168.1.1/osc/state';

  var response = await http
      .post(url, headers: {"Content-Type": "application/json;charset=utf-8"});

  Map<String, dynamic> thetaState = jsonDecode(response.body);

// print(thetaState);
  String imageFileUrl = thetaState['state']['_latestFileUrl'];
  print("Image is available at thi URL");
  print(imageFileUrl);
  return imageFileUrl;
}
