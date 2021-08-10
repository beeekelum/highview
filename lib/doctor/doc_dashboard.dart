import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:stretchy_header/stretchy_header.dart';

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({Key key}) : super(key: key);

  @override
  _DoctorDashboardState createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  List<String> items = ['Consultations', 'Transactions'];
  List<Color> colors = [Colors.teal, Colors.teal];
  List<String> counts = ['9', '6'];

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return Scaffold(
      backgroundColor: Colors.white,
      body: StretchyHeader.singleChild(
        headerData: HeaderData(
          headerHeight: 200,
          header: UserAccountsDrawerHeader(
            accountName: Text("HighView"),
            accountEmail: Text('${_auth.currentUser.email}'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("HV", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
            ),
            margin: EdgeInsets.zero,
          ),

        ),
        child: Container(
          color: Colors.white,
          child: StaggeredGridView.countBuilder(
            shrinkWrap: true,
            crossAxisCount: 2,
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.all(5.0),
              child: Material(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors[index],
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              items[index],
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(counts[index], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index.isEven ? 2 : 1.5),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
        ),
      ),
    );
  }
}
