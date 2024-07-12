import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practise_app/screens/user_details.dart';

import '../screens/update_user_details.dart';

abstract class Routes {
  static const String home = '/';
  static const String userListScreen = 'userListScreen';
  static const String userDetailsScreen = 'userDetailsScreen';
  static const String updateUserDetailsScreen = 'UpdateuserDetailsScreen';
}

abstract class RouteGenerator {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    int userId = routeSettings.arguments as int;
    switch (routeSettings.name) {
      case Routes.userDetailsScreen:
        return MaterialPageRoute(
          builder: (context) => UserDetailsScreen(
            userId: userId,
          ),
        );
      case Routes.updateUserDetailsScreen:
        return MaterialPageRoute(
          builder: (context) => const UpdateUserFormScreen(
          ),
        );
      default:
        return MaterialPageRoute(builder: (context) {
          return Container();
        });
    }
  }
}

abstract class NavigationHandler {
  static Future<dynamic> pushRoute(String name, {dynamic arguments}) async {
    return Get.toNamed(name, arguments: arguments);
  }

  static Future<dynamic> popRoute({Map<String, dynamic>? data}) async {
    return Get.back(result: data);
  }

}
