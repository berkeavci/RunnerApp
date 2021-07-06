import 'package:flutter/material.dart';
/*

  Authentication Class based on ApplicationLoginState enums to 
  track User on progress and change widgets according to that logic. 

*/

enum ApplicationLoginState {
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
}
