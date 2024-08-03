import 'package:electricity/services/authServices.dart';
import 'package:electricity/services/general%20services/custom_route.dart';
import 'package:electricity/services/general%20services/user.dart';
import 'package:electricity/view/BottomBar/BottomBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/auth';

  LoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String?> _loginUser(LoginData data) async {
    try {
      final userData = await _authService.loginUser(data.name, data.password);
      if (userData != null) {
        // Login successful, handle userData and navigate to next screen
        // Navigator.of(context).pushReplacement(
        //   FadePageRoute(
        //     builder: (context) => BottomBar(),
        //   ),
        // );
        return null;
      } else {
        return "Invalid Credentials";
      }
    } catch (e) {
      return 'Error occurred during login';
    }
  }

  final AuthService _authService = AuthService();

  Future<String?> _signupUser(SignupData data) async {
    try {
      print(data.additionalSignupData!['FirstName']);

      final userData = await _authService.registerUser(
          data.name.toString(),
          data.password.toString(),
          data.additionalSignupData!['FirstName'].toString(),
          data.additionalSignupData!['LastName'].toString());
      if (userData != null) {
        // Login successful, handle userData and navigate to next screen
        // Navigator.of(context).pushReplacement(
        //   FadePageRoute(
        //     builder: (context) => BottomBar(),
        //   ),
        // );
        return null;
      } else {
        return "Invalid Credentials";
      }
    } catch (e) {
      return 'Error occurred during login';
    }
  }

  Future<String?> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      // if (!mockUsers.containsKey(name)) {
      //   return 'User not exists';
      // }
      return null;
    });
  }

  Future<String?> _signupConfirm(String error, LoginData data) {
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: "Eco Track",
      // logo: const AssetImage('assets/images/ecorp.png'),
      // logoTag: Constants.logoTag,
      // titleTag: Constants.titleTag,
      navigateBackAfterRecovery: true,
      onConfirmRecover: _signupConfirm,
      // onConfirmSignup: _signupConfirm,
      loginAfterSignUp: false,
      userType: LoginUserType.phone,
      termsOfService: [
        TermOfService(
          id: 'general-term',
          mandatory: true,
          text: 'Term of services',
          linkUrl: 'https://github.com/1developersanju/',
        ),
      ],
      additionalSignupFields: const [
        UserFormField(
          keyName: 'FirstName',
          icon: Icon(Icons.person),
        ),
        UserFormField(
          keyName: 'LastName',
          icon: Icon(Icons.person),
        ),
      ],

      theme: LoginTheme(
        primaryColor: Colors.teal,
        errorColor: Colors.deepOrange,
        logoWidth: 0.80,
        titleStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Quicksand',
          letterSpacing: 4,
        ),
      ),
      userValidator: (value) {
        if (value!.contains(' ')) {
          return "username must not contain any spaces instead use '_'";
        }
        return null;
      },
      passwordValidator: (value) {
        if (value!.isEmpty) {
          return 'Password is empty';
        }
        return null;
      },
      onLogin: (loginData) {
        debugPrint('Login info');
        debugPrint('Name: ${loginData.name}');
        debugPrint('Password: ${loginData.password}');
        return _loginUser(loginData);
      },
      onSignup: (signupData) {
        debugPrint('Signup info');
        debugPrint('Name: ${signupData.name}');
        debugPrint('Password: ${signupData.password}');

        signupData.additionalSignupData?.forEach((key, value) {
          debugPrint('$key: $value');
        });
        if (signupData.termsOfService.isNotEmpty) {
          debugPrint('Terms of service: ');
          for (final element in signupData.termsOfService) {
            debugPrint(
              ' - ${element.term.id}: ${element.accepted == true ? 'accepted' : 'rejected'}',
            );
          }
        }
        return _signupUser(signupData);
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(
          FadePageRoute(
            builder: (context) => BottomBar(),
          ),
        );
      },
      onRecoverPassword: (name) {
        debugPrint('Recover password info');
        debugPrint('Name: $name');
        return _recoverPassword(name);
        // Show new password dialog
      },
      headerWidget: const IntroWidget(),
    );
  }
}

class IntroWidget extends StatelessWidget {
  const IntroWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // Text.rich(
        //   TextSpan(
        //     children: [
        //       TextSpan(
        //         text: "You are trying to login/sign up on server hosted on ",
        //       ),
        //       TextSpan(
        //         text: "example.com",
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //     ],
        //   ),
        //   textAlign: TextAlign.justify,
        // ),
        Row(
          children: <Widget>[
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Authenticate"),
            ),
            Expanded(child: Divider()),
          ],
        ),
      ],
    );
  }
}
