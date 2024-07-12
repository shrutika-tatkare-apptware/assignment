import 'package:flutter/material.dart';
import 'package:practise_app/config/constants.dart';
import 'package:practise_app/config/route_management.dart';
import 'package:practise_app/design_system/color_system.dart';
import 'package:practise_app/design_system/size_system.dart';
import 'package:provider/provider.dart';

import '../Utils/snackbar.dart';
import '../providers/user_provider.dart';

class UpdateUserFormScreen extends StatefulWidget {
  const UpdateUserFormScreen({super.key});

  @override
  UpdateUserFormScreenState createState() => UpdateUserFormScreenState();
}

class UpdateUserFormScreenState extends State<UpdateUserFormScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _nameController =
        TextEditingController(text: userProvider.user?.name ?? '');
    _emailController =
        TextEditingController(text: userProvider.user?.email ?? '');
    _phoneController =
        TextEditingController(text: userProvider.user?.phone ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Details'),
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(SizeSystem.size16),
              child: Form(
                key: _formKey, // form key created for validation
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        if (!nameValid.hasMatch(value)) {
                          //  check name format
                          return 'Please enter a valid name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: SizeSystem.size10),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }

                        if (!emailValid.hasMatch(value)) {
                          //  check name format
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration:
                          const InputDecoration(labelText: 'Contact Number'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: SizeSystem.size20),
                    Center(
                      child: loading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey),
                              onPressed: () async {
                                try {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    setState(() => loading = true);
                                    // API call to update user details
                                    await userProvider.updateUserDetails(
                                        _nameController.text.trim(),
                                        _emailController.text.trim(),
                                        _phoneController.text.trim());
                                    setState(() => loading = false);
                                    // show snackbar with success msg
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        snackBar(
                                            title:
                                                'User Updated Successfully !!!',
                                            bgColor: Colors.blueAccent,
                                            textColor: ColorSystem.white));
                                    NavigationHandler.popRoute();
                                  }
                                } catch (error) {
                                  setState(() => loading = false);
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackBar(
                                          title: 'Something went wrong !!!',
                                          bgColor: ColorSystem.red,
                                          textColor: ColorSystem.white));
                                }
                              },
                              child: const Text(
                                'Update',
                                style: TextStyle(color: ColorSystem.white),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
