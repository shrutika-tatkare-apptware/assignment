import 'package:flutter/material.dart';
import 'package:practise_app/design_system/size_system.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: SizeSystem.size30,
      child: Icon(
        Icons.person,
        size: SizeSystem.size30,
      ),
    );
  }
}
