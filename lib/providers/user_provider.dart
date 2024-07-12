import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/constants.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  List<User> _users = [];
  final http.Client client;

  UserProvider({http.Client? client}) : client = client ?? http.Client();

  List<User> get users => _users;

  User? _user;

  User? get user => _user;
  
  // load list of users
  Future<void> fetchUsers() async {
    final url = Uri.parse('$baseURL/users');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      _users = data.map((json) => User.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw http.ClientException('Failed to load users');
    }
  }
  
  // get single user details based on Id
  Future<void> fetchUserDetails(int userId) async {
    final url = Uri.parse('$baseURL/users/$userId');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      _user = User.fromJson(data);
      notifyListeners();
    } else {
      throw http.ClientException('Failed to load user details');
    }
  }
  

  // update user specific details
  Future<void> updateUserDetails(
      String newName, String newEmail, String phoneNumber) async {
    final url = Uri.parse('$baseURL/users/${user!.id}');
    final Map<String, dynamic> body = {
      'name': newName,
      'email': newEmail,
      'phone': phoneNumber
    };

    final response =
        await http.Client().put(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      // updated user details for specific user
      _user!.name = responseData['name'];
      _user!.email = responseData['email'];
      _user!.phone = responseData['phone'];
      // updated user details in list view
      User singleUser =
          _users.firstWhere((singleUser) => singleUser.id == user!.id);
      singleUser.name = responseData['name'];
      singleUser.email = responseData['email'];
      singleUser.phone = responseData['phone'];
      notifyListeners();
    } else {
      throw http.ClientException('Failed to update user details');
    }
  }
}
