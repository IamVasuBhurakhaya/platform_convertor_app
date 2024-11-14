import 'dart:io';

import 'package:contact_diary_pr/routes/and_app_routes.dart';
import 'package:contact_diary_pr/screens/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AndFavourite extends StatefulWidget {
  const AndFavourite({super.key});

  @override
  State<AndFavourite> createState() => _AndFavouriteState();
}

class _AndFavouriteState extends State<AndFavourite> {
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
          'Favorites',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: read.allContacts.isNotEmpty
            ? ListView.builder(
                itemCount: watch.allContacts.length,
                itemBuilder: (context, index) {
                  return Visibility(
                    visible: read.allContacts[index].isFavourite == true,
                    child: ListTile(
                      onTap: () {
                        read.changeIndex(index);
                        Navigator.pushNamed(context, AndAppRoutes.details,
                            arguments: read.allContacts[index]);
                      },
                      leading: CircleAvatar(
                        foregroundImage: FileImage(
                            File(watch.allContacts[index].image ?? '')),
                        child: Center(
                          child: Text(
                              " ${watch.allContacts[index].name!.substring(0, 1).toUpperCase()}"),
                        ),
                      ),
                      title: Text("${watch.allContacts[index].name}"),
                      subtitle: Text("${watch.allContacts[index].number}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.phone),
                        onPressed: () {},
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: Text(
                  "No Contact",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.grey,
                  ),
                ),
              ),
      ),
    );
  }
}
