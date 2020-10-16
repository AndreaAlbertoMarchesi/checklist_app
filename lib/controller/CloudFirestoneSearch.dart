import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CloudFirestoneSearch extends StatefulWidget {
  @override
  _CloudFirestoneSearchState createState() => _CloudFirestoneSearchState();
}

class _CloudFirestoneSearchState extends State<CloudFirestoneSearch> {
  String title ="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                title = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (title != "" && title != null)
            ? FirebaseFirestore.instance
            .collection('tasks')
            .where("caseSearch", arrayContains: title)
            .snapshots()
            : FirebaseFirestore.instance.collection("tasks").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot data = snapshot.data.docs[index];
              return Card(
                child: Text(
                  data['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
