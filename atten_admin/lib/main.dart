
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:qr_flutter/qr_flutter.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendence Admin',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
     body: SingleChildScrollView(
       child:generateQR(),
     ),
    );
  }
}

class generateQR extends StatefulWidget {
  
  @override
  _generateQRState createState() => _generateQRState();
}

class _generateQRState extends State<generateQR> {
  String hash;

  @override
  void initState(){
    hash = 'null';
    super.initState();
  }
  TextEditingController eventNameController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(40),
            child: TextField(
              
              controller: eventNameController,
              decoration: InputDecoration(
                hintText: 'Event Name',
                focusColor: Colors.black,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(27.5),
                  gapPadding: 4.0,
                ),
              ),
              keyboardType: TextInputType.text,             
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom:80,),
            child: FloatingActionButton.extended(
               onPressed: () async{
                    Map data = {
                        "eventName" : eventNameController.text,
                    };
                    var url = "http://192.168.42.116:8000/";
                    http.post(url, body: data).then((response){
                      setState(() {
                        hash = response.body;
                        print(hash);
                      });
                    });
                },
              label: Text('Generate Qr'),
              backgroundColor: Colors.black,
            ),
          ),
          Container(
            height: 300,
            child:qrCode(hash),
            
          )
        ],
      ),
    );
  }
  Widget qrCode(String hash){
  if(hash == 'null'){
    return Text(
       'Enter the Event name'
    );
  }else{
    return QrImage(
                 data: hash,
                 version: QrVersions.auto,
                 embeddedImage: AssetImage('assets/google-logo.png'),
                 size: 300.0,
            );
  }

  
}
}
