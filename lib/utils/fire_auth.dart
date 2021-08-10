import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:highview/models/user_obj.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final CollectionReference _usersCollection = _firestore.collection('users');

class FireAuth {
  String uid;

  FireAuth({this.uid});

  //get user doc stream
  Stream<UserObject> get userData {
    return _usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<UserObject> get user {
    _firebaseAuth.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    return user;
  }

  UserObject _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserObject(
      userType: (snapshot.data() as Map<String, dynamic>) ['userType'],
      phoneNumber: (snapshot.data() as Map<String, dynamic>) ['phoneNumber'],
      profilePicture: (snapshot.data() as Map<String, dynamic>) ['profilePicture'],
      email: (snapshot.data() as Map<String, dynamic>) ['email'],
      firstName: (snapshot.data() as Map<String, dynamic>) ['firstName'],
      lastName: (snapshot.data() as Map<String, dynamic>) ['lastName'],
      displayName: (snapshot.data() as Map<String, dynamic>) ['displayName'],
      userUid: (snapshot.data() as Map<String, dynamic>) ['userUid'],
      gender: (snapshot.data() as Map<String, dynamic>) ['gender'],
      profile: (snapshot.data() as Map<String, dynamic>) ['profile'],
    );
  }


  static Future<User> registerUsingEmailPassword({
    String firstName,
    String lastName,
    String email,
    String password,
    String gender,
    String speciality,
    String location,
    String userType
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      await user.updatePhotoURL(user.photoURL);
      await addUser(
          userUid: user.uid,
          firstName: firstName,
          lastName: lastName,
          email: email,
          gender: gender,
          speciality: speciality,
          location: location,
      userType: userType);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password is too weak');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Email', 'The account already exists for that email');
        print('The account already exists for that email');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  static Future<void> addUser({
    String userUid,
    String firstName,
    String lastName,
    String email,
    String gender,
    String speciality,
    String location,
    String userType,
  }) async {
    DocumentReference documentReference =
        _usersCollection.doc(userUid);
    Map<String, dynamic> data;
    if(userType == "Doctor"){
      data = <String, dynamic>{
        "userUid": userUid,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "gender": gender,
        "speciality": speciality,
        "location": location,
        "userType": userType
      };
    } else {
      data = <String, dynamic>{
        "userUid": userUid,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "gender": gender,
        "location": location,
        "userType": userType
      };
    }

    await documentReference
        .set(data)
        .whenComplete(() => print("User added to the database"))
        .catchError((e) => print(e));
  }

  static Future<User> signInUsingEmailPassword({
    String email,
    String password,
    BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided');
      }
    }
    return user;
  }

  static Future<User> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User refreshedUser = auth.currentUser;

    return refreshedUser;
  }
}
