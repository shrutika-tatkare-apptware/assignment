import 'package:flutter/material.dart';
import 'package:practise_app/Utils/snackbar.dart';
import 'package:practise_app/config/route_management.dart';
import 'package:practise_app/design_system/color_system.dart';
import 'package:provider/provider.dart';

import '../design_system/size_system.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../widgets/profile_image.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    // fetch user list
    userProvider.fetchUsers();
    super.initState();
  }

  // fetch user details using id
  void showUserDetails(id) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      await userProvider.fetchUserDetails(id);
      NavigationHandler.pushRoute(Routes.userDetailsScreen, arguments: id);
    } catch (error) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar(
          title: 'Something went wrong !!!',
          bgColor: ColorSystem.red,
          textColor: ColorSystem.white));
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Users'),
        ),
        body: userProvider.users.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : LayoutBuilder(
                // used for responsiveness
                builder: (context, constraints) {
                  if (constraints.maxWidth > SizeSystem.size500) {
                    // if screen / device size is greater than 500 then show gridview
                    return GridView.builder(
                        itemCount: userProvider.users.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                        itemBuilder: (BuildContext context, int index) {
                          User user = userProvider.users[index];
                          return GestureDetector(
                            onTap: () {
                              showUserDetails(user.id);
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: SizeSystem.size10,
                                    horizontal: SizeSystem.size20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: SizeSystem.size10),
                                    const ProfileImage(),
                                    Consumer<UserProvider>(
                                        builder: (context, userDetails, child) {
                                      return Flexible(
                                        child: Text(
                                          userDetails.users[index].name!,
                                          style: const TextStyle(
                                              fontSize: SizeSystem.size20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      );
                                    }),
                                    Visibility(
                                        visible: user.email!.isNotEmpty,
                                        child: Consumer<UserProvider>(builder:
                                            (context, userDetails, child) {
                                          return Flexible(
                                              child: Text(
                                                  'Email: ${userDetails.users[index].email}'));
                                        })),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: SizeSystem.size20,
                          vertical: SizeSystem.size10),
                      itemCount: userProvider.users.length,
                      itemBuilder: (context, index) {
                        User user = userProvider.users[index];
                        return Container(
                            margin: const EdgeInsets.only(
                                bottom: SizeSystem.size10),
                            decoration: BoxDecoration(
                                border: Border.all(color: ColorSystem.grey),
                                borderRadius:
                                    BorderRadius.circular(SizeSystem.size10)),
                            child: ListTile(
                              leading: const ProfileImage(),
                              title: Consumer<UserProvider>(
                                  builder: (context, userDetails, child) {
                                return Text(
                                  userDetails.users[index].name!,
                                  style: const TextStyle(
                                      fontSize: SizeSystem.size20,
                                      fontWeight: FontWeight.w500),
                                );
                              }),
                              subtitle: Visibility(
                                  visible: user.email!.isNotEmpty,
                                  child: Consumer<UserProvider>(
                                      builder: (context, userDetails, child) {
                                    return Text(
                                        'Email: ${userDetails.users[index].email}');
                                  })),
                              onTap: () {
                                showUserDetails(user.id);
                              },
                            ));
                      },
                    );
                  }
                },
              ));
  }
}
