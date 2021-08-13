// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_chat_bubble/bubble_type.dart';
// import 'package:flutter_chat_bubble/chat_bubble.dart';
// import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:get/get.dart';
// import 'package:highview/services/chat.controller.dart';
// import 'package:highview/services/chat.model.dart';
// import 'package:highview/services/chat.service.dart';
//
// class DetailedChatView extends StatefulWidget {
//   @override
//   _DetailedChatViewState createState() => _DetailedChatViewState();
// }
//
// class _DetailedChatViewState extends State<DetailedChatView> {
//   final chatController = Get.put(ChatController());
//
//   final _formKey = GlobalKey<FormBuilderState>();
//
//   String messageBody;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Column(
//           children: [
//             Text("Chat"),
//             Text("${Get.parameters['product_title']}", style: TextStyle(fontSize: 14),),
//           ],
//         ),centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//               child: GetX<ChatController>(
//                 builder: (_) => StreamBuilder<QuerySnapshot>(
//                   stream: Get.find<ChatController>()
//                       .loadChatMessages(Get.parameters['chat_id'])
//                       .value,
//                   builder: (context, stream) {
//                     if (stream.connectionState == ConnectionState.waiting) {
//                       return Center(child: CircularProgressIndicator());
//                     }
//
//                     if (stream.hasData == false) {
//                       return Center(child: Text("No chats."));
//                     }
//
//                     if (stream.hasError) {
//                       return Center(child: Text(stream.error.toString()));
//                     }
//
//                     QuerySnapshot querySnapshot = stream.data;
//                     return ListView.builder(
//                       physics: BouncingScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: querySnapshot.size,
//                       itemBuilder: (BuildContext context, int index) {
//                         final item = querySnapshot.docs[index];
//                         final Chat chatItem =
//                         Chat.fromQueryDocumentSnapshot(
//                             queryDocSnapshot: item);
//                         return Column(
//                           children: [
//                             // message.loggedInUid == FirebaseAuth.instance.currentUser.uid ?
//                             ChatBubble(
//                               clipper: ChatBubbleClipper1(
//                                 // type: BubbleType.sendBubble
//                                   type: chatItem.loggedInUid == FirebaseAuth.instance.currentUser.uid ? BubbleType.sendBubble : BubbleType.receiverBubble
//                               ),
//                               alignment:  chatItem.loggedInUid == FirebaseAuth.instance.currentUser.uid ? Alignment.topRight : Alignment.topLeft ,
//                               margin: EdgeInsets.only(top: 20),
//                               backGroundColor: chatItem.loggedInUid == FirebaseAuth.instance.currentUser.uid ? Colors.blue : Color(0xffE7E7ED),
//                               child: Container(
//                                 constraints: BoxConstraints(
//                                   maxWidth: MediaQuery.of(context).size.width * 0.7,
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Text(chatItem.messageBody,
//                                       style: TextStyle(color:  chatItem.loggedInUid == FirebaseAuth.instance.currentUser.uid ? Colors.white : Colors.black),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   },
//                 ),
//               )
//           ),
//           FormBuilder(
//             key: _formKey,
//             child: Container(
//               height: 70,
//               child: FormBuilderTextField(
//                 controller: chatController.chatMessageController,
//                 textCapitalization: TextCapitalization.sentences,
//                 minLines: 1,
//                 maxLines: 10,
//                 decoration: textInputDecoration2.copyWith(
//                   hintText: "Type a message ...",
//                   suffixIcon: IconButton(icon: Icon(Icons.send), onPressed: (){
//                     _formKey.currentState.save();
//                     if (_formKey.currentState.validate()) {
//                       sendMessage(Get.parameters['chat_id']);
//                     } else {
//                       print("validation failed");
//                     }
//                   }),
//                 ),
//                 // onChanged: (value){
//                 //   messageBody = value;
//                 // },
//                 validator: FormBuilderValidators.compose([
//                   FormBuilderValidators.required(context),
//                 ]),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   sendMessage(String chatId) async{
//     ChatService chatService = new ChatService();
//     await chatService.sendMessage(
//       chatId:chatId,
//       loggedInUid: user.uid,
//       messageBody: chatController.chatMessageController.text,
//       // messageBody: messageBody,
//     ).then((value){
//       setState(() {
//         chatController.chatMessageController.clear();
//       });
//       if (this.mounted) { // check whether the state object is in tree
//         setState(() {
//           chatController.chatMessageController.clear();
//           // messageBody = '';
//         });
//       }
//     });
//   }
// }
