import 'dart:io';

import 'package:contact_diary_pr/screens/models/home_model.dart';
import 'package:contact_diary_pr/screens/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AndRecent extends StatefulWidget {
  const AndRecent({super.key});

  @override
  State<AndRecent> createState() => _AndRecentState();
}

class _AndRecentState extends State<AndRecent> {
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
          'Recents',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: read.recentList.isEmpty
            ? const Center(
                child: Text(
                  "No Contact",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              )
            : ListView.builder(
                itemCount: watch.recentList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onLongPress: () {
                      read.removeContact(index);
                    },
                    leading: CircleAvatar(
                      foregroundImage:
                          FileImage(File(watch.recentList[index].image ?? '')),
                      child: Center(
                        child: Text(
                            " ${watch.recentList[index].name!.substring(0, 1).toUpperCase()}"),
                      ),
                    ),
                    title: Text(
                      "${watch.recentList[index].name}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 24),
                    ),
                    subtitle: Text(
                      "${watch.recentList[index].number}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    trailing: Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.phone,
                              size: 30,
                            ),
                            onPressed: () {
                              Uri(
                                scheme: 'tel',
                                path: "${watch.recentList[index].number}",
                              );
                              RecentModel model = RecentModel(
                                name: watch.recentList[index].name,
                                number: watch.recentList[index].number,
                                email: watch.recentList[index].email,
                                image: watch.recentList[index].image,
                                date: DateTime.now(),
                              );
                              read.addRecent(model);
                            },
                          ),
                          Text(
                            "${watch.recentList[index].date?.hour}:${watch.recentList[index].date?.minute}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
