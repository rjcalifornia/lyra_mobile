import 'dart:convert';

import 'package:lyra_mobile/api/lyra_api_endpoints.dart';
import 'package:lyra_mobile/validators/form_validation.dart';
import 'package:rxdart/rxdart.dart';
//import 'package:rxdart/streams.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class GetApiBloc with LyraValidators{



final BehaviorSubject<List> _votingCenterController = new BehaviorSubject<List>();
final BehaviorSubject<List> _pollingStationController = new BehaviorSubject<List>();




Function(List) get votingCenterChange => _votingCenterController.sink.add;
Function(List) get pollingStationChange => _pollingStationController.sink.add;



List get votingCenter => _votingCenterController.value;
List get pollingStation => _pollingStationController.value;

Stream< dynamic > get streamVoting => _votingCenterController.stream;

getVotingCenters() async {

    var votingCentersJson = await http.get(
      Uri.encodeFull(votingCenters),
      headers: {
      "Accept": "application/json"
     }
    );

    var pollingStationsJson = await http.get(
      Uri.encodeFull(pollingStations),
      headers: {
      "Accept": "application/json"
     }
    );

    var votingCentersBody = json.decode(votingCentersJson.body);
    var pollingStationsBody = json.decode(pollingStationsJson.body);
    votingCenterChange(votingCentersBody);
    pollingStationChange(pollingStationsBody);
    


 
  }



  dispose() {

    _votingCenterController.close();
    _pollingStationController.close();
    
   
  }

}