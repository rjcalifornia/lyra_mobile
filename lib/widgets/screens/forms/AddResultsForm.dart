import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//import 'package:lyra_mobile/api/lyra_api_endpoints.dart';
import 'package:lyra_mobile/bloc/api_bloc.dart';
//import 'dart:convert';

import 'package:lyra_mobile/bloc/results_bloc.dart';

class AddResultsFormWidget extends StatefulWidget {
  AddResultsFormWidget({Key key}) : super(key: key);

  @override
  _AddResultsFormWidgetState createState() => _AddResultsFormWidgetState();
}

class _AddResultsFormWidgetState extends State<AddResultsFormWidget> {
  List tempList = List();
  
  String _center;
  String _station;

  ResultsBloc _textBloc = ResultsBloc();
  GetApiBloc _apiBloc = GetApiBloc();



  @override
  void initState() {
    // _apiBloc.isLoadingChange(true);

    super.initState();
    _apiBloc.getVotingCenters();
//_apiBloc.isLoadingChange(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[100],
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Agregar resultados de Acta",
                  style: Theme.of(context).textTheme.headline4.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(
                  height: 22,
                ),
                /*    isLoading == true ?      
Container(
                    child: CircularProgressIndicator(),
                  ):*/
                Column(
                  children: <Widget>[
                    StreamBuilder(
                      stream: _apiBloc.streamVoting,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Container(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return new Container(
                            child: Column(
                              children: <Widget>[
                                DropdownButton(
                                  icon: Icon(Icons.map),
                                  isExpanded: true,
                                  items: _apiBloc.votingCenter.map((item) {
                                    return new DropdownMenuItem(
                                      child: new Text(item['name']),
                                      value: item['id'].toString(),
                                    );
                                  }).toList(),
                                  onChanged: (newVal) {
                                    setState(() {
                                      _center = newVal;

                                      _textBloc.centerChange(_center);

                                      tempList = _apiBloc.pollingStation
                                          .where((x) =>
                                              x['voting_center_id']
                                                  .toString() ==
                                              _center)
                                          .toList();
                                      _station = null;
                                    });
                                  },
                                  value: _center,
                                  hint: Text('Seleccione centro de votación'),
                                ),
                                SizedBox(
                                  height: 22,
                                ),
                                new DropdownButton(
                                  icon: Icon(Icons.gps_fixed),
                                  isExpanded: true,
                                  items: tempList.map((item) {
                                    return new DropdownMenuItem(
                                      child: new Text(
                                          item['poll_station'].toString()),
                                      value: item['poll_station'].toString(),
                                    );
                                  }).toList(),
                                  onChanged: (newVal) {
                                    print(newVal);
                                    setState(() {
                                      _station = newVal;
                                      _textBloc.stationChange(_station);
                                      print(_station);
                                    });
                                  },
                                  value: _station,
                                  hint: Text('Seleccione JRV'),
                                )
                              ],
                            ),
                          );
                        }
                      },
                    ),

/*
             
*/
                    SizedBox(
                      height: 32,
                    ),
                    StreamBuilder(
                      stream: _textBloc.leftoversStream,
                      builder: (ctx, AsyncSnapshot<String> leftoverStream) {
                        return TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Sobrantes",
                            errorText: leftoverStream.hasError
                                ? leftoverStream.error
                                : null,
                          ),
                          onChanged: (String text) =>
                              _textBloc.leftoversChange(text),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                      stream: _textBloc.unusedStream,
                      builder: (ctx, AsyncSnapshot<String> unusedStream) {
                        return TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Inutilizadas",
                            errorText: unusedStream.hasError
                                ? unusedStream.error
                                : null,
                          ),
                          onChanged: (String text) =>
                              _textBloc.unusedChange(text),
                        );
                      },
                    ),
                    SizedBox(
                      height: 38,
                    ),
                    StreamBuilder(
                      stream: _textBloc.fmlnStream,
                      builder: (ctx, AsyncSnapshot<String> fmlnStream) {
                        return TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Votos FMLN",
                              errorText:
                                  fmlnStream.hasError ? fmlnStream.error : null,
                              icon: Icon(Icons.date_range)),
                          onChanged: (String text) =>
                              _textBloc.fmlnChange(text),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                      stream: _textBloc.ganaStream,
                      builder: (ctx, AsyncSnapshot<String> ganaStream) {
                        return TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Votos GANA",
                              errorText:
                                  ganaStream.hasError ? ganaStream.error : null,
                              icon: Icon(Icons.date_range)),
                          onChanged: (String text) =>
                              _textBloc.ganaChange(text),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                      stream: _textBloc.vamosStream,
                      builder: (ctx, AsyncSnapshot<String> vamosStream) {
                        return TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Votos VAMOS",
                              errorText: vamosStream.hasError
                                  ? vamosStream.error
                                  : null,
                              icon: Icon(Icons.date_range)),
                          onChanged: (String text) =>
                              _textBloc.vamosChange(text),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                      stream: _textBloc.arenaStream,
                      builder: (ctx, AsyncSnapshot<String> arenaStream) {
                        return TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Votos ARENA",
                              errorText: arenaStream.hasError
                                  ? arenaStream.error
                                  : null,
                              icon: Icon(Icons.date_range)),
                          onChanged: (String text) =>
                              _textBloc.arenaChange(text),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                      stream: _textBloc.pcnStream,
                      builder: (ctx, AsyncSnapshot<String> pcnStream) {
                        return TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Votos PCN",
                              errorText:
                                  pcnStream.hasError ? pcnStream.error : null,
                              icon: Icon(Icons.date_range)),
                          onChanged: (String text) => _textBloc.pcnChange(text),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                      stream: _textBloc.pdcStream,
                      builder: (ctx, AsyncSnapshot<String> pdcStream) {
                        return TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Votos PDC",
                              errorText:
                                  pdcStream.hasError ? pdcStream.error : null,
                              icon: Icon(Icons.date_range)),
                          onChanged: (String text) => _textBloc.pdcChange(text),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                      stream: _textBloc.dsStream,
                      builder: (ctx, AsyncSnapshot<String> dsStream) {
                        return TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Votos DS",
                              errorText:
                                  dsStream.hasError ? dsStream.error : null,
                              icon: Icon(Icons.date_range)),
                          onChanged: (String text) => _textBloc.dsChange(text),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                      stream: _textBloc.alliesStream,
                      builder: (ctx, AsyncSnapshot<String> allianceStream) {
                        return TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Votos COALICION ARENA-PCN-PDC-DS",
                              errorText: allianceStream.hasError
                                  ? allianceStream.error
                                  : null,
                              icon: Icon(Icons.date_range)),
                          onChanged: (String text) =>
                              _textBloc.alliesChange(text),
                        );
                      },
                    ),
                    SizedBox(
                      height: 38,
                    ),
                    StreamBuilder(
                      stream: _textBloc.impugnadosStream,
                      builder: (ctx, AsyncSnapshot<String> impugnadosStream) {
                        return TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Impugnados",
                              errorText: impugnadosStream.hasError
                                  ? impugnadosStream.error
                                  : null,
                              icon: Icon(Icons.find_in_page)),
                          onChanged: (String text) =>
                              _textBloc.impugnadosChange(text),
                        );
                      },
                    ),


                     SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                      stream: _textBloc.nulosStream,
                      builder: (ctx, AsyncSnapshot<String> nulosStream) {
                        return TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Nulos",
                              errorText: nulosStream.hasError
                                  ? nulosStream.error
                                  : null,
                              icon: Icon(Icons.error_outline)),
                          onChanged: (String text) =>
                              _textBloc.nulosChange(text),
                        );
                      },
                    ),


                     SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                      stream: _textBloc.abstencionesStream,
                      builder: (ctx, AsyncSnapshot<String> abstencionesStream) {
                        return TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Abstenciones",
                              errorText: abstencionesStream.hasError
                                  ? abstencionesStream.error
                                  : null,
                              icon: Icon(Icons.not_interested)),
                          onChanged: (String text) =>
                              _textBloc.abstencionesChange(text),
                        );
                      },
                    ),


                     SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                      stream: _textBloc.escrutadosStream,
                      builder: (ctx, AsyncSnapshot<String> escrutadosStream) {
                        return TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Escrutados",
                              errorText: escrutadosStream.hasError
                                  ? escrutadosStream.error
                                  : null,
                              icon: Icon(Icons.show_chart)),
                          onChanged: (String text) =>
                              _textBloc.escrutadosChange(text),
                        );
                      },
                    ),
                   
                    SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                      stream: _textBloc.faltantesStream,
                      builder: (ctx, AsyncSnapshot<String> faltantesStream) {
                        return TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Faltantes",
                              errorText: faltantesStream.hasError
                                  ? faltantesStream.error
                                  : null,
                              icon: Icon(Icons.center_focus_strong)),
                          onChanged: (String text) =>
                              _textBloc.faltantesChange(text),
                        );
                      },
                    ),

                     SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                      stream: _textBloc.entregadosStream,
                      builder: (ctx, AsyncSnapshot<String> entregadosStream) {
                        return TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Entregados",
                              errorText: entregadosStream.hasError
                                  ? entregadosStream.error
                                  : null,
                              icon: Icon(Icons.receipt)),
                          onChanged: (String text) =>
                              _textBloc.entregadosChange(text),
                        );
                      },
                    ),
                    
                    
                    
                    SizedBox(
                      height: 32,
                    ),
                    Row(
                      children: <Widget>[

                        StreamBuilder(
                          stream: _textBloc.validateFormStream,
                          builder: (ctx, AsyncSnapshot snapshot){
                          if(!snapshot.hasData){
                            return Container(
                              child: Column(
                                children: <Widget>[
                                  Text("Llene todos los campos para poder transmitir resultados", style: TextStyle(fontWeight: FontWeight.bold,))
                                ],
                              ),
                            );
                          }
                          else{

                            return    
                          Expanded(
                          child: Container(
                            height: 50,
                            child: RaisedButton(
                              child: Text(
                                "Enviar resultados",
                                style:
                                    Theme.of(context).textTheme.button.copyWith(
                                          color: Colors.white,
                                        ),
                              ),
                              onPressed: () {
                                _textBloc.sendResults(context);

                              //  Navigator.pushReplacementNamed(context, '/');
                              },
                              color: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                        );
                   
                          }
                          },

                        ),


                         ],
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
