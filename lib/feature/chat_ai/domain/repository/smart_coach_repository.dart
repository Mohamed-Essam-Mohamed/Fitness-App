


 // interface class SmartCoachRepository {
 //  SmartCoachRepository(this.service);
 //  final SmartCoachService service;
 //
 //  Future<String> getReply(String message) =>
 //      service.askCoach(message);}
 import 'package:flutter_gemini/flutter_gemini.dart';

abstract class SmartCoachRepository {
  Stream<Candidates?> askSmartCoachStream2(String message,List<Content> history);

  Stream<Candidates?> askSmartCoachStream(String message);
  Future<String> askSmartCoach(String message);
 }

