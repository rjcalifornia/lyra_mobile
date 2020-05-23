import 'package:flutter/material.dart';
import 'package:lyra_mobile/widgets/screens/ui/lyra_options.dart';
import 'package:lyra_mobile/widgets/screens/ui/lyra_reports.dart';
//import 'package:device_id/device_id.dart';
//import 'dart:async';

class LyraApp extends StatefulWidget {
  LyraApp({Key key}) : super(key: key);

  @override
  _LyraAppState createState() => _LyraAppState();
}

class _LyraAppState extends State<LyraApp> {
  int _currentPage = 0;
  final List<Widget> _pages = [
    LyraOptionsScreen(),
    LyraReportsScreen(),

  ];

  getDevice() async {
  //  String deviceid = await DeviceId.getID;
   // print(deviceid);
    
  }

@override
  void initState() {
   // getDevice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff9f9f9),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xfff5f5f5),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.redAccent,
        currentIndex: _currentPage,
            onTap: (i){
              setState(() {
                _currentPage = i;
              });
            },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            title: Text("Inicio"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_special),
            title: Text("Reportes"),
          ), 
        ],
      ), 


      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Color(0xfff9f9f9),
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: _pages[_currentPage],
    );
  }
}