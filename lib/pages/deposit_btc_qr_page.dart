import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
import 'package:flutter_translate/flutter_translate.dart';
class DepositBTCQRPage extends StatefulWidget {
  final Map<String,dynamic> purchaseData;
  const DepositBTCQRPage({Key? key, required this.purchaseData}) : super(key: key);

  @override
  _DepositBTCQRPageState createState() => _DepositBTCQRPageState();
}

class _DepositBTCQRPageState extends State<DepositBTCQRPage> {
  String timeLeft = '';
  Timer? timer;


  int padding = 150;



  initializeTimer()async {

    int timestamp = widget.purchaseData['expire_time']*1000000;
    print('$timestamp uuuu');

    timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {

      timestamp = timestamp-1000;
      Duration duration = DateTime.fromMicrosecondsSinceEpoch(timestamp).difference(DateTime.now());
      timeLeft = '${duration.inDays} ${translate("deposit_btc_qr_page.day")}, ${duration.inHours - duration.inDays*24} ${translate("deposit_btc_qr_page.hours")}, ${duration.inMinutes - duration.inHours*60} ${translate("deposit_btc_qr_page.minutes")}, ${duration.inSeconds - duration.inMinutes*60} ${translate("deposit_btc_qr_page.seconds")}';

      setState(() {

      });
      if(duration.inSeconds<=0){
        showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, translate("deposit_btc_qr_page.purchaseOut"));
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
    print('the qr data is : bitcoin:11PEEokWFSFNYshLfuLvZfMuPE93aMJd4?amount=${double.parse(widget.purchaseData['btc_amount'].toString()).toStringAsFixed(2)}${widget.purchaseData['orderID']}}');
    return Scaffold(
      appBar: appBar(context: context, title: translate("deposit_btc_qr_page.scanPay")),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16.0),
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment:  CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset(MyImages.logo_hori, width: MediaQuery.of(context).size.width,)),
              vSizedBox,
              SubHeadingText(text: translate("deposit_btc_qr_page.orderCreated"),),
              vSizedBox,
              ParagraphText(text: ' ${translate("deposit_btc_qr_page.orderId")} ${widget.purchaseData['orderID']}', fontSize: 16,),
              vSizedBox05,
              ParagraphText(text: '  ${translate("deposit_btc_qr_page.cost")} ${double.parse(widget.purchaseData['btc_amount'].toString()).toStringAsFixed(2)}  ${translate("deposit_btc_qr_page.btc")}', fontSize: 16,),
              vSizedBox2,
              SubHeadingText(text: '${translate("deposit_btc_qr_page.Qrpay")}',),
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
                        data: 'bitcoin:11PEEokWFSFNYshLfuLvZfMuPE93aMJd4?amount=${double.parse(widget.purchaseData['btc_amount'].toString()).toStringAsFixed(2)}${widget.purchaseData['orderID']}',
                        version:  QrVersions.auto,
                        size: 300,
                        embeddedImage: AssetImage(MyImages.bitcoinLogo),

                      ),
                    ),
                  ],
                ),
              ),
              vSizedBox,
              Center(child: ParagraphText(text: '${translate("deposit_btc_qr_page.text3")} ${DateFormat.yMMMMEEEEd().add_jm().format(DateTime.fromMillisecondsSinceEpoch((widget.purchaseData['expire_time'] * 1000)??'${DateTime.now().toString()}'))}', textAlign: TextAlign.center,)),
              vSizedBox,
              SubHeadingText(text: translate("deposit_btc_qr_page.strongNote")),
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
                  ParagraphText(text:translate("deposit_btc_qr_page.text4")),
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
                  Expanded(child: ParagraphText(text: translate("deposit_btc_qr_page.text5"))),
                ],
              ),
              vSizedBox4,
              RoundEdgedButton(text: translate("deposit_btc_qr_page.close"), onTap: (){
                Navigator.pop(context);
              },),

              // ParagraphText(text: timeLeft),

            ],
          ),
        ),
      ),
    );
  }
}
