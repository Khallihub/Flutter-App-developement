import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picstash/application/login_bloc/login_blocs.dart';
import 'package:picstash/application/signup_bloc/sign_up_block.dart';
import 'package:picstash/bloc_observer.dart';
import 'package:picstash/infrastructure/data_providers/signup/signup_data_provider.dart';
import 'package:picstash/infrastructure/repository/login_repository/login_repository.dart';
import 'package:picstash/infrastructure/repository/signup_repository/sign_up_repository.dart';
import 'application/post_bloc/post_bloc.dart';
import 'domain/repositories/post_repository.dart';
import 'infrastructure/data_providers/post_data_provider.dart';
import 'infrastructure/data_providers/login/login_data_provider.dart';
import 'presentation/components/theme.dart';
import 'presentation/routes/app_route_config.dart';

void main() {
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
  ));
}

class MyApp extends StatelessWidget {
  final PostRepository postRepository;
  final LoginRepository loginRepository;
  final SignUpRepository signUpRepository;
  const MyApp(
      {Key? key,
      required this.postRepository,
      required this.loginRepository,
      required this.signUpRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PostBloc>(
            create: (context) => PostBloc(postRepository: postRepository),
          ),
          BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(loginRepository: loginRepository)),
          BlocProvider(
              create: (context) =>
                  SignUpBloc(signUpRepository: signUpRepository)),
        ],
        child: MaterialApp.router(
          theme: lightTheme(),
          darkTheme: darkTheme(),
          debugShowCheckedModeBanner: false,
          routeInformationParser:
              MyAppRouter.returnRouter(false).routeInformationParser,
          routerDelegate: MyAppRouter.returnRouter(false).routerDelegate,
        ));
  }
}

// import 'package:flutter/material.dart';
// import './infrastructure/data_ providers/UserProfile Data Provider.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// <<<<<<< HEAD
// import './domain/entities/user_profile/user_profile.dart';
// import './application/user_profile_bloc/blocs.dart';
// import './domain/repositories/user_profile_repository.dart';
// import './presentation/screens/user_profile_screen.dart';
// =======
// import 'package:picstash/application/login_bloc/login_blocs.dart';
// import 'package:picstash/application/signup_bloc/sign_up_block.dart';
// import 'package:picstash/bloc_observer.dart';
// import 'package:picstash/infrastructure/data_providers/signup/signup_data_provider.dart';
// import 'package:picstash/infrastructure/repository/login_repository/login_repository.dart';
// import 'package:picstash/infrastructure/repository/signup_repository/sign_up_repository.dart';
// import 'application/post_bloc/post_bloc.dart';
// import 'domain/repositories/post_repository.dart';
// import 'infrastructure/data_providers/post_data_provider.dart';
// import 'infrastructure/data_providers/login/login_data_provider.dart';
// import 'presentation/components/theme.dart';
// import 'presentation/routes/app_route_config.dart';
// >>>>>>> b88b4c8775047a2a7e67aac4ca4414955c30dc12

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
// <<<<<<< HEAD
//     return MaterialApp(
//       title: 'User Profile',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BlocProvider(
//         create: (context) => UserProfileBloc(
//             userProfileRepository:
//                 UserProfileRepository(dataProvider: UserProfileDataProvider())),
//         child: UserProfileScreen(userProfile: getUserProfile() ,isOwner: false,),
//       ),
//     );
//   }

//   // Sample user profile data (replace with your own implementation)
//   UserProfile getUserProfile() {
//     return UserProfile(
//       location: "Ethiopia, Addis Ababa",
//       userName: "Shemsedin Nurye",
//       bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
//       avatar: 'https://picsum.photos/200',
//       id: "dummy_id",
//       name: "Dummy Name",
//       email: "dummy@example.com",
//       hash: "dummy_hash",
//       hashedRt: {"type": "dummy_type"},
//       following: ["user1", "user2"],
//       followers: ["user3", "user4"],
//       createdAt: DateTime.now(),
//       role: "dummy_role",
//     );
// =======
//     return MultiBlocProvider(
//         providers: [
//           BlocProvider<PostBloc>(
//             create: (context) => PostBloc(postRepository: postRepository),
//           ),
//           BlocProvider<LoginBloc>(
//               create: (context) => LoginBloc(loginRepository: loginRepository)),
//           BlocProvider(
//               create: (context) =>
//                   SignUpBloc(signUpRepository: signUpRepository)),
//         ],
//         child: MaterialApp.router(
//           theme: lightTheme(),
//           darkTheme: darkTheme(),
//           debugShowCheckedModeBanner: false,
//           routeInformationParser:
//               MyAppRouter.returnRouter(false).routeInformationParser,
//           routerDelegate: MyAppRouter.returnRouter(false).routerDelegate,
//         ));
// >>>>>>> b88b4c8775047a2a7e67aac4ca4414955c30dc12
//   }
// }
