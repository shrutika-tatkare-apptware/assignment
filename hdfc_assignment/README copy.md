Objective:

Create a Flutter application that connects to an open API service, fetches data, displays it in a user-friendly manner, and allows users to update data back to the service.

Requirements:

        1.      Fetch Data from Open API:

        •       Use an open API, such as the JSONPlaceholder API, to fetch a list of users.

        •       Display the list of users in a responsive UI.

        2.      Display User Details:

        •       When a user is selected from the list, display detailed information about the user, including name, email, address, and company.

        3.      Update User Information:

        •       Allow users to update their name, email, and phone number.

        •       Implement a save button to send the updated data back to the server using a PUT request.

        •       Display a success message once the update is completed successfully.

        4.      State Management:

        •       Implement state management using the Provider package to manage the state of the application.

        5.      Error Handling:

        •       Implement proper error handling for network requests.

        •       Display appropriate error messages to the user in case of failures.

        6.      Testing:

        •       Write unit tests for the data fetching logic.

        •       Write widget tests for the UI components.

        7.      Documentation:

        •       Provide clear and concise documentation on how to set up and run the application.

Overview
This Flutter project is designed to perform above mentioned requirements.

Project Structure
models/
Contains Dart classes representing data models used throughout the application.

providers/
Includes state management classes using providers for managing application state and data.

constants/
Holds Dart files defining constants such as API endpoints, app configurations, and other constants.

utils/
Includes utility functions and helper classes used across the project, such as common toast message etc.

screens/
Contains the main screens of the application implemented as StatelessWidget or StatefulWidget.

design_system/
Defines reusable components, themes, and styles that maintain consistency across the app's UI.

widgets/
Includes custom widgets used throughout the application, enhancing code reusability and maintainability.


To run this app on your device, follow these steps:

Prerequisites
Flutter SDK installed on your development machine.
Git installed on your machine.
Clone the Repository
Clone this repository to your local machine:

git clone https://gitlab.com/ShrutiKaTatkare/hdfc_assignment.git
cd hdfc_assignment

Install Dependencies
Navigate to the project directory and install dependencies:
flutter pub get

Run the app
flutter run

Check application health
flutter doctor

Check code cleanliness
flutter analyze

Run unit test
flutter test test/unit_test.dart

Run widget test
flutter test test/widget_test.dart



