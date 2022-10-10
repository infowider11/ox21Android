import 'package:flutter/material.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/widgets/appbar.dart';

class ScanQRCodePage extends StatefulWidget {
  static const String id = 'scan_qr_code_page';
  const ScanQRCodePage({Key? key}) : super(key: key);

  @override
  _ScanQRCodePageState createState() => _ScanQRCodePageState();
}

class _ScanQRCodePageState extends State<ScanQRCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context: context,
        title: 'Wallet',
        actions: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Image.asset(MyImages.galleryIcon,),
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Image.asset(MyImages.cameraScan),
        ),
      ),
    );
  }
}
