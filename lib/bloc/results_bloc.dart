import 'dart:convert';
import 'package:device_id/device_id.dart';
import 'package:flutter/material.dart';
import 'package:lyra_mobile/api/lyra_api_endpoints.dart';
import 'package:lyra_mobile/validators/form_validation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/streams.dart';
import 'package:http/http.dart' as http;
import 'dart:async';


class ResultsBloc with LyraValidators{

final BehaviorSubject<String> _leftoversController = new BehaviorSubject<String>();
final BehaviorSubject<String> _unusedController = new BehaviorSubject<String>();
final BehaviorSubject<String> _centerController = new BehaviorSubject<String>();
final BehaviorSubject<String> _stationController = new BehaviorSubject<String>();

final BehaviorSubject<String> _fmlnController = new BehaviorSubject<String>();
final BehaviorSubject<String> _ganaController = new BehaviorSubject<String>();
final BehaviorSubject<String> _vamosController = new BehaviorSubject<String>();
final BehaviorSubject<String> _arenaController = new BehaviorSubject<String>();
final BehaviorSubject<String> _pcnController = new BehaviorSubject<String>();
final BehaviorSubject<String> _pdcController = new BehaviorSubject<String>();
final BehaviorSubject<String> _dsController = new BehaviorSubject<String>();
final BehaviorSubject<String> _alliesController = new BehaviorSubject<String>();

final BehaviorSubject<String> _impugnadosController = new BehaviorSubject<String>();
final BehaviorSubject<String> _nulosController = new BehaviorSubject<String>();
final BehaviorSubject<String> _abstencionesController = new BehaviorSubject<String>();
final BehaviorSubject<String> _escrutadosController = new BehaviorSubject<String>();
final BehaviorSubject<String> _faltantesController = new BehaviorSubject<String>();
final BehaviorSubject<String> _entregadosController = new BehaviorSubject<String>();






Function(String) get leftoversChange => _leftoversController.sink.add;
Function(String) get unusedChange => _unusedController.sink.add;
Function(String) get centerChange => _centerController.sink.add;
Function(String) get stationChange => _stationController.sink.add;


Function(String) get fmlnChange => _fmlnController.sink.add;
Function(String) get ganaChange => _ganaController.sink.add;
Function(String) get vamosChange => _vamosController.sink.add;
Function(String) get arenaChange => _arenaController.sink.add;
Function(String) get pcnChange => _pcnController.sink.add;
Function(String) get pdcChange => _pdcController.sink.add;
Function(String) get dsChange => _dsController.sink.add;
Function(String) get alliesChange => _alliesController.sink.add;


Function(String) get impugnadosChange => _impugnadosController.sink.add;
Function(String) get nulosChange => _nulosController.sink.add;
Function(String) get abstencionesChange => _abstencionesController.sink.add;
Function(String) get escrutadosChange => _escrutadosController.sink.add;
Function(String) get faltantesChange => _faltantesController.sink.add;
Function(String) get entregadosChange => _entregadosController.sink.add;





Stream<String> get leftoversStream => _leftoversController.stream.transform(validateField);
Stream<String> get unusedStream => _unusedController.stream.transform(validateField);
Stream<String> get centerStream => _centerController.stream.transform(validateField);
Stream<String> get stationStream => _stationController.stream.transform(validateField);



Stream<String> get fmlnStream => _fmlnController.stream.transform(validateField);
Stream<String> get ganaStream => _ganaController.stream.transform(validateField);
Stream<String> get vamosStream => _vamosController.stream.transform(validateField);
Stream<String> get arenaStream => _arenaController.stream.transform(validateField);
Stream<String> get pcnStream => _pcnController.stream.transform(validateField);
Stream<String> get pdcStream => _pdcController.stream.transform(validateField);
Stream<String> get dsStream => _dsController.stream.transform(validateField);
Stream<String> get alliesStream => _alliesController.stream.transform(validateField);

Stream<String> get impugnadosStream => _impugnadosController.stream.transform(validateField);
Stream<String> get nulosStream => _nulosController.stream.transform(validateField);
Stream<String> get abstencionesStream => _abstencionesController.stream.transform(validateField);
Stream<String> get escrutadosStream => _escrutadosController.stream.transform(validateField);
Stream<String> get faltantesStream => _faltantesController.stream.transform(validateField);
Stream<String> get entregadosStream => _entregadosController.stream.transform(validateField);





String get leftovers => _leftoversController.value;
String get unused => _unusedController.value;
String get center => _centerController.value;
String get station => _stationController.value;


String get fmln => _fmlnController.value;
String get gana => _ganaController.value;
String get vamos => _vamosController.value;
String get arena => _arenaController.value;
String get pcn => _pcnController.value;
String get pdc => _pdcController.value;
String get ds => _dsController.value;
String get allies => _alliesController.value;


String get impugnados => _impugnadosController.value;
String get nulos => _nulosController.value;
String get abstenciones => _abstencionesController.value;
String get escrutados => _escrutadosController.value;
String get faltantes => _faltantesController.value;
String get entregados => _entregadosController.value;


Stream<bool> get validateFormStream => CombineLatestStream.combine9(
  centerStream,
  stationStream,
  leftoversStream,
  unusedStream,
  impugnadosStream,
  nulosStream,
  abstencionesStream,
  faltantesStream,
  entregadosStream,

  (c, s, l, u, i, n, a, f, e){
    if(
    (c == _centerController.value) 
    && (s == _stationController.value)
    && (l == _leftoversController.value)
    && (u == _unusedController.value)
    && (i == _impugnadosController.value)
    && (n == _nulosController.value)
    && (a == _abstencionesController.value)
    && (f == _faltantesController.value)
    && (e == _entregadosController.value)
    
    )
    {
      return true;
    } 
    return null;
  }
);
sendResults(var context) async{
      


    String deviceid = await DeviceId.getID;

try{
  showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return AlertDialog(
              content: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(padding: EdgeInsets.only(left: 15),),
                  Flexible(
                      flex: 8,
                      child: Text(
                        "Transmitiendo resultados...",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            );
          });
      var response = await http.post(Uri.encodeFull(storeResults),
      body: json.encode({
            "centro_votacion": int.parse(center),
            "jrv": int.parse(station),
            "sobrantes": leftovers,
            "inutilizadas": unused,
            "votos_fmln": fmln,
            "votos_gana": gana,
            "votos_vamos": vamos,
            "votos_arena": arena,
            "votos_pcn" : pcn,
            "votos_pdc": pdc,
            "votos_ds" : ds,
            "votos_coalicion" : allies,
            "impugnados": impugnados,
            "nulos": nulos,
            "abstenciones" : abstenciones,
            "escrutados" : escrutados,
            "faltantes" : faltantes,
            "entregados" : entregados,
            "device_id" : deviceid,
          }),
          headers: {
            "Content-Type": "application/json",
            
          }
      
      
      );
      
          Navigator.of(context).pop(true);

if(response.statusCode.toString() == "200")
{
      showDialog(
         barrierDismissible: false,
         child: new AlertDialog(
            title: new Text("Detalles"),
            content: Text("Transmisión realizada correctamente"),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Aceptar'),
                onPressed: () {
                 // Navigator.pushReplacementNamed(context, '/');
                   Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false);
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
            content: Text("Ocurrio un problema al transmitir datos"),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Aceptar'),
                onPressed: () {
                //  Navigator.pushReplacementNamed(context, '/');
                   Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false);
              
                },
                
              ),
            ],
            ),
            context: context,
            

      );
}   }
catch(err){
  Navigator.of(context).pop(true);
  showDialog(
         barrierDismissible: false,
         child: new AlertDialog(
            title: new Text("Detalles"),
            content: Text("No se puede comunicar con el servidor. Intente transmitir los resultados de nuevo."),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                   
                },
              ),
            ],
            ),
            context: context,
            

      );

}
    }


  dispose() {
    _unusedController.close();
    _centerController.close();
    _stationController.close();
    _leftoversController.close();

    _fmlnController.close();
    _ganaController.close();
    _vamosController.close();
    _arenaController.close();
    _pcnController.close();
    _pdcController.close();
    _dsController.close();
    _alliesController.close();
    _impugnadosController.close();
    _escrutadosController.close();
    _entregadosController.close();
    _nulosController.close();
    _abstencionesController.close();
    _faltantesController.close();



  }

}