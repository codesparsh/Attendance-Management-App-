import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   String qrText ="Hello";
  Future _qrCode() async{

     try{
      String qrResult =await BarcodeScanner.scan();
      setState(() {
        qrText = qrResult;
      });
     }on PlatformException catch(ex){
       if(ex.code == BarcodeScanner.CameraAccessDenied){
          setState(() {
            qrText = "Camera access denied";
          });
       }else{
         setState(() {
           qrText = "unknown error $ex";
         });
       }
     }on FormatException {
        setState(() {
          qrText = "you pressed the back button without scanning anything";
        });
     }catch(ex){
        setState(() {
          qrText = "unknown error $ex";
        });
     }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendence',style: TextStyle(color: Colors.white),),
        centerTitle: true,  
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(qrText),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _qrCode,
        child: Text('Scan'),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
