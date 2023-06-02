import 'package:flutter_test/flutter_test.dart';
import 'package:picstash/application/login_bloc/login_blocs.dart';
import 'package:picstash/application/login_bloc/login_event.dart';
import 'package:picstash/application/login_bloc/login_state.dart';
import 'package:picstash/domain/entities/login/login_details.dart';
import 'package:picstash/domain/entities/login/login_model.dart';
import 'package:picstash/domain/value_objects/email_address.dart';
import 'package:picstash/domain/value_objects/password.dart';
import 'package:mockito/mockito.dart';
import 'package:picstash/infrastructure/data_providers/db/db.dart';
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
      ];
      loginBloc.add(LoadLogin());

      expectLater(loginBloc.stream, emitsInOrder(expectedResponse));
    });

    test(
        'LoginButtonPressed event yields LoginSuccess state on successful login',
        () async {
      const String email = 'husenyusf@gmail.com';
      const String password = '12345678';
      final loginModel = LoginModel(
          emailAddress: EmailAddress.crud(email),
          password: Password.crud(password));

      LoginDetailsModel? loginDetailsModel =
          await LoginCredentials().getLoginCredentials();

      when(loginRepository.login(loginModel))
          .thenAnswer((_) async => loginDetailsModel!);

      loginBloc.add(LoginButtonPressed(loginModel: loginModel));

      final expectedResponse = [
        const LoginInitial(),
        const LoginLoading(),
        LoginSuccess(loginDetailsModel: loginDetailsModel!),
      ];
      expectLater(loginBloc.stream, emitsInOrder(expectedResponse));
    });

    test('LoginButtonPressed event yields LoginFailure state on failed login',
        () {
      const String email = 'test@example.com';
      const String password = 'password';
      final loginModel = LoginModel(
          emailAddress: EmailAddress.crud(email),
          password: Password.crud(password));

      when(loginRepository.login(loginModel))
          .thenThrow(Exception('Login failed'));

      final expectedResponse = [
        const LoginInitial(),
        const LoginLoading(),
        const LoginFailure(error: 'Login failed'),
      ];
      loginBloc.add(LoginButtonPressed(loginModel: loginModel));

      expectLater(loginBloc.stream, emitsInOrder(expectedResponse));
    });

    tearDown(() {
      loginBloc.close();
    });
  });
}
