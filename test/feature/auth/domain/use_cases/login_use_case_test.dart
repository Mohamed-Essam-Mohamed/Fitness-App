import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/auth/domain/entity/login/request/login_request_entity.dart';
import 'package:fitness_app/feature/auth/domain/entity/login/response/login_response_entity.dart';
import 'package:fitness_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:fitness_app/feature/auth/domain/use_cases/login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_use_case_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late LoginUseCase useCase;
  late MockAuthRepository repo;
  late LoginRequestEntity loginRequest;

  setUp(() {
    repo = MockAuthRepository();
    useCase = LoginUseCase(repo);
    loginRequest = LoginRequestEntity(
      password: 'pass@123',
      email: 'mail@mail.com',
    );
  });

  group('LoginUseCase Tests', () {
    test(
        'should call login on the repo and return SuccessResult when repository succeeds',
            () async {
          final response = LoginResponseEntity(
              message: 'login successfully');
          final result = SuccessResult<LoginResponseEntity?>(response);
          provideDummy<Result<LoginResponseEntity?>>(result);
          when(repo.login(loginRequest)).thenAnswer((_) async => result);

          final actual = await useCase.call(loginRequest);

          verify(repo.login(loginRequest)).called(1);
          expect(actual, isA<SuccessResult<LoginResponseEntity?>>());
          expect((actual as SuccessResult).data.message,
              'login successfully');
        });

    test(
        'should call login on the repo and return FailureResult when repository fails',
            () async {
          final exception = Exception('Incorrect email or password');
          final result = FailureResult<LoginResponseEntity?>(exception);
          provideDummy<Result<LoginResponseEntity?>>(result);

          when(repo.login(loginRequest)).thenAnswer((_) async => result);

          final actual = await useCase.call(loginRequest);

          verify(repo.login(loginRequest)).called(1);
          expect(actual, isA<FailureResult<LoginResponseEntity?>>());
          expect((actual as FailureResult).exception.toString(),
              contains('Incorrect email or password'));
        });
  });
}
