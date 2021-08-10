import 'package:flutter/material.dart';

class MyPatients extends StatefulWidget {
  const MyPatients({Key key}) : super(key: key);

  @override
  _MyPatientsState createState() => _MyPatientsState();
}

class _MyPatientsState extends State<MyPatients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients'),
      ),
    );
  }
}
