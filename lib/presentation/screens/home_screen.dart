import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:picstash/domain/entities/dummy_profile_data.dart';
import 'package:picstash/presentation/screens/post_screen.dart';
import 'package:picstash/presentation/screens/user_profile_screen.dart';

import '../../assets/constants/assets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  List<dynamic> pages = [
    const PostScreen(),
    Container(),
    Container(),
    Container(),
    UserProfileScreen(
      userProfile: DummyProfile.getUserProfile(),
      isOwner: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
}
