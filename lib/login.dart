import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:flutter_animated_login/flutter_animated_login.dart';
import 'package:mon/homescreen.dart';

ValueNotifier<bool> isDark = ValueNotifier<bool>(false);

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDark,
      builder: (context, value, child) => MaterialApp(
        title: 'Stocks',
        themeMode: value ? ThemeMode.light : ThemeMode.light,
        theme: value ? ThemeData.light() : ThemeData.light(),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          floatingActionButton: FilledButton(
            onPressed: () => isDark.value = !isDark.value,
            child: value
                ? const Text("Login with OTP")
                : const Text("Login with Password"),
          ),
          body: FlutterAnimatedLogin(
            loginType: value ? LoginType.password : LoginType.otp,
            onLogin: (loginData) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Homescreen()),
              );
              // Remove the following lines to prevent premature hiding of the keyboard
              // SystemChannels.textInput.invokeMethod('TextInput.hide');
              // TextInput.finishAutofillContext();
              return null;
            },
            loginConfig: const LoginConfig(
              logo: FlutterLogo(size: 100),
              title: 'Stocks',
              // subtitle: 'Let\'s Sign In',
            ),
          ),
        ),
      ),
    );
  }
}
