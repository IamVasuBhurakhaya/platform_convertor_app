import 'dart:io';
import 'package:contact_diary_pr/screens/models/home_model.dart';
import 'package:contact_diary_pr/screens/provider/home_provider.dart';
import 'package:contact_diary_pr/utils/app_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IosEdit extends StatefulWidget {
  const IosEdit({super.key});

  @override
  State<IosEdit> createState() => _IosEditState();
}

class _IosEditState extends State<IosEdit> {
  HomeProvider read = HomeProvider();
  HomeProvider watch = HomeProvider();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    read = context.read<HomeProvider>();
    watch = context.watch<HomeProvider>();
    HomeModel model = ModalRoute.of(context)!.settings.arguments as HomeModel;
    nameController.text = model.name!;
    numberController.text = model.number!;
    emailController.text = model.email!;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: const Icon(CupertinoIcons.back),
        ),
        middle: const Text('Contact Detail'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                buildShowDialog(context, model);
              },
              child: const Icon(CupertinoIcons.pencil),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                read.favouriteContact();
                Navigator.pop(context);
              },
              child: const Icon(CupertinoIcons.star),
            ),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                foregroundImage: FileImage(
                  File(model.image ?? ''),
                ),
                child: Center(
                  child: Text(
                    model.name!.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              50.h,
              CupertinoListTile(
                leading: const Text(
                  "Name: ",
                ),
                title: Text(model.name!),
              ),
              10.h,
              CupertinoListTile(
                leading: const Text(
                  "Email: ",
                ),
                title: Text(model.email!),
              ),
              10.h,
              CupertinoListTile(
                leading: const Text(
                  "Number: ",
                ),
                title: Text(model.number!),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildShowDialog(BuildContext context, HomeModel model) {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Edit Contact"),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CupertinoTextField(
              controller: nameController,
              placeholder: "Name",
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
            5.h,
            CupertinoTextField(
              controller: emailController,
              placeholder: "Email",
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
            5.h,
            CupertinoTextField(
              controller: numberController,
              placeholder: "Number",
              keyboardType: TextInputType.number,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              HomeModel Model = HomeModel(
                name: nameController.text,
                number: numberController.text,
                email: emailController.text,
                image: model.image,
                isFavourite: model.isFavourite,
              );
              context.read<HomeProvider>().updateContact(Model);
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
