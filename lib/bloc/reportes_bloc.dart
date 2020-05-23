import 'dart:convert';

import 'package:device_id/device_id.dart';
import 'package:lyra_mobile/api/lyra_api_endpoints.dart';
import 'package:lyra_mobile/validators/form_validation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/streams.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class GetReportsBloc with LyraValidators{

final BehaviorSubject<List> _deviceTransmissionsController = new BehaviorSubject<List>();


Function(List) get deviceTransmissionsChange => _deviceTransmissionsController.sink.add;

List get deviceTransmissions => _deviceTransmissionsController.value;

Stream< dynamic > get streamTransmissions => _deviceTransmissionsController.stream;

getDeviceTransmissions() async {

String deviceid = await DeviceId.getID;
    print(deviceid);
    var transmissionsJson = await http.post(
      Uri.encodeFull(retrieveTransmissions),
      body: json.encode({
        "device_id": deviceid
      }),
      headers: {
      "Accept": "application/json",
      
     }
    );

    var transmissionsBody = json.decode(transmissionsJson.body);
    deviceTransmissionsChange(transmissionsBody);

//    print(deviceTransmissions);
}

dispose(){
  _deviceTransmissionsController.close();
}

}