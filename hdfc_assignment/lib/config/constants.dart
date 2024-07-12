const String baseURL = 'https://jsonplaceholder.typicode.com/';
final Map<String, String> headers = {'Content-Type': 'application/json'};
final RegExp emailValid = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final RegExp nameValid = RegExp(
    r"^[a-zA-Z]+");
