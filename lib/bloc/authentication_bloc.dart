import 'dart:convert';
import 'package:device_id/device_id.dart';
import 'package:lyra_mobile/api/lyra_api_endpoints.dart';
import 'package:lyra_mobile/validators/form_validation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
//import 'package:rxdart/streams.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class AuthenticationBloc with LyraValidators{
  final BehaviorSubject<String> _deviceStatusController = new BehaviorSubject<String>();
  final BehaviorSubject<String> _phoneNumberController = new BehaviorSubject<String>();


  Function(String) get deviceStatusChange => _deviceStatusController.sink.add;
  Function(String) get phoneNumberChange => _phoneNumberController.sink.add;

  Stream<String> get phoneNumberStream => _phoneNumberController.stream.transform(validatePhone);

  String get deviceStatus => _deviceStatusController.value;
  String get phoneNumber => _phoneNumberController.value;


  Stream< dynamic > get streamDeviceStatus => _deviceStatusController.stream;

  getDeviceStatus () async{
    String deviceid = await DeviceId.getID;
    print(deviceid);
    var deviceJson = await http.post(
      Uri.encodeFull(deviceAuthentication),
      body: json.encode({
        "device_id": deviceid,
        "phone_number" : "555-555-555"

      }),
      headers: {
      "Accept": "application/json",
      
     }
    );

    var deviceBody = json.decode(deviceJson.body);
    deviceStatusChange(deviceBody['code'].toString());

    //print(deviceBody['code']);
    print(deviceStatus);

  }

  requestDeviceAuthentication(var context) async{
    String deviceid = await DeviceId.getID;
     var deviceAuthJson = await http.post(
      Uri.encodeFull(requestAuthenticationApi),
      body: json.encode({
        "device_id": deviceid,
        "phone_number" : phoneNumber 

      }),
      headers: {
      "Accept": "application/json",
      
     }
    );

    var auth = json.decode(deviceAuthJson.body);

    if(auth['code'].toString() == "200")
    {
      
      showDialog(
         barrierDismissible: false,
         child: new AlertDialog(
            title: new Text("Detalles"),
            content: Text(auth['message'].toString()),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Aceptar'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                   
                },
              ),
            ],
            ),
            context: context,
            

      );


    }
    else{
      showDialog(
         barrierDismissible: false,
         child: new AlertDialog(
            title: new Text("Detalles"),
            content: Text(auth['message'].toString()),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Aceptar'),
                onPressed: () {
              //    Navigator.pushReplacementNamed(context, '/');
              Navigator.of(context).pop();
                   
                },
              ),
            ],
            ),
            context: context,
            

      );
    }

  }

  

  dispose(){
    _deviceStatusController.close();
    _phoneNumberController.close();
  }
}