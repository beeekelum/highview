// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
//
// class ChatService {
//   CollectionReference chatRef = FirebaseFirestore.instance.collection('chats');
//   CollectionReference messagesRef =
//       FirebaseFirestore.instance.collection('messages');
//
//
//   final StreamController<List<Chat>> _chatsController =
//       StreamController<List<Chat>>.broadcast();
//
//   final StreamController<List<Message>> _messagesController =
//       StreamController<List<Message>>.broadcast();
//
//   Stream<List<Chat>> findChatsByUid(String uid) {
//     chatRef
//         .where('sender_recipient_uid_s', arrayContains: uid)
//         .snapshots()
//         .listen((chatsSnapshot) {
//       if (chatsSnapshot.docs.isNotEmpty) {
//         var chats = chatsSnapshot.docs
//             .map((snapshot) => Chat.fromSnapshot(snapshot))
//             .toList();
//         _chatsController.add(chats);
//       }
//     });
//     return _chatsController.stream;
//   }
//
//
//   Stream<QuerySnapshot> findMessagesByChatId(String chatId) {
//     return messagesRef
//         .where('chat_id', isEqualTo: chatId)
//         .orderBy("date_sent", descending: false)
//         .snapshots();
//   }
//
//   Future<void> saveChat({
//     String loggedInUid,
//     String itemUid,
//     String senderUid,
//     String recipientUid,
//     String messageBody,
//     String messageTitle,
//     String firstImageUrl,
//     bool isRead = false,
//   }) async {
//     List<String> uidS = [recipientUid, senderUid];
//     await chatRef.add({
//       "logged_in_uid": loggedInUid,
//       "item_uid": itemUid,
//       "sender_uid": senderUid,
//       "recipient_uid": recipientUid,
//       "message_body": messageBody,
//       "message_title": messageTitle,
//       "first_image_url": firstImageUrl,
//       "is_read": isRead,
//       "sender_recipient_uid_s": uidS,
//       "created_at": DateTime.now()
//     }).then((value) {
//       Get.snackbar(
//         "Message",
//         "Sent successfully to seller",
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//         icon: Icon(Icons.done)
//       );
//       chatRef.doc(value.id).update({"id": value.id});
//       messagesRef.add({
//         "chat_id": value.id,
//         "logged_in_uid": loggedInUid,
//         "message_body": messageBody,
//         "date_sent": DateTime.now(),
//       }).then((value) => messagesRef.doc(value.id).update({"id": value.id}));
//     });
//   }
//
//   Future<void> sendMessage({
//     String chatId,
//     DateTime dateSent,
//     String id,
//     String loggedInUid,
//     String messageBody,
//   }) async {
//     messagesRef.add({
//       "chat_id": chatId,
//       "logged_in_uid": loggedInUid,
//       "message_body": messageBody,
//       "date_sent": DateTime.now(),
//     }).then((value) => messagesRef.doc(value.id).update({"id": value.id}));
//   }
// }
