import 'package:fitness_app/feature/auth/presentation/view_model/login/login_cubit.dart';
import 'package:fitness_app/feature/auth/presentation/view_model/login/login_state.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/login_content_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_app/core/base_state/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'login_content_widget_test.mocks.dart';

@GenerateMocks([LoginCubit])
void main() {
  late MockLoginCubit mockCubit;

  setUp(() {
    mockCubit = MockLoginCubit();
  });

  Widget buildTestWidget(LoginState state) {
    when(mockCubit.state).thenReturn(state);
    when(mockCubit.formKey).thenReturn(GlobalKey<FormState>());
    when(mockCubit.emailController)
        .thenReturn(TextEditingController(text: 'rana@mail.com'));
    when(mockCubit.passwordController)
        .thenReturn(TextEditingController(text: 'Zayn@123'));

    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<LoginCubit>.value(
          value: mockCubit,
          child: const LoginContentWidget(),
        ),
      ),
      routes: {
        '/appSection': (_) => const Scaffold(body: Text('Home Screen')),
      },
    );
  }

  testWidgets(' Navigates to appSection on successful login',
      (WidgetTester tester) async {
    final successState = LoginState(baseState: BaseSuccessState(), isFormValid: true);

    await tester.pumpWidget(buildTestWidget(successState));
    await tester.pumpAndSettle();
    expect(find.text('Home Screen'), findsOneWidget);
  });

  testWidgets('Shows error toast on failed login', (WidgetTester tester) async {
    final errorState = LoginState(
      baseState: BaseErrorState(errorMessage: ''),
      isFormValid: true,
    );

    await tester.pumpWidget(buildTestWidget(errorState));

    await tester.pump(const Duration(seconds: 2));

    expect(find.textContaining('Incorrect email and password '), findsOneWidget);
  });
}
