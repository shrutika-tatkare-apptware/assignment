import 'package:flutter/material.dart';

import '../design_system/size_system.dart';

class DetailsWithIcon extends StatelessWidget {
  const DetailsWithIcon({super.key, required this.icon, required this.details});
  final IconData icon;
  final String details;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.blueGrey,),
        const SizedBox(
          width: SizeSystem.size20,
        ),
        Expanded(
          child: Text(details),
        ),
      ],
    );
  }
}
