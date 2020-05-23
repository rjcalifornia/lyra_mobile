import 'package:flutter/material.dart';
import 'package:lyra_mobile/bloc/authentication_bloc.dart';
import 'package:lyra_mobile/bloc/reportes_bloc.dart';


class LyraOptionsScreen extends StatefulWidget {
  LyraOptionsScreen({Key key}) : super(key: key);

  @override
  _LyraOptionsScreenState createState() => _LyraOptionsScreenState();
}

class _LyraOptionsScreenState extends State<LyraOptionsScreen> {
  AuthenticationBloc _authBloc = AuthenticationBloc();


  @override
  void initState() { 
    _authBloc.getDeviceStatus();
    super.initState();
    
  }
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
                           // color: Colors.blueGrey,
            ),
            child: Image.asset('assets/elections.png', width: 65,),
          ),
          SizedBox(height: 10,),
          Text(
                "Lyra Electoral App",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
              ),
           
          SizedBox(height: 28,),
          Text("Elija una opción:",
          style: Theme.of(context).textTheme.headline6.apply(
                    fontWeightDelta: 2,)
          ),

          SizedBox(height: 28,),

          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
          StreamBuilder(
            stream: _authBloc.streamDeviceStatus,
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if (!snapshot.hasData) {
                          return Container(
                            child: CircularProgressIndicator(),
                          );
                        }

                        else{

                          if(_authBloc.deviceStatus == '200')
                          {
                            return  GestureDetector(

            onTap: (){
              Navigator.pushNamed(context, '/options/register-votes/');
           },

            child: Container(
              height: 80,
              constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
              decoration: BoxDecoration(
              color:  Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                        Icon(Icons.playlist_add_check),
                        SizedBox(width: 6,),
                Text("Agregar resultado de acta"),
                     ],
                   )
                 ],
               )
              ],
            ),
            ),

          );

                          }

                          if(_authBloc.deviceStatus == '404')
                          {
                            return 
      GestureDetector(

            onTap: (){
             // _authBloc.getDevicePhoneNumber();
              Navigator.pushNamed(context, '/options/authenticate-device/');
           },

            child: Container(
              height: 80,
              constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
              decoration: BoxDecoration(
              color:  Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                        Icon(Icons.lock_open),
                        SizedBox(width: 6,),
                Text("Autenticar teléfono"),
                     ],
                   )
                 ],
               )
              ],
            ),
            ),

          );

                          }

                          if(_authBloc.deviceStatus == '403')
                          {
                            return Container();
                          }

                        }

            },

          ),

         
              ],
            ),

          ),



        ],
      ),
    );
  }
}