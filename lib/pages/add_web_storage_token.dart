import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/global_functions.dart';
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

class AddWebStorageTokenPage extends StatefulWidget {
  const AddWebStorageTokenPage({Key? key}) : super(key: key);

  @override
  _AddWebStorageTokenPageState createState() =>
      _AddWebStorageTokenPageState();
}

class _AddWebStorageTokenPageState extends State<AddWebStorageTokenPage> {
  TextEditingController orderIdController = TextEditingController();
  bool load =  false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Add Web Storage Token'),
      body: load?CustomLoader():Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubHeadingText(
              text: 'Token',
              color: MyColors.primaryColor,
            ),
            CustomTextField(
              controller: orderIdController,
              hintText: 'Enter your token here...',
              maxLines: 4,
              // keyboardType: TextInputType.number,
            ),
            vSizedBox4,

            vSizedBox2,
            RoundEdgedButton(
              text: 'Add Token',
              onTap: ()async{
                if(orderIdController.text==''){
                  showSnackbar(context, 'Please Enter the token');
                }
                // else if(orderIdController.text.length!=6){
                //   showSnackbar(context, 'Order Id must be of exactly 6 digits');
                // }
                else{
                  var request = {
                    "user_id": userId,
                    "token": orderIdController.text,
                  };
                  setState(() {
                    load = true;
                  });
                  var jsonResponse = await Webservices.postData(url: ApiUrls.uploadWebToken, request: request, context: context,);
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
