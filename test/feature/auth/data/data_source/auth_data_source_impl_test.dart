import 'package:fitness_app/feature/auth/data/data_source/auth_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/core/network/remote/api_manager.dart';
import 'package:fitness_app/feature/auth/data/api/auth_retrofit_client.dart';
import 'package:fitness_app/feature/auth/data/model/login/request/login_request_dto.dart';
import 'package:fitness_app/feature/auth/data/model/login/response/login_response_dto.dart';

import 'auth_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiManager, AuthRetrofitClient])
void main() {
  late MockApiManager mockApiManager;
  late MockAuthRetrofitClient mockApiService;
  late RemoteAuthDataSourceImp dataSource;
  provideDummy<Result<LoginResponseDto?>>(
    FailureResult(Exception('dummy')),
  );
  // provideDummy<Result<LoginRequestDto?>>(
  //   SuccessResult().data,
  // );

  setUp(() {
    mockApiManager = MockApiManager();
    mockApiService = MockAuthRetrofitClient();
    dataSource = RemoteAuthDataSourceImp(mockApiManager, mockApiService);
  });

  group('login', () {
    test('returns SuccessResult on successful login', () async {
      final loginRequest =
          const LoginRequestDto(email: 'rana@mail.com', password: 'test@123');
      final loginResponse =
          const LoginResponseDto(message: 'Login success', token: 'token');

      when(mockApiManager.execute<LoginResponseDto?>(any)).thenAnswer(
        (_) async => SuccessResult<LoginResponseDto?>(loginResponse),
      );

      final result = await dataSource.login(loginRequest);

      expect(result, isA<SuccessResult<LoginResponseDto?>>());
      expect((result as SuccessResult<LoginResponseDto?>).data, loginResponse);
      verify(mockApiManager.execute<LoginResponseDto?>(any)).called(1);
    });

    test('returns FailureResult on failed login', () async {
      final loginRequest =
          const LoginRequestDto(email: 'rana@mail.com', password: '1234');
      final exception = Exception('Invalid email or password');

      when(mockApiManager.execute<LoginResponseDto?>(any)).thenAnswer(
        (_) async => FailureResult<LoginResponseDto?>(exception),
      );

      final result = await dataSource.login(loginRequest);

      expect(result, isA<FailureResult<LoginResponseDto?>>());
      expect((result as FailureResult<LoginResponseDto?>).exception, exception);
      verify(mockApiManager.execute<LoginResponseDto?>(any)).called(1);
    });
  });
}
