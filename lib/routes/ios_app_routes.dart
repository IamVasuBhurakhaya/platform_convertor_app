import 'package:contact_diary_pr/screens/views/addcontact/views/ios_add_contact.dart';
import 'package:contact_diary_pr/screens/views/edit/views/ios_edit.dart';
import 'package:contact_diary_pr/screens/views/home/views/ios_home.dart';
import 'package:contact_diary_pr/screens/views/navigator/view/ios_navigation.dart';
import 'package:contact_diary_pr/screens/views/recent/view/ios_recent.dart';
import 'package:flutter/cupertino.dart';

class IosAppRoutes {
  static String navigator = "/";
  static String home = "home";
  static String addContact = "addContactIos";
  static String details = "detailScreen";
  static String favourite = "favourite";
  static String recent = "recent";

  static Map<String, WidgetBuilder> IosRoutes = {
    "/": (context) => const IosNavigation(),
    "home": (context) => const IosHome(),
    "addContactIos": (context) => const IosAddContact(),
    "detailScreen": (context) => const IosEdit(),
    "recent": (context) => const IosRecent(),
  };
}
