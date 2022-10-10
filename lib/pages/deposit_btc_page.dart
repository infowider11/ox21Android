import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/functions/navigation_functions.dart';
import 'package:ox21/pages/qr_code_page.dart';
import 'package:ox21/pages/search_domain_page.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:ox21/widgets/customtextfield.dart';

import 'deposit_btc_qr_page.dart';

class DepositBtcPage extends StatefulWidget {
  static const String id = 'btc_send_page';
  const DepositBtcPage({Key? key}) : super(key: key);

  @override
  _DepositBtcPageState createState() => _DepositBtcPageState();
}

class _DepositBtcPageState extends State<DepositBtcPage> {
  bool load = false;

  // TextEditingController receivingAddressController = TextEditingController();
  TextEditingController transferAmountController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          context: context,
          title: 'Deposit BTC',

      ),
      body:load?CustomLoader(): Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  vSizedBox2,
                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   padding:
                  //   EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  //   decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(16)),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       SubHeadingText(
                  //         text: 'Sender Address',
                  //         color: Colors.grey,
                  //       ),
                  //       vSizedBox,
                  //       ParagraphText(
                  //         text: '11PEEokWFSFNYshLfuLvZfMuPE93aMJd4',
                  //         color: MyColors.black54Color,
                  //       )
                  //     ],
                  //   ),
                  // ),
                  vSizedBox,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     SubHeadingText(text: 'Receiving Address'),
                  //   ],
                  // ),
                  // vSizedBox2,
                  // CustomTextField(controller: receivingAddressController, hintText: 'Enter your wallet address..'),
                  // vSizedBox,
                  // CustomDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubHeadingText(text: 'Transfer Amount'),
                      Row(
                        children: [
                          Image.asset(
                            MyImages.bitcoinLogo,
                            height: 20,
                            fit: BoxFit.fitHeight,
                          ),
                          SubHeadingText(text: 'BTC')
                        ],
                      )
                    ],
                  ),
                  vSizedBox,
                  CustomTextField(controller: transferAmountController, hintText: 'Enter Amount', keyboardType: TextInputType.number,),

                  vSizedBox2,
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey.shade200,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    vSizedBox2,
                    
                    Row(
                      children: [
                        Expanded(
                            child: RoundEdgedButton(
                              text: 'Confirm',
                              color: MyColors.secondary,
                              // color: Colors.grey.shade300,
                              // textColor: Colors.grey,
                              textColor: Colors.white,
                              onTap: ()async{
                               if(transferAmountController.text==''){
                                 showSnackbar(context, 'Please type a amount to continue');
                               }else{
                                 setState(() {
                                   load = true;
                                 });
                                 var request = {
                                   'user_id': userId,
                                   'btc_amount': transferAmountController.text,
                                 };
                                 var jsonResponse = await Webservices.postData(url: ApiUrls.depositBTC, request: request, context: context);
                                 // {status: 1, message: success, data: {user_id: 252, btc_amount: 50509482, orderID: 509482, expire_time: 1654492962}}
                                 pushReplacement(context: context, screen: DepositBTCQRPage(purchaseData: jsonResponse['data'],));
                                 //:TODO: yaha se age karna he
                                 setState(() {
                                   load = false;
                                 });
                               }
                                // Navigator.pushNamed(context, SearchDomainPage.id);
                              },
                            )),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
