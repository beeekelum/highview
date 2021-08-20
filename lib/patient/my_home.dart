import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:highview/patient/get_meal_plans.dart';
import 'package:stretchy_header/stretchy_header.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List<String> items = ['Consultations'];
  List<Color> colors = [Colors.blueGrey];
  List<String> counts = ['2'];

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
              child: Text(
                "HV",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
            margin: EdgeInsets.zero,
          ),
        ),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: StaggeredGridView.countBuilder(
                shrinkWrap: true,
                crossAxisCount: 2,
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Material(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors[index],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  items[index],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                ),
                                Text(
                                  counts[index],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                staggeredTileBuilder: (int index) =>
                    new StaggeredTile.count(2, index.isEven ? 1 : 1),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MealPlan()));
                    },
                    child: Container(
                      height: 120,
                      width: 400,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/meal.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            color: Colors.black.withOpacity(.6),
                          ),
                          Center(
                            child: Text(
                              'Meals and Exercises',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ) /* add child content here */,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    child: Container(
                      height: 120,
                      width: 400,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/emerg.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            color: Colors.black.withOpacity(.6),
                          ),
                          Center(
                            child: Text(
                              'Emergency contacts',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ) /* add child content here */,
                    ),
                    onTap: () {
                      final ButtonStyle raisedButtonStyle = ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(color: Colors.blueGrey),
                          ),
                        ),
                      );
                      showGeneralDialog(
                        context: context,
                        barrierColor: Colors.white,
                        // Background color
                        barrierDismissible: true,
                        barrierLabel: 'Dialog',
                        transitionDuration: Duration(milliseconds: 400),
                        // How long it takes to popup dialog after button click
                        pageBuilder: (_, __, ___) {
                          // Makes widget fullscreen
                          return Scaffold(
                            appBar: AppBar(
                              title: Text("Emergency contacts"),
                            ),
                            body: SizedBox.expand(
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    flex: 5,
                                    child: SizedBox.expand(
                                      child: SingleChildScrollView(
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: 200,
                                                  height: 50,
                                                  child: ElevatedButton(
                                                    style: raisedButtonStyle,
                                                    onPressed: () {},
                                                    child:
                                                        Text('Call Ambulance'),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: 200,
                                                  height: 50,
                                                  child: ElevatedButton(
                                                    style: raisedButtonStyle,
                                                    onPressed: () {},
                                                    child: Text('Call Police'),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: 200,
                                                  height: 50,
                                                  child: ElevatedButton(
                                                    style: raisedButtonStyle,
                                                    onPressed: () {},
                                                    child:
                                                        Text('Call ChildLine'),
                                                  ),
                                                ),
                                              ),
                                              Image.asset('assets/panic.jpg'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox.expand(
                                      child: ElevatedButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text(
                                          'Dismiss',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
