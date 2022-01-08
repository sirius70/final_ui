import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/model/slotModel.dart';

class slotDetails extends StatefulWidget {
  final SlotModel slotDetail;

  const slotDetails({key, this.slotDetail}) : super(key: key);
  @override
  _slotDetailsState createState() => _slotDetailsState();
}

class _slotDetailsState extends State<slotDetails> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text('Slot Deatails'),
        toolbarHeight: 75,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            gradient: LinearGradient(
                colors: [Colors.teal.shade400, Colors.grey],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,

      body: StreamBuilder(

      ),
    );
  }
}