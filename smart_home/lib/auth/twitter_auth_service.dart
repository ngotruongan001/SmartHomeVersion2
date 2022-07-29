// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:twitter_login/twitter_login.dart';
//
// class TwitterServicce {
//
// void signInWithTwitter() async {
//   // Create a TwitterLogin instance
//   final twitterLogin = TwitterLogin(
//       apiKey: 'uCy2FA4r4hvAv8gsySvlewWDJ',
//       apiSecretKey: '8qaubsLhBYHaRkUuJuQwF1XksWmKB1MxHzIKpnAIYnTuhK6qcp',
//       // redirectURI: 'flutter-twitter-login://'
//   );
//
//   // Trigger the sign-in flow
//   await twitterLogin.login().then((value) async {
//     final twitterAuthCredential = TwitterAuthProvider.credential(
//       accessToken: value.authToken!,
//       secret: value.authTokenSecret!,
//     );
//     await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
//   });
// }
// }