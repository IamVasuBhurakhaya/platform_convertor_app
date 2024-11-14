import 'package:contact_diary_pr/screens/provider/home_provider.dart';
import 'package:contact_diary_pr/screens/views/favourite/views/and_favourite.dart';
import 'package:contact_diary_pr/screens/views/home/views/and_home.dart';
import 'package:contact_diary_pr/screens/views/recent/view/and_recent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AndNavigation extends StatefulWidget {
  const AndNavigation({super.key});

  @override
  State<AndNavigation> createState() => _AndNavigationState();
}

class _AndNavigationState extends State<AndNavigation> {
  HomeProvider read = HomeProvider();
  HomeProvider write = HomeProvider();
  List<Widget> screens = [
    const AndHome(),
    const AndRecent(),
    const AndFavourite(),
  ];
  @override
  Widget build(BuildContext context) {
    read = context.read<HomeProvider>();
    write = context.watch<HomeProvider>();
    return Scaffold(
      body: screens[read.screenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: read.screenIndex,
        onTap: (index) {
          read.changeScreenIndex(index);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
              ),
              label: 'Contact'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
                size: 30,
              ),
              label: 'Recent'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.star,
                size: 30,
              ),
              label: 'Favorite'),
        ],
      ),
    );
  }
}
