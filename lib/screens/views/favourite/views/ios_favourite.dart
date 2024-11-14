import 'dart:io';

import 'package:contact_diary_pr/routes/ios_app_routes.dart';
import 'package:contact_diary_pr/screens/provider/home_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IosFavourite extends StatefulWidget {
  const IosFavourite({super.key});

  @override
  State<IosFavourite> createState() => _IosFavouriteState();
}

class _IosFavouriteState extends State<IosFavourite> {
  HomeProvider read = HomeProvider();
  HomeProvider watch = HomeProvider();

  @override
  Widget build(BuildContext context) {
    read = context.read<HomeProvider>();
    watch = context.watch<HomeProvider>();

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          'Favorite',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: read.allContacts.isEmpty
            ? const Center(
                child: Text(
                  "No Contact",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.grey,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: watch.allContacts.length,
                itemBuilder: (context, index) {
                  return Visibility(
                    visible: read.allContacts[index].isFavourite == true,
                    child: GestureDetector(
                      onTap: () {
                        read.changeIndex(index);
                        Navigator.pushNamed(
                          context,
                          IosAppRoutes.details,
                          arguments: read.allContacts[index],
                        );
                      },
                      child: CupertinoListTile(
                        leading: CircleAvatar(
                          foregroundImage: FileImage(
                              File(watch.allContacts[index].image ?? '')),
                          child: Center(
                            child: Text(
                              " ${watch.allContacts[index].name!.substring(0, 1).toUpperCase()}",
                            ),
                          ),
                        ),
                        title: Text("${watch.allContacts[index].name}"),
                        subtitle: Text("${watch.allContacts[index].number}"),
                        trailing: CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: const Icon(CupertinoIcons.phone),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
