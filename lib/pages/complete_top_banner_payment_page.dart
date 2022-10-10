import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ox21/constants/global_keys.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/functions/navigation_functions.dart';
import 'package:ox21/tab.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CompleteTopBannerPaymentPage extends StatefulWidget {
  final Map<String,dynamic> purchaseData;
  const CompleteTopBannerPaymentPage({Key? key, required this.purchaseData}) : super(key: key);

  @override
  _CompleteTopBannerPaymentPageState createState() => _CompleteTopBannerPaymentPageState();
}

class _CompleteTopBannerPaymentPageState extends State<CompleteTopBannerPaymentPage> {
  String timeLeft = '';
  Timer? timer;


  int padding = 150;



  initializeTimer()async {

    int timestamp = widget.purchaseData['expire_time']*1000000;
    print('$timestamp uuuu');

    timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {

      timestamp = timestamp-1000;
      Duration duration = DateTime.fromMicrosecondsSinceEpoch(timestamp).difference(DateTime.now());
      timeLeft = '${duration.inDays} day, ${duration.inHours - duration.inDays*24} hours, ${duration.inMinutes - duration.inHours*60} minutes, ${duration.inSeconds - duration.inMinutes*60} seconds left';

      setState(() {

      });
      if(duration.inSeconds<=0){
        showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, 'Purchase timeout.');
        pushReplacement(context: MyGlobalKeys.navigatorKey.currentContext!, screen: MyStatefulWidget());
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    initializeTimer();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('the qr data is : bitcoin:11PEEokWFSFNYshLfuLvZfMuPE93aMJd4?amount=${double.parse(widget.purchaseData['price'].toString()).toStringAsFixed(2)}${widget.purchaseData['orderID']}}');
    return Scaffold(
      appBar: appBar(context: context, title: 'Rent Top Banner'),

      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16.0),
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment:  CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset(MyImages.buyTopBannerImage, width: MediaQuery.of(context).size.width,)),
              vSizedBox,
              SubHeadingText(text: 'This banner is for rent.',),
              vSizedBox,
              ParagraphText(text: '  ORDER ID: ${widget.purchaseData['orderID']}', fontSize: 16,),
              vSizedBox05,
              ParagraphText(text: '  COST: ${double.parse(widget.purchaseData['price'].toString()).toStringAsFixed(2)}  BTC', fontSize: 16,),
              vSizedBox2,
              SubHeadingText(text: 'QR code use for payment',),
              vSizedBox4,
              Center(
                child: Stack(
                  children: [
                    Image.asset(MyImages.qrBorder, width: MediaQuery.of(context).size.width-padding,height: MediaQuery.of(context).size.width-padding,),
                    Positioned(
                      left: padding/7,
                      right: padding/7,
                      top: padding/7,
                      bottom: padding/7,
                      child: QrImage(
                        data: 'bitcoin:11PEEokWFSFNYshLfuLvZfMuPE93aMJd4?amount=${double.parse(widget.purchaseData['price'].toString()).toStringAsFixed(2)}${widget.purchaseData['orderID']}',
                        version:  QrVersions.auto,
                        size: 300,
                        embeddedImage: AssetImage(MyImages.bitcoinLogo),

                      ),
                    ),
                  ],
                ),
              ),
              vSizedBox,
              Center(child: ParagraphText(text: 'Updated on ${DateTime.parse(widget.purchaseData['updated_at']??'${DateTime.now().toString()}').toString()}', textAlign: TextAlign.center,)),
              vSizedBox,
              SubHeadingText(text: 'Strong Note'),
              vSizedBox,
              Row(
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: new BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),),
                  hSizedBox,
                  ParagraphText(text: 'the order id will expire in 48 hours'),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: new BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),),
                  hSizedBox,
                  Expanded(child: ParagraphText(text: 'When the orderID expires, the message will show the QR code is no longer valid.')),
                ],
              ),
              vSizedBox4,
              RoundEdgedButton(text: 'Close', onTap: (){
                // Navigator.pop(context);
                Navigator.pop(MyGlobalKeys.navigatorKey.currentContext!);
              },),

              // ParagraphText(text: timeLeft),
              
            ],
          ),
        ),
      ),
    );
  }
}
