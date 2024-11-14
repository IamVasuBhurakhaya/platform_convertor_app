import 'package:contact_diary_pr/screens/views/addcontact/views/and_add_contact.dart';
import 'package:contact_diary_pr/screens/views/edit/views/and_edit.dart';
import 'package:contact_diary_pr/screens/views/favourite/views/and_favourite.dart';
import 'package:contact_diary_pr/screens/views/home/views/ios_home.dart';
import 'package:contact_diary_pr/screens/views/navigator/view/and_navigation.dart';
import 'package:contact_diary_pr/screens/views/profile/view/profile.dart';
import 'package:contact_diary_pr/screens/views/recent/view/and_recent.dart';
import 'package:flutter/material.dart';

class AndAppRoutes {
  static String navigator = "/";

  static String home = "home";
  static String addContact = "addContactPage";
  static String details = "detailScreen";
  static String favourite = "favourite";
  static String recent = "recent";
  static String profile = "profile";

  static Map<String, WidgetBuilder> andRoutes = {
    "/": (context) => const AndNavigation(),
    'home': (context) => const IosHome(),
    "addContactPage": (context) => const AndAddContact(),
    "detailScreen": (context) => const AndEdit(),
    "favourite": (context) => const AndFavourite(),
    "recent": (context) => const AndRecent(),
    "profile": (context) => const Profile(),
  };
}
