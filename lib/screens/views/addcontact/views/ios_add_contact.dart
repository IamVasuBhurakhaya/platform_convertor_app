import 'dart:io';
import 'package:contact_diary_pr/screens/models/home_model.dart';
import 'package:contact_diary_pr/screens/provider/home_provider.dart';
import 'package:contact_diary_pr/utils/app_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class IosAddContact extends StatefulWidget {
  const IosAddContact({super.key});

  @override
  State<IosAddContact> createState() => _IosAddContactState();
}

class _IosAddContactState extends State<IosAddContact> {
  HomeProvider read = HomeProvider();
  HomeProvider watch = HomeProvider();
  String? path;
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    read = context.read<HomeProvider>();
    watch = context.watch<HomeProvider>();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: const Icon(CupertinoIcons.back),
        ),
        middle: const Text(
          'Add Contact',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                path == null
                    ? const CircleAvatar(
                        radius: 60,
                        child: Icon(CupertinoIcons.person),
                      )
                    : CircleAvatar(
                        radius: 60,
                        backgroundImage: FileImage(File(path!)),
                      ),
                const SizedBox(height: 20),
                CupertinoButton.filled(
                  onPressed: () async {
                    ImagePicker imagePicker = ImagePicker();
                    XFile? image = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    setState(() {
                      path = image?.path;
                    });
                  },
                  child: const Text('Add Photo'),
                ),
                const SizedBox(height: 30),
                CupertinoTextField(
                  controller: nameController,
                  placeholder: 'Name',
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CupertinoColors.inactiveGray,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 16),
                CupertinoTextField(
                  controller: numberController,
                  placeholder: 'Number',
                  keyboardType: TextInputType.number,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CupertinoColors.inactiveGray,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 16),
                CupertinoTextField(
                  controller: emailController,
                  placeholder: 'Email',
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CupertinoColors.inactiveGray,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 30),
                CupertinoButton.filled(
                  onPressed: () {
                    bool isValid = formKey.currentState?.validate() ?? false;
                    if (isValid) {
                      String name = nameController.text;
                      String number = numberController.text;
                      String email = emailController.text;

                      HomeModel details = HomeModel(
                        name: name,
                        number: number,
                        email: email,
                        image: path,
                        isFavourite: false,
                      );
                      read.addContact(details);
                      Navigator.pop(context);
                    } else {
                      showCupertinoDialog(
                        context: context,
                        builder: (BuildContext context) => CupertinoAlertDialog(
                          title: const Text('Error'),
                          content: const Text('Please Fill All Fields'),
                          actions: [
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text('Save Contact'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
