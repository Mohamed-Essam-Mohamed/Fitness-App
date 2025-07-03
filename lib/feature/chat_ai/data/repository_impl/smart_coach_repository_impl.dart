// import 'package:fitness_app/feature/chat_ai/data/data_source/remote_smart_coach_data_source.dart';
// import 'package:fitness_app/feature/chat_ai/domain/repository/smart_coach_repository.dart';
// import 'package:injectable/injectable.dart';
//
// @Injectable(as: SmartCoachRepository)
// class SmartCoachRepositoryImpl implements SmartCoachRepository {
//   SmartCoachRepositoryImpl(this._remoteSmartCoachDataSource);
//   final RemoteSmartCoachDataSource _remoteSmartCoachDataSource;
//
// }
import 'package:fitness_app/feature/chat_ai/data/api/smart_coach_services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import '../../domain/repository/smart_coach_repository.dart';

class SmartCoachRepositoryImpl implements SmartCoachRepository {
  final SmartCoachService service;
  SmartCoachRepositoryImpl(this.service);



  @override
  Future<String> askSmartCoach(String message) =>
      service.singleTurnAsk(message);

  @override
  Stream<Candidates?> askSmartCoachStream(String message) =>
      service.askStream(message);

  @override
  Stream<Candidates?> askSmartCoachStream2(String message, List<Content> history) =>
    service.askStream2(message,history);
}



