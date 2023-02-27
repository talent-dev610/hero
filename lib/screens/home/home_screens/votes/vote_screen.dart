import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hero/models/models.dart';

class VoteScreen extends StatefulWidget {
  @override
  _VoteScreenState createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  String name = "";
  bool searching = false;
  int changeCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.search, color: Colors.black),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              child: TextField(
                onChanged: (val) {
                  initiateSearch(val);
                  changeCount++;
                  if (changeCount > 6) {
                    changeCount = 0;
                  }
                },
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: name != "" && changeCount == 1
            ? FirebaseFirestore.instance
                .collection('users')
                .limit(6)
                .where("name", isGreaterThanOrEqualTo: name)
                .snapshots()
            : null,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading...');
            default:
              if (name != '') {
                if (snapshot.hasData == true) {
                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      return ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, 'userVotePage',
                              arguments: _userDataFromSnapshot(document));
                        },
                        title: Text(document['name']),
                        leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                          (document['imageUrls'][0]),
                        )),
                      );
                    }).toList(),
                  );
                } else {
                  return Center(child: Text('bruh'));
                }
              } else {
                return Text('bruh');
              }
          }
        },
      ),
    );
  }

  void initiateSearch(String val) {
    setState(() {
      name = val.toLowerCase().trim();
    });
  }
}

User? _userDataFromSnapshot(DocumentSnapshot snapshot) {
  return User(
      id: snapshot['id'],
      name: snapshot['name'],
      age: snapshot['age'],
      imageUrls: snapshot['imageUrls'],
      interests: snapshot['interests'],
      jobTitle: snapshot['jobTitle'],
      bio: snapshot['bio'],
      isStingray: snapshot['isStingray'],
      email: snapshot['email'],
      team: snapshot['team'],
      votes: snapshot['votes'],
      votesUsable: snapshot['votesUsable'],
      isRude: snapshot['isRude'],
      stingrays: snapshot['stingrays'],
      finishedOnboarding: snapshot['finishedOnboarding'],
      instigations: snapshot['instigations']);
}
