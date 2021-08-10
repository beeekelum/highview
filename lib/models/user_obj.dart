import 'package:cloud_firestore/cloud_firestore.dart';

class UserObject {
  String userUid = '';
  String firstName = '';
  String lastName = '';
  String displayName = '';
  String email = '';
  String phoneNumber = '';
  String location = '';
  String status = '';
  String userType = '';
  String profilePicture = '';
  String gender = '';
  String profile = '';
  String workAddress = '';
  int yearsOfExperience = 0;

  DocumentReference reference;

  UserObject(
      {this.userUid,
      this.firstName,
      this.lastName,
      this.displayName,
      this.email,
      this.phoneNumber,
      this.location = "",
      this.status = "Active",
      this.userType,
      this.profilePicture,
        this.reference,
      this.gender,
      this.profile,
      this.workAddress = "",
      this.yearsOfExperience = 0});

  factory UserObject.fromSnapshot(DocumentSnapshot snapshot) {
    UserObject newUserObj = UserObject.fromJson(snapshot.data());
    newUserObj.reference = snapshot.reference;
    return newUserObj;
  }

  factory UserObject.fromJson(Map<dynamic, dynamic> json) =>
      userObjFromJson(json);

  Map<String, dynamic> toJson() => userObjToJson(this);

}

UserObject userObjFromJson(Map<dynamic, dynamic> json) {
  return UserObject(
    userUid: json['userUid'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    displayName: json['displayName'] as String,
    email: json['email'] as String,
    phoneNumber: json['phoneNumber'] as String,
    location: json['location'] as String,
    status: json['status'] as String,
    userType: json['userType'] as String,
    profile: json['profile'] as String,
    gender: json['gender'] as String,
    profilePicture: json['profilePicture'] as String,

  );
}

Map<String, dynamic> userObjToJson(UserObject instance) => <String, dynamic>{
      'userUid': instance.userUid,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'displayName': instance.displayName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'location': instance.location,
      'status': instance.status,
      'userType': instance.userType,
      'profile': instance.profile,
      'gender': instance.gender,
      'profilePicture': instance.profilePicture,
    };
