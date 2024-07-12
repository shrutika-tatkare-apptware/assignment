import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:practise_app/providers/user_provider.dart';

void main() {
  group('UserProvider', () {
    test('check length of users list when http response is successful',
        () async {
      // Mock the API call to return a json response with http status 200 Ok //
      final mockHTTPClient = MockClient((request) async {
        // Create sample response of the HTTP call
        const response = [
          {
            "id": 1,
            "name": "Leanne Graham",
            "username": "Bret",
            "email": "Sincere@april.biz",
            "address": {
              "street": "Kulas Light",
              "suite": "Apt. 556",
              "city": "Gwenborough",
              "zipcode": "92998-3874",
              "geo": {"lat": "-37.3159", "lng": "81.1496"}
            },
            "phone": "1-770-736-8031 x56442",
            "website": "hildegard.org",
            "company": {
              "name": "Romaguera-Crona",
              "catchPhrase": "Multi-layered client-server neural-net",
              "bs": "harness real-time e-markets"
            }
          }
        ];
        return http.Response(jsonEncode(response), 200);
      });
      final userProvider = UserProvider(client: mockHTTPClient);
      await userProvider.fetchUsers();
      // check length of users list
      expect(userProvider.users.length, 1);
    });

    test('return error message when http response is unsuccessful', () async {
      // Mock the API call to return an empty json response with http status 404
      try {
        final mockHTTPClient = MockClient((request) async {
          final response = {};
          return http.Response(jsonEncode(response), 404);
        });
        final userProvider = UserProvider(client: mockHTTPClient);
        await userProvider.fetchUsers();
        // throw exception
        fail('Failed to load users');
      } catch (error) {
        expect(error, isInstanceOf<http.ClientException>());
      }
    });
  });
}
