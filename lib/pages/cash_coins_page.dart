import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customtextfield.dart';

class CashCoinsPage extends StatefulWidget {
  final int coins;
  const CashCoinsPage({Key? key, required this.coins}) : super(key: key);


  @override
  _CashCoinsPageState createState() => _CashCoinsPageState();
}

class _CashCoinsPageState extends State<CashCoinsPage> {
  TextEditingController coinsController = TextEditingController();

  String? errorTextCoinsController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Cash Coins'),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vSizedBox4,
            SubHeadingText(
              text: 'Enter Coins',
              color: MyColors.primaryColor,
            ),
            CustomTextField(
              controller: coinsController,
              hintText: 'Enter coins',
              keyboardType: TextInputType.number,
              errorText: errorTextCoinsController,
              onChanged: (val){
                print('the val is $val & ${widget.coins}');
                try{
                  if (int.parse(val) > widget.coins) {
                    errorTextCoinsController = 'Insufficient coins';
                  } else {
                    errorTextCoinsController = null;
                  }
                }catch(e){
                  print('Inside catch block 232 $e');

                  //
                }
                setState(() {

                });
              },
            ),
            vSizedBox2,
            RoundEdgedButton(text: 'Convert Coins to BTC'),
            vSizedBox,
            RoundEdgedButton(text: 'Convert All Coins to BTC'),
          ],
        ),
      ),
    );
  }
}
