import 'package:flutter/material.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrToJoinGroupPage extends StatefulWidget {
  const ScanQrToJoinGroupPage({Key? key}) : super(key: key);

  @override
  State<ScanQrToJoinGroupPage> createState() => _ScanQrToJoinGroupPageState();
}

class _ScanQrToJoinGroupPageState extends State<ScanQrToJoinGroupPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        print('the dataa id foutndddddddd ${scanData.format.name}');
        result = scanData;
        Navigator.pop(context, result);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(milliseconds: 100)).then((value){
      controller?.resumeCamera();
      setState(() {
      });
    });
    try{
      Future.delayed(Duration(seconds: 2)).then((value){
        controller?.resumeCamera();
        setState(() {
        });
      });
    }catch(e){
      print('Error in catch block $e');
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    controller?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Scan Qr Code'),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
