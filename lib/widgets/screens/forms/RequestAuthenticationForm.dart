import 'package:flutter/material.dart';
import 'package:lyra_mobile/bloc/authentication_bloc.dart';

class RequestAuthenticationForm extends StatefulWidget {
  RequestAuthenticationForm({Key key}) : super(key: key);

  @override
  _RequestAuthenticationFormState createState() => _RequestAuthenticationFormState();
}

class _RequestAuthenticationFormState extends State<RequestAuthenticationForm> {
  AuthenticationBloc _authBloc = AuthenticationBloc();
  @override
  void initState() { 
   
    super.initState();
    
  }
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
                  "Autenticar dispositivo para transmitir",
                  style: Theme.of(context).textTheme.headline4.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(
                  height: 22,
                ),

                StreamBuilder(
                  stream: _authBloc.phoneNumberStream,
                  builder: (ctx, AsyncSnapshot<String> phoneNumberStream) {
                    return TextField(
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                            labelText: "Ingrese su número de teléfono con guiones",
                            errorText: phoneNumberStream.hasError
                                ? phoneNumberStream.error
                                : null,
                          ),
                          onChanged: (String text){
                            _authBloc.phoneNumberChange(text);
                          },
                    );
                  }
                  

                ),
                SizedBox(
                  height: 38,
                ),
Row(
                      children: <Widget>[
                StreamBuilder(
                  stream: _authBloc.phoneNumberStream,
                  builder: (ctx, AsyncSnapshot snapshot){
                    if(!snapshot.hasData){
                            return Container(
                              child: Column(
                                children: <Widget>[
                                  Text("Ingrese su número de teléfono para validar el dispositivo", style: TextStyle(fontWeight: FontWeight.bold,))
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
                                "Autenticar teléfono",
                                style:
                                    Theme.of(context).textTheme.button.copyWith(
                                          color: Colors.white,
                                        ),
                              ),
                              onPressed: () {
                                _authBloc.requestDeviceAuthentication(context);

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
                  }
                )
              ])
          
              ],
            ),
          ),

        ),

    );
  }
}