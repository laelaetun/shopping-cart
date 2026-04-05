import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> sendMessage(String chatId, String senderId, String text) async {
    await _firestore.collection('chats').doc(chatId).collection('messages').add(
      {
        'senderId': senderId,
        'text': text,
        'timestamp': FieldValue.serverTimestamp(),
      },
    );
  }

  Future<String> createChat(List<String> users) async {
    final docRef = await _firestore.collection('chats').add({
      'users': users,
      'createdAt': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }
}
