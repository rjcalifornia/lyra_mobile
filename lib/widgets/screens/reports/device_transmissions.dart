import 'package:flutter/material.dart';
import 'package:lyra_mobile/bloc/reportes_bloc.dart';

class ReporteEnviosWidget extends StatefulWidget {
  ReporteEnviosWidget({Key key}) : super(key: key);

  @override
  _ReporteEnviosWidgetState createState() => _ReporteEnviosWidgetState();
}

class _ReporteEnviosWidgetState extends State<ReporteEnviosWidget> {
  GetReportsBloc _reportsBloc = GetReportsBloc();

  @override
  void initState() {


    _reportsBloc.getDeviceTransmissions();
    super.initState();
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
        body: SingleChildScrollView(

          padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                 Text(
                  "Transmisiones",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(
                  height: 22,
                ),

                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                       StreamBuilder(
                  stream: _reportsBloc.streamTransmissions,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(!snapshot.hasData)
                    {
                       return Container(
                            child: CircularProgressIndicator(),
                          );
                    } else {
                      var transmissionList = _reportsBloc.deviceTransmissions.toList();
                      return new Container(
                        height: MediaQuery.of(context).size.height / 1.34, 
                        color: Color(0xffffffff),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 1.0),
                            child: ListView.separated(
                              physics: ClampingScrollPhysics(),
                              separatorBuilder:
                                (BuildContext context, int index) {
                                   return SizedBox(
                                height: 10,
                              );
                            },
                            scrollDirection: Axis.vertical,
                            itemCount: transmissionList ==  null ? 1 : transmissionList.length + 1,
                            itemBuilder: (ctx, i){
                              if (i == 0) {
                              return Card(
                                elevation: 3.0,
                                    margin: new EdgeInsets.symmetric(
                                        horizontal: 6.0, vertical: 4.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(64, 75, 96, .9)),
                                                child: ListTile(
                                                  onTap: null,
                                                   title: Row(children: <Widget>[
                                            
                                            new Expanded(
                                                child: new Text(
                                              "Centro",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                             

                                            new Expanded(
                                                child: new Text(
                                              "JRV",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),

                                            new Expanded(
                                                child: new Text(
                                              "Escrutados",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),

                                             
                                            
                                          ]),
                                                ),
                                        ),
                              );
                              }

                               i -= 1;
                               return GestureDetector(
                                 child: Card(
                                 elevation: 2.0,
                                  margin: new EdgeInsets.symmetric(
                                      horizontal: 6.0, vertical: 2.0),
                                      child: Container(
                                         decoration: BoxDecoration(
                                          color: Color(0xfff5f6f5)),
                                      child: ListTile(
                                        title: Row(
                                          children: <Widget>[
                                            //GestureDetector(
                                               Expanded(
                                              child: Text(transmissionList[i]['centro_votacion']),
                                               ),
                                            
                                             new Expanded(
                                              child: Text(transmissionList[i]['jrv'].toString()),
                                            ),

                                            new Expanded(
                                              child: Text(transmissionList[i]['escrutados'].toString()),
                                            ),

                                              
                                          ],
                                        ),
                                      )
                                      ),
                               ),
                               onTap: (){
                                 //print(test[i]['jrv'].toString());
                                 showDialog(
                                   context: context,
                                   builder: (BuildContext context){
                                     return AlertDialog(
          title: Text("Detalle de la Transmisión"),
          content: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Número de JRV: "),
                    Text(transmissionList[i]['jrv'].toString()),
                  ],
                ),  

                Row(
                  children: <Widget>[
                    Text("Sobrantes: "),
                    Text(transmissionList[i]['sobrantes'].toString()),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Text("Inutilizadas: "),
                    Text(transmissionList[i]['inutilizadas'].toString()),
                  ],
                ),

                SizedBox(height: 14,),

                Row(
                  children: <Widget>[
                    Text("Votos FMLN: "),
                    Text(transmissionList[i]['votos_fmln'].toString()),
                  ],
                ),

                SizedBox(height: 2,),

                Row(
                  children: <Widget>[
                    Text("Votos GANA "),
                    Text(transmissionList[i]['votos_gana'].toString()),
                  ],
                ),

                SizedBox(height: 2,),

                Row(
                  children: <Widget>[
                    Text("Votos VAMOS: "),
                    Text(transmissionList[i]['votos_vamos'].toString()),
                  ],
                ),

                
                SizedBox(height: 2,),

                Row(
                  children: <Widget>[
                    Text("Votos ARENA: "),
                    Text(transmissionList[i]['votos_arena'].toString()),
                  ],
                ),

                
                SizedBox(height: 2,),

                Row(
                  children: <Widget>[
                    Text("Votos PCN: "),
                    Text(transmissionList[i]['votos_pcn'].toString()),
                  ],
                ),

                
                SizedBox(height: 2,),

                Row(
                  children: <Widget>[
                    Text("Votos PDC: "),
                    Text(transmissionList[i]['votos_pdc'].toString()),
                  ],
                ),

                
                SizedBox(height: 2,),

                Row(
                  children: <Widget>[
                    Text("Votos DS: "),
                    Text(transmissionList[i]['votos_ds'].toString()),
                  ],
                ),

                
                SizedBox(height: 2,),

                Row(
                  children: <Widget>[
                    Text("COALICION ARENA: "),
                    Text(transmissionList[i]['votos_coalicion'].toString()),
                  ],
                ),

                
                SizedBox(height: 16,),

                Row(
                  children: <Widget>[
                    Text("Impugnados: "),
                    Text(transmissionList[i]['impugnados'].toString()),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Text("Nulos: "),
                    Text(transmissionList[i]['nulos'].toString()),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Text("Abstenciones: "),
                    Text(transmissionList[i]['abstenciones'].toString()),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Text("Escrutados: "),
                    Text(transmissionList[i]['escrutados'].toString()),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Faltantes: "),
                    Text(transmissionList[i]['faltantes'].toString()),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Text("Entregados: "),
                    Text(transmissionList[i]['entregados'].toString()),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            FlatButton(
        child: Text("Cerrar"),
        onPressed: (){
          Navigator.of(context).pop();
        },
      )
          ]
        );
                                   }
                                 );
                               },
                               );
                            },
                            
                            ),
                      );

                    }
                  }
                  )
          
                    ],
                  ),

                ),

                   ],
            )


        )
    );
  }
}