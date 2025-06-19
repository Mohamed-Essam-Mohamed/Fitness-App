import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/core/base_state/base_state.dart';
import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/auth/domain/entities/login/request/login_request_entity.dart';
import 'package:fitness_app/feature/auth/domain/entities/login/response/login_response_entity.dart';
import 'package:fitness_app/feature/auth/domain/entities/login/response/user_data_entity.dart';
import 'package:fitness_app/feature/auth/domain/use_cases/login_use_case.dart';
import 'package:fitness_app/feature/auth/presentation/view_model/login/login_cubit.dart';
import 'package:fitness_app/feature/auth/presentation/view_model/login/login_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'login_cubit_test.mocks.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([LoginUseCase])
void main() {
  late MockLoginUseCase mockLoginUseCase;
  late LoginCubit loginCubit;
  provideDummy<Result<LoginRequestEntity?>>(
    FailureResult(Exception("dummy")),
  );
  provideDummy<Result<LoginResponseEntity?>>(
    FailureResult(Exception("dummy")),
  );
  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    SharedPreferences.setMockInitialValues({}); // Clear shared prefs
    loginCubit = LoginCubit(mockLoginUseCase);
  });

  tearDown(() async {
    await loginCubit.close();
  });

  group('LoginCubit', () {
    final loginRequest = const LoginRequestEntity(
      email: 'test@example.com',
      password: 'password123',
    );

    final userData = UserDataEntity(
      id: '1',
      email: 'test@example.com',
      firstName: 'Test',
      lastName: 'User',
      photo: 'url',
      goal: 'Lose Weight',
      gender: 'Female',
      age: 25,
      weight: 60,
      height: 160,
      createdAt: '2023-01-01',
      activityLevel: 'medium',
    );

    final responseEntity = LoginResponseEntity(
      message: 'Success',
      token: 'abc123',
      user: userData,
    );

    blocTest<LoginCubit, LoginState>(
      'emits [Loading, Success] on successful login',
      build: () {
        when(mockLoginUseCase.call(any))
            .thenAnswer((_) async => SuccessResult(responseEntity));
        loginCubit.emailController.text = loginRequest.email!;
        loginCubit.passwordController.text = loginRequest.password!;
        return loginCubit;
      },
      act: (cubit) {
        cubit.formKey.currentState?.validate();
        cubit.doIntent(LoginAction());
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
        loginCubit.state.copyWith(baseState: BaseLoadingState()),
        loginCubit.state.copyWith(
          baseState: BaseSuccessState(data: SuccessResult(responseEntity)),
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [Loading, Error] on failed login',
      build: () {
        when(mockLoginUseCase.call(any))
            .thenAnswer((_) async => FailureResult(Exception('Login failed')));
        loginCubit.emailController.text = loginRequest.email!;
        loginCubit.passwordController.text = loginRequest.password!;
        return loginCubit;
      },
      act: (cubit) {
        cubit.formKey.currentState?.validate(); // simulate validation
        cubit.doIntent(LoginAction());
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
        loginCubit.state.copyWith(baseState: BaseLoadingState()),
        isA<LoginState>().having(
          (s) => s.baseState,
          'baseState',
          isA<BaseErrorState>(),
        ),
      ],
    );
  });
}
