import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/global_keys.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:ox21/widgets/customtextfield.dart';
import'package:flutter_translate/flutter_translate.dart';
class MakePaymentForBannerPage extends StatefulWidget {
  const MakePaymentForBannerPage({Key? key}) : super(key: key);

  @override
  _MakePaymentForBannerPageState createState() =>
      _MakePaymentForBannerPageState();
}

class _MakePaymentForBannerPageState extends State<MakePaymentForBannerPage> {
  TextEditingController orderIdController = TextEditingController();
  bool load =  false;

  String amountToPay = '0';

  String walletBalance = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title:translate("make_payment_for_banner_page.title")),
      body: load?CustomLoader():Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubHeadingText(
              text:translate("make_payment_for_banner_page.orderID"),
              color: MyColors.primaryColor,
            ),
            CustomTextField(
              controller: orderIdController,
              hintText:translate("make_payment_for_banner_page.orderIDPlace"),
              onChanged: (val)async{
                if(orderIdController.text.length==6){
                  var request = {
                    'user_id': userId,
                    "orderID": orderIdController.text
                  };
                  var jsonResponse = await Webservices.postData(url: ApiUrls.checkAmountForOrderId, request: request, context: context);
                  if(jsonResponse['status'] == 1){
                    amountToPay = jsonResponse['data']['price'].toString();
                    walletBalance = jsonResponse['data']['user_wallet'].toString();
                    print(jsonResponse['data']);

                  }else{
                    amountToPay = '0';

                  }
                  setState(() {

                  });
                }else{
                  amountToPay = '0';
                  setState(() {

                  });
                }
              },
              keyboardType: TextInputType.number,
            ),
            vSizedBox4,
            if(amountToPay!='0')
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ParagraphText(text:translate("make_payment_for_banner_page.pay")),
                SubHeadingText(text: '$amountToPay ${translate("make_payment_for_banner_page.btc")}', color: MyColors.primaryColor,),
              ],
            ),
            vSizedBox2,
            RoundEdgedButton(
              text: translate("make_payment_for_banner_page.makePay"),
              onTap: ()async{
                if(orderIdController.text==''){
                  showSnackbar(context, translate("make_payment_for_banner_page.enterOrderId"));
                }else if(orderIdController.text.length!=6){
                  showSnackbar(context, translate("make_payment_for_banner_page.validorderId"));
                }else{
                  var request = {
                    "user_id": userId,
                    "orderID": orderIdController.text
                  };
                  setState(() {
                    load = true;
                  });
                  var jsonResponse = await Webservices.postData(url: ApiUrls.payment_for_banner, request: request, context: context,);
                  if(jsonResponse['status'].toString()=='1'){
                    Navigator.pop(context);
                    showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, '${jsonResponse['message']}');
                  }else{
                    setState(() {
                      load = false;
                    });
                  }
                }

              },
            ),
          ],
        ),
      ),
    );
  }
}
