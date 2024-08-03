import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  // Method to set a boolean value in SharedPreferences
  Future<void> setBoolFromSharedPreferences(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogged', value);
  }

  // Method to get a boolean value from SharedPreferences
  Future<bool?> getBoolFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLogged');
  }

  Future<void> setProfileImage(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("setted");
    await prefs.setString('setProfile', value);
  }

  // Method to get a boolean value from SharedPreferences
  Future<String?> getProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("test1 ${prefs.getString('setProfile')}");
    return prefs.getString('setProfile');
  }
}

class DataConstants {
  static String baseUrl =
      'https://eco-track.onrender.com'; // Replace with your base URL
}

class TextStyles {
  static const double headingSize = 24.0;
  static const double subHeadingSize = 20.0;
  static const double normalTextSize = 16.0;
  static const double smallTextSize = 14.0;

  static const TextStyle heading = TextStyle(
    fontSize: headingSize,
    fontWeight: FontWeight.bold,
    // Other properties like color, letterSpacing, etxc. can be added here
  );
  static const TextStyle headingWhite = TextStyle(
      fontSize: headingSize, fontWeight: FontWeight.bold, color: Colors.white
      // Other properties like color, letterSpacing, etxc. can be added here
      );

  static const TextStyle electricity = TextStyle(
      fontSize: headingSize, fontWeight: FontWeight.bold, color: Colors.teal
      // Other properties like color, letterSpacin g, etxc. can be added here
      );
  static const TextStyle water = TextStyle(
      fontSize: headingSize, fontWeight: FontWeight.bold, color: Colors.blue
      // Other properties like color, letterSpacin g, etxc. can be added here
      );

  static const TextStyle subHeadingItalic = TextStyle(
      fontSize: subHeadingSize,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic
      // Other properties like color, letterSpacing, etc. can be added here
      );
  static const TextStyle subHeading = TextStyle(
    fontSize: subHeadingSize,
    fontWeight: FontWeight.bold,

    // Other properties like color, letterSpacing, etc. can be added here
  );

  static const TextStyle subHeadingPaid = TextStyle(
      fontSize: subHeadingSize, fontWeight: FontWeight.bold, color: Colors.teal
      // Other properties like color, letterSpacing, etc. can be added here
      );
  static const TextStyle subHeadingUnPaid = TextStyle(
      fontSize: normalTextSize, fontWeight: FontWeight.bold, color: Colors.red

      // Other properties like color, letterSpacing, etc. can be added here
      );

  static const TextStyle subHeadingWhite = TextStyle(
    fontSize: subHeadingSize,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    // Other properties like color, letterSpacing, etc. can be added here
  );

  static const TextStyle normalText = TextStyle(
    fontSize: normalTextSize,
    // Other properties like color, letterSpacing, etc. can be added here
  );

  static const TextStyle normalTextWhite =
      TextStyle(fontSize: normalTextSize, color: Colors.white
          // Other properties like color, letterSpacing, etc. can be added here
          );
  static const TextStyle normalTextBold = TextStyle(
      fontSize: normalTextSize, color: Colors.black, fontWeight: FontWeight.bold
      // Other properties like color, letterSpacing, etc. can be added here
      );

  static const TextStyle smallText = TextStyle(
    fontSize: smallTextSize,
    // Other properties like color, letterSpacing, etc. can be added here
  );
}

class ColorConstants {
  static const Color white = Colors.white;
  static const Color teal = Colors.teal;
  static const Color blue = Colors.blue;
}
