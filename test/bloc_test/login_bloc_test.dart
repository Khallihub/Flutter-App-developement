import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:picstash/application/login_bloc/login_blocs.dart';
import 'package:picstash/application/login_bloc/login_event.dart';
import 'package:picstash/application/login_bloc/login_state.dart';
import 'package:picstash/domain/entities/login/login_details.dart';
import 'package:picstash/domain/entities/login/login_model.dart';
import 'package:picstash/domain/value_objects/password.dart';
import 'package:picstash/infrastructure/data_providers/db/db.dart';
import 'package:picstash/infrastructure/repository/login_repository/login_repository.dart';

// Create a mock LoginRepository for testing
class MockLoginRepository extends Mock implements LoginRepository {}

class MockLoginDetailsModel extends Mock implements LoginDetailsModel {}

void main() {
  group('LoginBloc', () {
    late LoginRepository mockLoginRepository;
    late LoginBloc loginBloc;
    late LoginDetailsModel loginDetailsModel;
    late LoginModel loginModel;

    setUp(() async {
      mockLoginRepository = MockLoginRepository();
      loginBloc = LoginBloc(loginRepository: mockLoginRepository);
      loginDetailsModel = MockLoginDetailsModel();
      loginModel = LoginModel(
          emailAddress: loginDetailsModel.localUserModel.email,
          password: Password.crud("12345678"));
    });

    tearDown(() {
      loginBloc.close();
    });

    test('initial state is LoginInitial', () {
      expect(loginBloc.state, equals(const LoginInitial()));
    });

    blocTest<LoginBloc, LoginState>(
      'emits [LoginInitial] when LoadLogin event is added',
      build: () => loginBloc,
      act: (bloc) => bloc.add(LoadLogin()),
      expect: () => const <LoginState>[
        LoginInitial(),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginSuccess] when LoginButtonPressed event is added and login is successful',
      build: () => loginBloc,
      act: (bloc) => bloc.add(LoginButtonPressed(loginModel: loginModel)),
      expect: () => <LoginState>[
        const LoginLoading(),
        LoginSuccess(loginDetailsModel: loginDetailsModel),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginFailure] when LoginButtonPressed event is added and login fails',
      build: () {
        when(mockLoginRepository.login(loginModel))
            .thenThrow(Exception('Login failed'));
        return loginBloc;
      },
      act: (bloc) => bloc.add(LoginButtonPressed(loginModel: loginModel)),
      expect: () => <LoginState>[
        const LoginLoading(),
        const LoginFailure(error: 'error'),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LogOutLoading, LogOutSuccess, LoginInitial] when LogOutButtonPressed event is added',
      build: () => loginBloc,
      act: (bloc) => bloc.add(LogOutButtonPressed()),
      expect: () => <LoginState>[
        LogOutLoading(),
        LogOutSuccess(),
        const LoginInitial(),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LogOutLoading, LogOutFailure] when LogOutButtonPressed event is added and logout fails',
      build: () {
        when(mockLoginRepository.logout(LoginCredentials()))
            .thenThrow(Exception('Logout failed'));
        return loginBloc;
      },
      act: (bloc) => bloc.add(LogOutButtonPressed()),
      expect: () => <LoginState>[
        LogOutLoading(),
        const LogOutFailure(error: "error"),
      ],
    );
  });
}
