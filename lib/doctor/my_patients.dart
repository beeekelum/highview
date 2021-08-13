import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MyPatients extends StatefulWidget {
  const MyPatients({Key key}) : super(key: key);

  @override
  _MyPatientsState createState() => _MyPatientsState();
}

class _MyPatientsState extends State<MyPatients> {
  final _formKey = GlobalKey<FormBuilderState>();

  String messageBody;
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Stream<QuerySnapshot> _appointmentsStream =
    FirebaseFirestore.instance.collection('appointments')
        .where('doctorId', isEqualTo: _auth.currentUser.uid)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients chat'),
      ),
      body: StreamBuilder<QuerySnapshot>(
      stream: _appointmentsStream,
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
            document.data() as Map<String, dynamic>;
            return
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 1,
                    child: ListTile(
                      title: Text('${data['fullName']}'),
                      leading: CircleAvatar(child: Icon(Icons.person),),
                      trailing: TextButton(
                        onPressed: () {
                        },
                        child: Text("Chat"),
                      ),
                    ),
                  ),
                );
          }).toList(),
        );
      },
    ),
    );
  }
}
