import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picstash/application/login_bloc/login_blocs.dart';
import 'package:picstash/application/signup_bloc/sign_up_block.dart';
import 'package:picstash/infrastructure/data_providers/db/db.dart';
import 'package:picstash/infrastructure/data_providers/signup/signup_data_provider.dart';
import 'package:picstash/infrastructure/repository/comment/comment_repository.dart';
import 'package:picstash/infrastructure/repository/login_repository/login_repository.dart';
import 'package:picstash/infrastructure/repository/signup_repository/sign_up_repository.dart';
import 'package:picstash/presentation/components/theme.dart';
import 'application/comment_bloc/comment_blocs.dart';
import 'application/bloc_observer.dart';
import 'application/chat_bloc/chat_bloc.dart';
import 'application/post_bloc/post_blocs.dart';
import 'application/search_bloc/search_blocs.dart';
import 'application/user_profile_bloc/blocs.dart';
import 'domain/repositories/chat_repository.dart';
import 'domain/repositories/post_repository.dart';
import 'domain/repositories/user_profile_repository.dart';
import 'infrastructure/data_providers/comment/comment_data_provider.dart';
import 'infrastructure/data_providers/user_profile_data_provider.dart';
import 'infrastructure/data_providers/post_data_provider.dart';
import 'infrastructure/data_providers/chat_data_provider.dart';
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
  final CommentRepository commentRepository =
      CommentRepository(commentDataProvider: CommentDataProvider());

  final ChatRepository chatRepository = ChatRepository(ChatDataProvider());
  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp(
    signUpRepository: signUpRepository,
    commentRepository: commentRepository,
    loginRepository: loginRepository,
    postRepository: postRepository,
    chatRepository: chatRepository,
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final PostRepository postRepository;
  final LoginRepository loginRepository;
  final SignUpRepository signUpRepository;
  final CommentRepository commentRepository;
  final ChatRepository chatRepository;
  final bool isLoggedIn;

  const MyApp({
    Key? key,
    required this.postRepository,
    required this.loginRepository,
    required this.signUpRepository,
    required this.commentRepository,
    required this.chatRepository,
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
        BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(signUpRepository: signUpRepository),
        ),
        BlocProvider<ChatBloc>(
          create: (context) => ChatBloc(chatRepository: chatRepository),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(chatRepository: chatRepository),
        ),
        BlocProvider(
            create: ((context) =>
                CommentBloc(commentRepository: commentRepository))),
        BlocProvider(
          create: (context) => UserProfileBloc(
              userProfileRepository: UserProfileRepository(
                  dataProvider: UserProfileDataProvider())),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: darkTheme(),
        routeInformationParser:
            MyAppRouter.returnRouter(isLoggedIn).routeInformationParser,
        routerDelegate: MyAppRouter.returnRouter(isLoggedIn).routerDelegate,
      ),
    );
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
