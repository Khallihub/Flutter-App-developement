import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:picstash/application/login_bloc/login_blocs.dart';
import 'package:picstash/application/login_bloc/login_event.dart';
import 'package:picstash/application/login_bloc/login_state.dart';
import 'package:picstash/presentation/routes/app_route_constants.dart';
import 'package:picstash/presentation/screens/login_page.dart';

class CustomPopupMenu extends StatefulWidget {
  const CustomPopupMenu({super.key});

  @override
  State<CustomPopupMenu> createState() => _CustomPopupMenuState();
}

class _CustomPopupMenuState extends State<CustomPopupMenu> {
  late String _selectedOption;

  final List<String> _menuOptions = [
    'Edit Profile',
    'Settings',
    'Log out',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LogOutSuccess) {
          GoRouter.of(context).pushReplacement("/");
        } else if (state is LogOutFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("invalid credentials or connection problem"),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case LogOutLoading:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case LogOutSuccess:
            return const LogIn();
          default:
            return PopupMenuButton<String>(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onSelected: (String value) {
                setState(() {
                  _selectedOption = value;
                });
                if (_selectedOption == "Edit Profile") {
                  GoRouter.of(context)
                      .pushNamed(MyAppRouteConstants.editProfileRouteName);
                } else if (_selectedOption == "Settings") {
                  GoRouter.of(context)
                      .pushNamed(MyAppRouteConstants.notImplemented);
                } else if (_selectedOption == "Log out") {
                  BlocProvider.of<LoginBloc>(context)
                      .add(LogOutButtonPressed());
                }
              },
              itemBuilder: (BuildContext context) {
                return _menuOptions.map((String option) {
                  return PopupMenuItem<String>(
                    value: option,
                    child: Text(
                      option,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList();
              },
              offset: const Offset(0, 50),
              color: Colors.grey[700],
            );
        }
      },
    );
  }
}
