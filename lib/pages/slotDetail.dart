import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/common/theme_helper.dart';
import 'package:login_ui/model/slotModel.dart';
import 'package:intl/intl.dart';

class slotDetails extends StatefulWidget {
  //final SlotModel slotModel;
  final String id;

  const slotDetails({key, this.id}) : super(key: key);

  @override
  _slotDetailsState createState() => _slotDetailsState();
}

class _slotDetailsState extends State<slotDetails> {
  var slotDetails;

  getSuggestion(String UID) => FirebaseFirestore.instance
      .collection('slotDetails')
      .where('uid', isEqualTo: "SWQvViVudHceOjcCn4mRcLNFC8z2")
      .snapshots();

  // String formattedDate = DateFormat('yyyy-MM-dd – kk:mm'). format(dateFromFirebase);

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
      body: StreamBuilder(
        stream: getSuggestion(widget.id),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            child: ListView(
              children: snapshot.data.docs.map((document) {
                return Card(
                  child: ListTile(
                    title: Text(document['stationId']),
                    subtitle: Text(document['slotTiming']),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
// body: Center(
// child: Stack(
// children: [
//   Image.network(slotModel.uid),
//   Text(slotModel.stationId),
//   Text(slotModel.slotTiming),
//   Text(slotModel.date),
// SizedBox(height: 50),
// Container(
// decoration: ThemeHelper().buttonBoxDecoration(context),
// child: ElevatedButton(
// style: ThemeHelper().buttonStyle(),
// ),
// ),
// ],),),
