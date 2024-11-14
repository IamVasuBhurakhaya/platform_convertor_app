import 'dart:io';
import 'package:contact_diary_pr/routes/ios_app_routes.dart';
import 'package:contact_diary_pr/screens/models/home_model.dart';
import 'package:contact_diary_pr/screens/provider/home_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IosHome extends StatefulWidget {
  const IosHome({super.key});

  @override
  State<IosHome> createState() => _IosHomeState();
}

class _IosHomeState extends State<IosHome> {
  HomeProvider read = HomeProvider();
  HomeProvider watch = HomeProvider();

  @override
  Widget build(BuildContext context) {
    read = context.read<HomeProvider>();
    watch = context.watch<HomeProvider>();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.add),
          onPressed: () {
            Navigator.pushNamed(context, IosAppRoutes.addContact);
          },
        ),
        middle: const Text(
          'Contacts',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoSwitch(
              value: watch.isDark,
              onChanged: (value) {
                read.changeBrightness(value);
              },
            ),
            CupertinoSwitch(
              value: watch.isAndroid,
              onChanged: (value) {
                read.changePlatform();
              },
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.ellipsis_vertical),
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) => CupertinoActionSheet(
                    title: const Text('Options'),
                    actions: [
                      CupertinoActionSheetAction(
                        onPressed: () {},
                        child: const Text("Profile Setting"),
                      ),
                    ],
                    cancelButton: CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: read.allContacts.isEmpty
                  ? const Center(child: Text("No Contact"))
                  : ListView.builder(
                      itemCount: watch.allContacts.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            read.changeIndex(index);
                            Navigator.pushNamed(context, IosAppRoutes.details,
                                arguments: read.allContacts[index]);
                          },
                          child: CupertinoListTile(
                            title: Text(
                              "${watch.allContacts[index].name}",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "${watch.allContacts[index].number}",
                              style: const TextStyle(fontSize: 17),
                            ),
                            leading: CircleAvatar(
                              foregroundImage: FileImage(
                                  File(watch.allContacts[index].image ?? '')),
                              child: Center(
                                child: Text(watch.allContacts[index].name!
                                    .substring(0, 1)
                                    .toUpperCase()),
                              ),
                            ),
                            trailing: CupertinoButton(
                              child: const Icon(CupertinoIcons.phone),
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
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
