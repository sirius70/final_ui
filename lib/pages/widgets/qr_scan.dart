import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_ui/common/theme_helper.dart';

import '../feedback.dart';

// void main() => runApp(MaterialApp(
//   debugShowCheckedModeBanner: false,
//   home: HomePage(),
// ));

class qrCode extends StatefulWidget {

  qrCode({Key key, this.stationModelid}) : super(key: key);
  @override
  qrCodeState createState() {
    return new qrCodeState();
  }

  final String stationModelid;
}

class qrCodeState extends State<qrCode> {
  String result = "Scan the code to claim your slot!!";
  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "Slot Claimed!!!";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.message),
          onPressed: () async{
            QuerySnapshot querySnap = await FirebaseFirestore.instance.collection('stations').where('stationId', isEqualTo: widget.stationModelid).get();
            QueryDocumentSnapshot doc = querySnap.docs[0];  // Assumption: the query returns only one document, THE doc you are looking for.
            DocumentReference docRef = doc.reference;

            await FirebaseFirestore.instance.collection('stations').doc(docRef.id);

            Navigator.push(context, MaterialPageRoute(builder: (context) => FeedBack(stationId: widget.stationModelid,)));
          },
        ),
        centerTitle: true,
        title: Text('QR Scanner'),
        toolbarHeight: 75,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            gradient: LinearGradient(
                colors: [Colors.teal.shade400, Colors.grey],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
          ),
        ),
      ),
      backgroundColor: Colors.white,

      body: Center(
        // child: Column(
        //     children: [
        child: Text(
          result,
          style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        // SizedBox(height: 500),
        // Container(
        //   decoration: ThemeHelper().buttonBoxDecoration(
        //       context),
        //   child: ElevatedButton(
        //     style: ThemeHelper().buttonStyle(),
        //     onPressed: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(
        //               builder: (context) =>
        //                   FeedBack()));
        //     }, //after login redirect to homepage
        //     child: Padding(
        //       padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
        //       child: Text('Feedback'.toUpperCase(),
        //           style: TextStyle(fontSize: 20,
        //               fontWeight: FontWeight.bold,
        //               color: Colors.white)),
        //     ),
        //   ),
        // ),
        //  ]
        //)
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal.shade400,
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,



    );
  }
}