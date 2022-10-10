import 'package:flutter/material.dart';
import 'package:ox21/cart.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/functions/navigation_functions.dart';
import 'package:ox21/pages/add_to_cart.dart';
import 'package:ox21/pages/my_purchased_domains.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:ox21/widgets/customtextfield.dart';

import '../constants/global_functions.dart';

class DomainPurchaseSuccessfulPage extends StatefulWidget {
  static const String id = 'domain_purchase_successfull_page';
  final Map<String, dynamic> domainData;
  const DomainPurchaseSuccessfulPage({Key? key, required this.domainData})
      : super(key: key);

  @override
  _DomainPurchaseSuccessfulPageState createState() => _DomainPurchaseSuccessfulPageState();
}

class _DomainPurchaseSuccessfulPageState extends State<DomainPurchaseSuccessfulPage> {
  TextEditingController searchController = TextEditingController();
  bool load = false;
  getBitcoinValue() {}

  int coins = 0;
  double totalCostInPoints = 0;
  getInitialData() async {
    totalCostInPoints = (widget.domainData['usdCost'] * 3600 / (15));
    setState(() {
      load = true;
    });
    coins = (await updateSharedPreferenceFromServer())['points'];
    print('khdfklshndfklj $coins');
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    print('hello world');
    getInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Domain'),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vSizedBox4,
            vSizedBox8,
            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            //   child: CustomTextFieldlabel(
            //     labeltext: 'Search Domain',
            //     controller: searchController,
            //     hintText: 'labeltext',
            //     left: 16,
            //     fontsize: 12,
            //     hintcolor: MyColors.inputbordercolor,
            //     suffixIcon: MyImages.voicesearch,
            //     bgColor: Color(0xFFF2F2F2),
            //     border: Border.all(color: MyColors.strokelabel),
            //     icon: Icons.search,
            //     borderRadius: 16,
            //     paddingsuffix: 14,
            //   ),
            // ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SubHeadingText(
                    text: 'Domain Name: ${widget.domainData['domain']}',
                  ),
                  vSizedBox,
                  Image.asset(
                    MyImages.tickIcon,
                    height: 60,
                    fit: BoxFit.fitHeight,
                  ),
                  vSizedBox,
                  ParagraphText(text: 'Domain Purchased Successfully'),
                  vSizedBox2,
                  RoundEdgedButton(
                    text: 'Check Your Purchased Domains',
                    textColor: Colors.white,
                    color: MyColors.secondary,
                    fontfamily: 'medium',
                    onTap: (){
                      push(context: context, screen: MyPurchasedDomains());
                    },
                  ),
                  vSizedBox2,
                  RoundEdgedButton(
                    text: 'Go to Home Page',
                    isSolid: false,
                    textColor: Colors.white,
                    color: MyColors.secondary,
                    fontfamily: 'medium',
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
