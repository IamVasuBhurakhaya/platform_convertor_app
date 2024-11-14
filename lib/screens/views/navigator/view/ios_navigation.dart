import 'package:contact_diary_pr/screens/views/favourite/views/ios_favourite.dart';
import 'package:contact_diary_pr/screens/views/home/views/ios_home.dart';
import 'package:contact_diary_pr/screens/views/recent/view/ios_recent.dart';
import 'package:flutter/cupertino.dart';

class IosNavigation extends StatefulWidget {
  const IosNavigation({super.key});

  @override
  State<IosNavigation> createState() => _IosNavigationState();
}

class _IosNavigationState extends State<IosNavigation> {
  List<Widget> screens = [
    const IosHome(),
    const IosRecent(),
    const IosFavourite(),
  ];
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.clock),
            label: 'Recent',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.star),
            label: 'Favorite',
          ),
        ]),
        tabBuilder: (context, index) => screens[index]);
  }
}
