import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picstash/application/login_bloc/login_blocs.dart';
import 'package:picstash/application/signup_bloc/sign_up_block.dart';
import 'package:picstash/bloc_observer.dart';
import 'package:picstash/infrastructure/data_providers/db/db.dart';
import 'package:picstash/infrastructure/data_providers/signup/signup_data_provider.dart';
import 'package:picstash/infrastructure/repository/login_repository/login_repository.dart';
import 'package:picstash/infrastructure/repository/signup_repository/sign_up_repository.dart';
import 'application/post_bloc/post_bloc.dart';
import 'domain/repositories/post_repository.dart';
import 'infrastructure/data_providers/post_data_provider.dart';
import 'infrastructure/data_providers/login/login_data_provider.dart';
import 'presentation/routes/app_route_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final LoginCredentials loginCredentials = LoginCredentials();
  bool isLoggedIn = (await loginCredentials.getLoginCredentials()) != null;

  final PostRepository postRepository = PostRepository(PostDataProvider());
  final LoginRepository loginRepository =
      LoginRepository(loginDataProvider: const LoginDataProvider());
  final SignUpRepository signUpRepository =
      SignUpRepository(signUpDataProvider: SignUpDataProvider());

  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp(
    postRepository: postRepository,
    loginRepository: loginRepository,
    signUpRepository: signUpRepository,
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final PostRepository postRepository;
  final LoginRepository loginRepository;
  final SignUpRepository signUpRepository;
  final bool isLoggedIn;

  const MyApp({
    Key? key,
    required this.postRepository,
    required this.loginRepository,
    required this.signUpRepository,
    required this.isLoggedIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostBloc>(
          create: (context) => PostBloc(postRepository: postRepository),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(loginRepository: loginRepository),
        ),
        BlocProvider(
          create: (context) => SignUpBloc(signUpRepository: signUpRepository),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationParser:
            MyAppRouter.returnRouter(isLoggedIn).routeInformationParser,
        routerDelegate: MyAppRouter.returnRouter(isLoggedIn).routerDelegate,
      ),
    );
  }
}
