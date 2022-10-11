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
import 'package:flutter_translate/flutter_translate.dart';
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
      appBar: appBar(context: context, title:translate("add_web_storage_token.title")),
      body: load?CustomLoader():Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubHeadingText(
              text: translate("add_web_storage_token.token"),
              color: MyColors.primaryColor,
            ),
            CustomTextField(
              controller: orderIdController,
              hintText: translate("add_web_storage_token.tokenPlace"),
              maxLines: 4,
              // keyboardType: TextInputType.number,
            ),
            vSizedBox4,

            vSizedBox2,
            RoundEdgedButton(
              text: translate("add_web_storage_token.addToken"),
              onTap: ()async{
                if(orderIdController.text==''){
                  showSnackbar(context, translate("add_web_storage_token.alert"));
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
