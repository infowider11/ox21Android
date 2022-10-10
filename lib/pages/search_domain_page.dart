import 'package:flutter/material.dart';
import 'package:ox21/cart.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/functions/navigation_functions.dart';
import 'package:ox21/pages/add_to_cart.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:ox21/widgets/customtextfield.dart';

import '../constants/global_functions.dart';

class SearchDomainPage extends StatefulWidget {
  static const String id = 'search_domain_page';
  final Map<String, dynamic> domainData;
  const SearchDomainPage({Key? key, required this.domainData})
      : super(key: key);

  @override
  _SearchDomainPageState createState() => _SearchDomainPageState();
}

class _SearchDomainPageState extends State<SearchDomainPage> {
  TextEditingController searchController = TextEditingController();
  bool load = false;
  getBitcoinValue() {}

  int coins = 0;
  double totalCost = 0;
  getInitialData() async {
    totalCost = (widget.domainData['usdCost'] * 3600 / (15));
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
                  ParagraphText(text: 'Name Available to Purchase'),
                  vSizedBox2,
                  RoundEdgedButton(
                    text: 'Purchase for ${totalCost.toStringAsFixed(0)} OX21 Coin',
                    textColor: Colors.white,
                    color: MyColors.secondary,
                    fontfamily: 'medium',
                    onTap: () {
                      if(totalCost>coins){
                        showSnackbar(context, 'You don\'t have sufficient coins to purchase this banner.');
                      }
                      else{
                        push(
                            context: context,
                            screen: Cart(
                              totalCost: totalCost,
                              domainData: widget.domainData,
                              purchaseCurrency: PurchaseCurrency.coins,
                              // coins: coins,
                              // totalCost: totalCost,
                            ));
                      }

                      // Navigator.pushNamed(context, Addtocart.id);
                    },
                  ),
                  vSizedBox2,
                  // RoundEdgedButton(
                  //   text: 'Purchase with BTC',
                  //   isSolid: false,
                  //   textColor: Colors.white,
                  //   color: MyColors.secondary,
                  //   fontfamily: 'medium',
                  //   onTap: (){
                  //     showSnackbar(context, 'Coming Soon');
                  //   },
                  // )
                  RoundEdgedButton(
                    text: 'Purchase with BTC',
                    textColor: Colors.white,
                    isSolid: false,
                    color: MyColors.secondary,
                    fontfamily: 'medium',
                    onTap: () {
                      push(
                          context: context,
                          screen: Cart(
                            totalCost: totalCost,
                            domainData: widget.domainData,
                            purchaseCurrency: PurchaseCurrency.btc,
                            // coins: coins,
                            // totalCost: totalCost,
                          ));

                      // Navigator.pushNamed(context, Addtocart.id);
                    },
                  ),

                  // RoundEdgedButton(
                  //   text: 'Purchase with USD',
                  //   isSolid: false,
                  //   textColor: Colors.white,
                  //   color: MyColors.secondary,
                  //   fontfamily: 'medium',
                  //   onTap: (){
                  //     push(
                  //         context: context,
                  //         screen: Cart(
                  //           totalCost: totalCost,
                  //           domainData: widget.domainData,
                  //           purchaseCurrency: PurchaseCurrency.usd,
                  //           // coins: coins,
                  //           // totalCost: totalCost,
                  //         ));
                  //     // showSnackbar(context, 'Coming Soon');
                  //   },
                  // ),
                  vSizedBox2,
                  RoundEdgedButton(
                    text: 'Purchase with JIN',
                    textColor: Colors.white,
                    color: MyColors.secondary,
                    fontfamily: 'medium',
                    onTap: () {
                        push(
                            context: context,
                            screen: Cart(
                              totalCost: totalCost,
                              domainData: widget.domainData,
                              purchaseCurrency: PurchaseCurrency.jin,
                              // coins: coins,
                              // totalCost: totalCost,
                            ));

                      // Navigator.pushNamed(context, Addtocart.id);
                    },
                  ),
                  vSizedBox2,

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
