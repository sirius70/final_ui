import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/model/feedModel.dart';
import 'package:login_ui/model/stationModel.dart';
import 'package:login_ui/model/user_model.dart';

class slotDetails extends StatefulWidget {

  @override
  _slotDetailsState createState() => _slotDetailsState();
}

class _slotDetailsState extends State<slotDetails> {

  // final StationModel stationModel;
  // const slotDetails({key,this.stationModel}) : super(key: key);

  StationModel stationModel = StationModel();
  UserModel userModel = UserModel();
  FeedModel feedModel = FeedModel();

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
          builder: (context, snapshot) {

            return Column(
              children: [
                SizedBox(height: 10,),
                //Text('Slot Details',style: TextStyle(fontSize: 20),),
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('feedback')
                        .where('userName', isEqualTo: feedModel.userName)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (!streamSnapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          children: streamSnapshot.data.docs.map((document) {
                            return Card(
                              child: ListTile(
                                title: Text(document['userName']),
                                subtitle: Text(document['stationId']),

                              ),
                            );
                          }).toList(),
                        ),

                      );
                    },
                  ),
                )
              ],
            );
          }
      ),
    );
  }
}