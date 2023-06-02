import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import '../../assets/constants/assets.dart';
import '../../domain/entities/login/login_details.dart';
import '../../domain/entities/user_profile/user_profile.dart';
import '../../infrastructure/data_providers/db/db.dart';
import 'search_screen.dart';
import 'chat_list_screen.dart';
import 'error_page.dart';
import 'post_adding.dart';
import 'post_screen.dart';
import 'user_profile_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  Future<UserProfile> getProfile() async {
    LoginCredentials loginCredentials = LoginCredentials();
    LoginDetailsModel? loginDetailsModel =
        await loginCredentials.getLoginCredentials();
    UserProfile userProfile = UserProfile(
        id: loginDetailsModel!.localUserModel.id,
        name: loginDetailsModel.localUserModel.name,
        email: loginDetailsModel.localUserModel.email.toString(),
        userName: loginDetailsModel.localUserModel.username,
        avatar: loginDetailsModel.localUserModel.imageUrl,
        bio: loginDetailsModel.localUserModel.bio,
        role: loginDetailsModel.role);
    return userProfile;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getProfile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<dynamic> pages = [
            const PostScreen(),
            SearchScreen(localUser: snapshot.data!.userName),
            const AddPostWidget(),
            const ChatListScreen(),
            const ErrorPage(),
            UserProfileScreen(
              userProfile: snapshot.data!,
              isOwner: true,
            ),
          ];
          return Scaffold(
            body: pages[selectedIndex],
            bottomNavigationBar: ConvexAppBar(
              backgroundColor: Colors.grey[900],
              activeColor: Colors.black,
              initialActiveIndex: selectedIndex,
              elevation: 0,
              style: TabStyle.fixedCircle,
              items: [
                TabItem(
                    icon: SvgPicture.asset(CustomAssets.kHome),
                    title: '',
                    isIconBlend: true),
                TabItem(
                    icon: SvgPicture.asset(CustomAssets.kSearch),
                    title: '',
                    isIconBlend: true),
                const TabItem(icon: Icons.add, title: '', isIconBlend: true),
                TabItem(
                    icon: SvgPicture.asset(CustomAssets.kChat),
                    title: '',
                    isIconBlend: true),
                TabItem(
                    icon: SvgPicture.asset(CustomAssets.kUserIcon),
                    title: '',
                    isIconBlend: true),
              ],
              onTap: (int i) {
                setState(() {
                  selectedIndex = i;
                });
              },
            ),
          );
        }
        return const Text("error");
      },
    );
  }
}
