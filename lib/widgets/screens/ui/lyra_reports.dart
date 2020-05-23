import 'package:flutter/material.dart';

class LyraReportsScreen extends StatefulWidget {
  LyraReportsScreen({Key key}) : super(key: key);

  @override
  _LyraReportsScreenState createState() => _LyraReportsScreenState();
}

class _LyraReportsScreenState extends State<LyraReportsScreen> {
  @override
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
            child: Image.asset('assets/report.png', width: 65,),
          ),

          Text(
                "Reportes",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
              ),

               SizedBox(height: 28,),

               GestureDetector(
                 onTap: (){
              Navigator.pushNamed(context, '/reports/get-transmissions/');
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
                 Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                        Icon(Icons.send),
                        SizedBox(width: 6,),
                Text("Ver resultados enviados"),
                     ],
                   )
              ],
            ),
            
            ),
            )
        ],
      )
      

    );
  }
}