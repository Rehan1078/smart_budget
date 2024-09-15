import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_budget/AddDetailsOfUser/AddAccountNameScreen.dart';
import 'package:smart_budget/MainScreen.dart';
import 'package:smart_budget/OnBroadingScreen/onBroadScreen_1.dart';

late Future<String> _nameFuture;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bool isOnboardingComplete = await _isOnboardingComplete();
  final bool isInitialSetupComplete = await _isInitialSetupComplete();
  final String userName = await _getUserName();
  _nameFuture = _fetchNameFromSharedPreferences();
  runApp(MyApp(
    isOnboardingComplete: isOnboardingComplete,
    isInitialSetupComplete: isInitialSetupComplete,
    userName: userName,
  ));

}

Future<bool> _isOnboardingComplete() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isOnboardingComplete') ?? false;
}

Future<bool> _isInitialSetupComplete() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isInitialSetupComplete') ?? false;
}

Future<String> _getUserName() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userName') ?? 'User';
}

Future<String> _fetchNameFromSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('name_key') ?? 'Default Name'; // Replace 'name_key' with your actual key
}

class MyApp extends StatelessWidget {
  final bool isOnboardingComplete;
  final bool isInitialSetupComplete;
  final String userName;

  const MyApp({
    super.key,
    required this.isOnboardingComplete,
    required this.isInitialSetupComplete,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: isOnboardingComplete
          ? (isInitialSetupComplete ? Mainscreen() : AddName())
          : onBroad1(),
    );
  }
}
