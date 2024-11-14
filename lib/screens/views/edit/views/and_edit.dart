import 'dart:io';
import 'package:contact_diary_pr/screens/models/home_model.dart';
import 'package:contact_diary_pr/screens/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AndEdit extends StatefulWidget {
  const AndEdit({super.key});

  @override
  State<AndEdit> createState() => _AndEditState();
}

class _AndEditState extends State<AndEdit> {
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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
        ),
        title: const Text(
          'Contact Detail',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  title: const Text("Edit Contact",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  content: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Name Text Field
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: "Name",
                            labelStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter a name";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        // Email Text Field
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return "Please enter a valid email.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        // Phone Number Text Field
                        TextFormField(
                          controller: numberController,
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                            labelStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 10) {
                              return "Please enter a valid phone number.";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    // Save Button
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          HomeModel updatedModel = HomeModel(
                            name: nameController.text,
                            number: numberController.text,
                            email: emailController.text,
                            image: model.image,
                            isFavourite: model.isFavourite,
                          );
                          context
                              .read<HomeProvider>()
                              .updateContact(updatedModel);
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text("Save"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(
              Icons.edit,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              read.favouriteContact();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.star_border,
              size: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile Picture with Styling
              CircleAvatar(
                radius: 80,
                backgroundImage: FileImage(File(model.image ?? '')),
                child: model.image == null
                    ? const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      )
                    : null,
              ),
              const SizedBox(height: 20),
              // Name
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading:
                    const Icon(Icons.person, color: Colors.black, size: 30),
                title: Text(
                  model.name!,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ),
              const Divider(),
              // Email
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.email, color: Colors.black, size: 30),
                title: Text(
                  model.email!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const Divider(),
              // Phone Number
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.phone, color: Colors.black, size: 30),
                title: Text(
                  model.number!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
