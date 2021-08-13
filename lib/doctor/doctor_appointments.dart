import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highview/doctor/appointment_details.dart';

class DoctorAppointments extends StatefulWidget {
  const DoctorAppointments({Key key}) : super(key: key);

  @override
  _DoctorAppointmentsState createState() => _DoctorAppointmentsState();
}

class _DoctorAppointmentsState extends State<DoctorAppointments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'New'),
                Tab(text: 'Pending'),
                Tab(text: 'Completed'),
              ],
            ),
            title: const Text('Appointments'),
          ),
          body: const TabBarView(
            children: [
              Appointments(
                status: 'New',
              ),
              Appointments(
                status: 'Pending',
              ),
              Appointments(
                status: 'Completed',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Appointments extends StatelessWidget {
  const Appointments({Key key, this.status}) : super(key: key);
  final String status;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Stream<QuerySnapshot> _appointmentsStream = FirebaseFirestore.instance
        .collection('appointments')
        .where('doctorId', isEqualTo: _auth.currentUser.uid)
        .where('status', isEqualTo: status)
        .snapshots();
    CollectionReference appointments = FirebaseFirestore.instance.collection('appointments');

    return StreamBuilder<QuerySnapshot>(
      stream: _appointmentsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text('${data['fullName']}', style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text((data["bookingDate"] as Timestamp)
                              .toDate()
                              .toString()),
                          Text(data['status']),
                        ],
                      ),
                      leading: CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      trailing: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AppointmentDetails(appointmentDetails: document,),
                            ),);
                        },
                        child: Text("View", style: TextStyle(color: Colors.white),),
                        color: Colors.blueAccent,
                      ),
                    ),
                    Row(
                      children: [
                        data['status'] == "New" ? TextButton.icon(
                          onPressed: () {
                            appointments
                                .doc(document.id)
                                .update({'status': 'Pending'})
                                .then((value) => Get.snackbar('HighView', 'Appointment approved'))
                                .catchError((error) => print("Failed to approve : $error"));
                          },
                          icon: Icon(Icons.done),
                          label: Text('Accept'),
                        ) : Container(),
                        data['status'] == "New" ? TextButton.icon(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => Center(
                                  child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Material(
                                            child: Column(
                                              children: [
                                                TextField(
                                                  maxLines: 3,

                                                  decoration: InputDecoration(
                                                    fillColor: Colors.grey[300],
                                                    icon: Icon(Icons.note),
                                                    labelText: 'Reason for declining',

                                                  ),
                                                  onChanged: (String value) {

                                                  },
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {

                                                  },
                                                  child: Text(
                                                    'Decline',
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                      ],)

                                  ),
                                ));
                            // appointments
                            //     .doc(document.id)
                            //     .update({'status': 'Declined'})
                            //     .then((value) => Get.snackbar('HighView', 'Appointment declined'))
                            //     .catchError((error) => print("Failed to approve : $error"));
                          },
                          icon: Icon(Icons.cancel),
                          label: Text('Decline'),
                        ) : Container(),
                        data['status'] == "Pending" ? TextButton.icon(
                          onPressed: () {
                            appointments
                                .doc(document.id)
                                .update({'status': 'Completed'})
                                .then((value) => Get.snackbar('HighView', 'Appointment completed'))
                                .catchError((error) => print("Failed to approve : $error"));
                          },
                          icon: Icon(Icons.done),
                          label: Text('Complete'),
                        ) : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
