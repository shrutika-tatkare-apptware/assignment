import 'package:flutter/material.dart';
import 'package:practise_app/design_system/color_system.dart';
import 'package:practise_app/design_system/size_system.dart';
import 'package:provider/provider.dart';

import '../config/route_management.dart';
import '../providers/user_provider.dart';
import '../widgets/details_with_icon_widget.dart';
import '../widgets/profile_image.dart';

class UserDetailsScreen extends StatelessWidget {
  final int userId;

  const UserDetailsScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(SizeSystem.size16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blueGrey,
                      ),
                      iconSize: SizeSystem.size18,
                      onPressed: () {
                        // open edit user details form
                        NavigationHandler.pushRoute(
                            Routes.updateUserDetailsScreen,
                            arguments: user.id);
                      },
                    ),
                  ),
                  Center(
                      child: Column(children: [
                    const ProfileImage(),
                    Padding(
                        padding: const EdgeInsets.only(top: SizeSystem.size20),
                        child: Consumer<UserProvider>(
                            builder: (context, userDetails, child) {
                          return Text(
                            userDetails.user!.name!,
                            style: const TextStyle(
                                fontSize: SizeSystem.size20, fontWeight: FontWeight.bold),
                          );
                        })),
                    Consumer<UserProvider>(
                        builder: (context, userDetails, child) {
                      return Text(
                        userDetails.user!.email!,
                        style:
                            const TextStyle(fontSize: 16, color: ColorSystem.grey),
                      );
                    }),
                    const Divider(),
                    DetailsWithIcon(
                      icon: Icons.home,
                      details:
                          '${user.address!.city}, ${user.address!.street}, ${user.address!.zipcode}',
                    ),
                    DetailsWithIcon(
                      icon: Icons.location_city,
                      details: user.company!.name!,
                    ),
                   const Divider(),
                  ])),
                ],
              ),
            ),
    );
  }
}
