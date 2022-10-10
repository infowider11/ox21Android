// import 'package:flutter/material.dart';
// import 'package:ox21/constants/global_constants.dart';
// import 'package:ox21/widgets/appbar.dart';
// import 'package:encrypt/encrypt.dart' as encrypt;
//
// class CreatePrivateChannel extends StatefulWidget {
//   const CreatePrivateChannel({Key? key}) : super(key: key);
//
//   @override
//   _CreatePrivateChannelState createState() => _CreatePrivateChannelState();
// }
//
// class _CreatePrivateChannelState extends State<CreatePrivateChannel> {
//   static String data = 'manish talreja';
//   // final iv = encrypt.IV.fromLength(16);
//   // final encrypt.Key key = encrypt.Key.fromUtf8(MyGlobalConstants.passwordSalt);
//   // final encrypter = encrypt.Encrypter(encrypt.AES(key));
//   // final encrypted = encrypter.encrypt(data, iv: iv);
//   // print(encrypted.base64);
//
//   static final key = encrypt.Key.fromUtf8(MyGlobalConstants.passwordSalt);
//   static final iv = encrypt.IV.fromLength(16);
//
//   static final encrypter = encrypt.Encrypter(
//       encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
//   final encrypted = encrypter.encrypt(data, iv: iv);
//   @override
//   Widget build(BuildContext context) {
//     print(encrypted.base64);
//     print(iv.base64);
//
//     return Scaffold(
//       appBar: appBar(context: context, title: 'Create Private Channel'),
//       body: Container(
//         child: Column(
//           children: [],
//         ),
//       ),
//     );
//   }
// }
