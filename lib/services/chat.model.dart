// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class Chat {
//   String id;
//   String loggedInUid;
//   String itemUid;
//   String senderUid;
//   String recipientUid;
//   String messageBody;
//   String messageTitle;
//   String firstImageUrl;
//   List<String> senderRecipientUidS;
//   bool isRead;
//   DateTime createdAt;
//   DocumentReference reference;
//
//   Chat({this.id,
//     this.loggedInUid,
//     this.itemUid,
//     this.senderUid,
//     this.recipientUid,
//     this.messageBody,
//     this.messageTitle,
//     this.firstImageUrl,
//     this.senderRecipientUidS,
//     this.isRead,
//     this.createdAt});
//
//   factory Chat.fromSnapshot(DocumentSnapshot snapshot) {
//     Chat newChat = Chat.fromJson(snapshot.data());
//     newChat.reference = snapshot.reference;
//     return newChat;
//   }
//
//   factory Chat.fromJson(Map<dynamic, dynamic> json) =>
//       chatFromJson(json);
//
//   Map<String, dynamic> toJson() => chatToJson(this);
//
// }
//
// Chat chatFromJson(Map<dynamic, dynamic> json) {
//   return Chat(
//     loggedInUid:json['logged_in_uid'],
//     itemUid: json['item_uid'],
//     senderUid: json['sender_uid'],
//     recipientUid: json['recipient_uid'],
//     messageBody: json['message_body'],
//     messageTitle: json['message_title'],
//     firstImageUrl: json['first_image_url'],
//     isRead: json['is_read'],
//     senderRecipientUidS: (json['sender_recipient_uid_s'] as List)?.map((e) => e as String)?.toList(),
//     createdAt: json['created_at'] == null
//         ? null
//         : (json['created_at'] as Timestamp).toDate(),
//
//   );
// }
//
// Map<String, dynamic> chatToJson(Chat instance) => <String, dynamic>{
//   'userUid': instance.userUid,
//   'firstName': instance.firstName,
//   'lastName': instance.lastName,
//   'displayName': instance.displayName,
//   'email': instance.email,
//   'phoneNumber': instance.phoneNumber,
//   'location': instance.location,
//   'status': instance.status,
//   'userType': instance.userType,
//   'profile': instance.profile,
//   'gender': instance.gender,
//   'profilePicture': instance.profilePicture,
// };
//
// class Message{
//   String id;
//   String loggedInUid;
//   String chatId;
//   String messageBody;
//   DateTime dateSent;
//
//
//   Message({this.id, this.loggedInUid, this.chatId, this.messageBody, this.dateSent});
//
//   factory Message.fromSnapshot(DocumentSnapshot snapshot){
//     return Message(
//       id: snapshot.id,
//       loggedInUid: snapshot.data()['logged_in_uid'],
//       chatId: snapshot.data()['chat_id'],
//       messageBody: snapshot.data()['message_body'],
//       dateSent: snapshot.data()['date_sent'] == null
//           ? null
//           : (snapshot.data()['date_sent'] as Timestamp).toDate(),
//     );
//   }
// }