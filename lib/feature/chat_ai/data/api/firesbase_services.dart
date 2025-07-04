import 'package:fitness_app/core/constants/app_values.dart';
import 'package:fitness_app/feature/chat_ai/domain/entity/smart_coach/message_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
@injectable
class FirebaseChatService {
  final _firestore = FirebaseFirestore.instance;

  Future<String> get userId async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppValues.id) ?? 'guest_user';
  }

  Future<String> startNewConversation() async {
    final uid = await userId;
    final conversationRef = await _firestore
        .collection('users')
        .doc(uid)
        .collection('conversations')
        .add({'timestamp': FieldValue.serverTimestamp()});
    return conversationRef.id;
  }

  Future<void> setConversationTitle(String conversationId, String title) async {
    final uid = await userId;
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('conversations')
        .doc(conversationId)
        .update({'title': title});
  }

  Future<void> saveMessage(String conversationId, MessageEntity message) async {
    final uid = await userId;
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .add({
      'text': message.text,
      'sender': message.sender.name,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<List<MessageEntity>> fetchMessages(String conversationId) async {
    final uid = await userId;
    final snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .orderBy('timestamp')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return MessageEntity(
        text: data['text'],
        sender: data['sender'] == 'user' ? Sender.user : Sender.model,
      );
    }).toList();
  }

  Future<List<Map<String, dynamic>>> fetchConversationSummaries() async {
    final uid = await userId;
    final snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('conversations')
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => {
      'id': doc.id,
      'timestamp': doc['timestamp'],
      'title': doc.data()['title'] ?? 'Untitled',
    })
        .toList();
  }
}

