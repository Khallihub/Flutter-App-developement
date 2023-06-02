// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:picstash/application/login_bloc/login_blocs.dart';
// import 'package:picstash/domain/entities/login/login_model.dart';
// import 'package:picstash/infrastructure/repository/login_repository/login_repository.dart';
// import 'package:picstash/presentation/screens/home_screen.dart';

// // import '../mocks/mock_login_repository.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:picstash/domain/repositories/login_repository.dart';
// import 'package:picstash/presentation/screens/login_page.dart';

// class MockLoginRepository extends Mock implements LoginRepository {}

// void main() {
//   late LoginBloc loginBloc;
//   late MockLoginRepository mockLoginRepository;

//   setUp(() {
//     mockLoginRepository = MockLoginRepository();
//     loginBloc = LoginBloc(loginRepository: mockLoginRepository);
//   });

//   testWidgets('Login form validation', (WidgetTester tester) async {
//     await tester.pumpWidget(
//       MaterialApp(
//         home: BlocProvider.value(
//           value: loginBloc,
//           child: const LogIn(),
//         ),
//       ),
//     );

//     final emailField = find.byType(TextFormField).at(0);
//     final passwordField = find.byType(TextFormField).at(1);
//     final loginButton = find.byType(IconButton);

//     // Test empty form submission
//     await tester.tap(loginButton);
//     await tester.pump();
//     expect(find.text('invalid email!'), findsOneWidget);
//     expect(find.text('invalid password'), findsOneWidget);

//     // Test invalid email format
//     await tester.enterText(emailField, 'invalid email');
//     await tester.tap(loginButton);
//     await tester.pump();
//     expect(find.text('invalid email!'), findsOneWidget);

//     // Test invalid password format
//     await tester.enterText(emailField, 'validemail@example.com');
//     await tester.enterText(passwordField, 'pass');
//     await tester.tap(loginButton);
//     await tester.pump();
//     expect(find.text('invalid password'), findsOneWidget);

//     // Test valid form submission
//     when(() => mockLoginRepository.login(any())).thenAnswer((_) async => true);
//     await tester.enterText(passwordField, 'validpassword');
//     await tester.tap(loginButton);
//     await tester.pumpAndSettle();
//     expect(find.byType(Home), findsOneWidget);
//   });
// }

import 'package:flutter_test/flutter_test.dart';
import 'package:picstash/application/login_bloc/login_blocs.dart';
import 'package:picstash/application/login_bloc/login_event.dart';
import 'package:picstash/application/login_bloc/login_state.dart';
import 'package:picstash/domain/entities/login/login_model.dart';
import 'package:picstash/domain/value_objects/email_address.dart';
import 'package:picstash/domain/value_objects/password.dart';
import 'package:mockito/mockito.dart';
import 'package:picstash/infrastructure/repository/login_repository/login_repository.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  group('LoginBloc', () {
    late LoginRepository loginRepository;
    late LoginBloc loginBloc;

    setUp(() {
      loginRepository = MockLoginRepository();
      loginBloc = LoginBloc(loginRepository: loginRepository);
    });

    test('initial state is LoginInitial', () {
      expect(loginBloc.state, const LoginInitial());
    });

    test('LoadLogin event loads LoginLoading state', () {
      final expectedResponse = [
        const LoginInitial(),
        const LoginLoading(),
      ];

      expectLater(loginBloc.stream, emitsInOrder(expectedResponse));

      loginBloc.add(LoadLogin());
    });

    test(
        'LoginButtonPressed event yields LoginSuccess state on successful login',
        () {
      final email = 'dammy@gmail.com';
      final password = '12345678';
      final loginModel = LoginModel(
          emailAddress: EmailAddress.crud(email),
          password: Password.crud(password));

      when(loginRepository.login(loginModel))
          .thenAnswer((_) async => Future.error('Login failed'));

      final expectedResponse = [
        LoginInitial,
        LoginLoading,
        LoginSuccess,
      ];

      expectLater(loginBloc.stream, emitsInOrder(expectedResponse));

      loginBloc.add(LoginButtonPressed(loginModel: loginModel));
    });

    test('LoginButtonPressed event yields LoginFailure state on failed login',
        () {
      final email = 'test@example.com';
      final password = 'password';
      final loginModel = LoginModel(
          emailAddress: EmailAddress.crud(email),
          password: Password.crud(password));

      when(loginRepository.login(loginModel))
          .thenAnswer((_) async => Future.error('Login failed'));

      final expectedResponse = [
        LoginInitial,
        LoginLoading,
        LoginFailure,
      ];

      expectLater(loginBloc.stream, emitsInOrder(expectedResponse));

      loginBloc.add(LoginButtonPressed(loginModel: loginModel));
    });

    tearDown(() {
      loginBloc.close();
    });
  });
}
