import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import '../../routes/app_route_constants.dart';

class CustomBottomNavBar extends StatelessWidget {
  final String localUser;
  const CustomBottomNavBar({
    Key? key,
    required this.width,
    required this.localUser
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 65,
        width: width * 0.33,
        margin: const EdgeInsets.only(bottom: 30.0),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: Colors.transparent,
              child: IconButton(
                onPressed: () {
                  GoRouter.of(context)
                      .pushNamed(MyAppRouteConstants.chatScreenSearch, pathParameters: {
                        "localUser": localUser
                      });
                },
                iconSize: 30,
                icon: const Icon(
                  Icons.person_add_rounded,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
