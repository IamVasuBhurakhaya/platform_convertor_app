import 'dart:convert';
import 'dart:io';
import 'package:contact_diary_pr/routes/and_app_routes.dart';
import 'package:contact_diary_pr/screens/models/home_model.dart';
import 'package:contact_diary_pr/screens/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AndHome extends StatefulWidget {
  const AndHome({super.key});

  @override
  State<AndHome> createState() => _AndHomeState();
}

class _AndHomeState extends State<AndHome> {
  String? name, number, email, path;

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Future<void> getProfile() async {
    name = await watch.getProfileName() as String;
    number = await watch.getProfileNumber() as String;
    email = await watch.getProfileEmail() as String;
    path = await watch.getProfilePath() as String;
  }

  HomeProvider read = HomeProvider();
  HomeProvider watch = HomeProvider();

  @override
  Widget build(BuildContext context) {
    read = context.read<HomeProvider>();
    watch = context.watch<HomeProvider>();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text(
          'Contacts',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AndAppRoutes.addContact);
            },
            icon: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              size: 35,
            ),
            onSelected: (value) {
              switch (value) {
                case 'Profile':
                  Navigator.pushNamed(context, AndAppRoutes.profile);
                  break;
                case 'Platform':
                  read.changePlatform();
                  break;
                case 'Dark Mode':
                  read.changeBrightness(!watch.isDark);
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'Profile',
                  child: Row(
                    children: [
                      Icon(Icons.edit, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        'Profile Settings',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Platform',
                  child: Row(
                    children: [
                      Icon(Icons.phone_android, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        'Ios Platform',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Dark Mode',
                  child: Row(
                    children: [
                      Icon(Icons.dark_mode, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        'Dark Mode',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: read.allContacts.isEmpty
            ? const Center(
                child: Text(
                  "No Contact",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.grey,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: watch.allContacts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onLongPress: () {
                      read.removeContact(index);
                    },
                    onTap: () {
                      read.changeIndex(index);
                      Navigator.pushNamed(context, AndAppRoutes.details,
                          arguments: read.allContacts[index]);
                    },
                    leading: CircleAvatar(
                      radius: 24,
                      foregroundImage:
                          FileImage(File(watch.allContacts[index].image ?? '')),
                      child: Center(
                        child: Text(
                            " ${watch.allContacts[index].name!.substring(0, 1).toUpperCase()}"),
                      ),
                    ),
                    title: Text(
                      "${watch.allContacts[index].name}",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      "${watch.allContacts[index].number}",
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.phone,
                        size: 30,
                      ),
                      onPressed: () {
                        Uri(
                          scheme: 'tel',
                          path: "${watch.allContacts[index].number}",
                        );
                        RecentModel model = RecentModel(
                          name: watch.allContacts[index].name,
                          number: watch.allContacts[index].number,
                          email: watch.allContacts[index].email,
                          image: watch.allContacts[index].image,
                          date: DateTime.now(),
                        );
                        read.addRecent(model);
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
