/// get exposure delay for self-timer functionality
/// https://api.ricoh/docs/theta-web-api-v2.1/options/exposure_delay/
/// if exposure delay is zero, then self-timer is delayed. a value of 5
/// means 5 second delay
///
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'pretty_print.dart';


Future<int> getExposureDelay () async {
  var url ='http://192.168.1.1/osc/commands/execute';

  Map data = {
    'name': 'camera.getOptions',
    'parameters': {
      'optionNames': [
        "exposureDelay",
      ]
    }
  };

  //encode Map to JSON
  var body = jsonEncode(data);

  var response = await http.post(url,
      headers: {"Content-Type": "application/json;charset=utf-8"},
      body: body
  );
  Map<String, dynamic> resp = jsonDecode(response.body);
//  print("${response.statusCode}");
  print(response.body);
  int exposureDelayValue = resp['results']['options']['exposureDelay'];
  print('Exposure delay value currently set to: $exposureDelayValue');
  return exposureDelayValue;
}