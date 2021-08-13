// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:highview/services/chat.model.dart';
// import 'package:highview/services/chat.service.dart';
//
// class ChatController extends GetxController {
//   static ChatController to = Get.find();
//   TextEditingController chatMessageController;
//   Chat chat;
//
//   RxBool isLoadingChats = false.obs;
//
//   RxList<Chat> chatsList = <Chat>[].obs;
//   RxList<Message> messagesList = <Message>[].obs;
//   ChatService chatService;
//
//   ChatController() {
//     chatService = ChatService();
//   }
//
//   @override
//   void onReady() {
//     chatMessageController = TextEditingController();
//     chatsList.bindStream(loadUserChats(FirebaseAuth.instance.currentUser.uid));
//     // messagesList.bindStream(loadChatMessages());
//     super.onReady();
//   }
//
//   Stream<List<Chat>> loadUserChats(String uid) {
//     return chatService.findChatsByUid(uid);
//   }
//
//   // Stream<List<Message>> loadChatMessages({String chatId}) {
//   //   return chatService.findMessagesByChatId(chatId);
//   // }
//
//   Rx<Stream<QuerySnapshot>> loadChatMessages(String chatId) {
//     Stream<QuerySnapshot> qSnapStream = chatService.findMessagesByChatId(chatId);
//     // qSnapStream.forEach((QuerySnapshot qSnapItem) {
//     //   setContactListCount(qSnapItem.size);
//     // });
//     return qSnapStream.obs;
//   }
//
//   Future<RxList<Message>> loadMessages(String chatId) async {
//     try {
//       messagesList = (chatService.findMessagesByChatId(chatId)) as RxList<Message>;
//     } catch (e) {
//     }
//     return messagesList;
//   }
//
//   @override
//   void onClose() {
//     chatMessageController?.dispose();
//   }
// }
