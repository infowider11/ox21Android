import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/global_functions.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:ox21/widgets/customtextfield.dart';
import'package:flutter_translate/flutter_translate.dart';
class CreatePrivateChannel extends StatefulWidget {
  const CreatePrivateChannel({Key? key}) : super(key: key);

  @override
  _CreatePrivateChannelState createState() => _CreatePrivateChannelState();
}

class _CreatePrivateChannelState extends State<CreatePrivateChannel> {
  TextEditingController channelNameController = TextEditingController();
  File? thumbnail;
  bool load = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:load?null: appBar(context: context, title: translate("create_private_channel.createPrivate")),
      body:load?CustomLoader(): Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vSizedBox2,
                SubHeadingText(
                  text: translate("create_private_channel.cName"),
                  color: MyColors.primaryColor,
                ),
                vSizedBox05,
                CustomTextField(
                  controller: channelNameController,
                  hintText: translate("create_private_channel.cNmaePlace"),
                ),
                vSizedBox2,
                SubHeadingText(
                  text: translate("create_private_channel.cThumbnail"),
                  color: MyColors.primaryColor,
                ),
                vSizedBox05,
                InkWell(
                  onTap: () async {
                    File? tempFile = await pickImage(isGallery: true);
                    if (tempFile != null) {
                      thumbnail = tempFile;
                    }
                    setState(() {});
                  },
                  child: thumbnail != null
                      ? Image.file(
                          thumbnail!,
                          height: 200,
                          fit: BoxFit.fitHeight,
                        )
                      : Image.asset(MyImages.addImageIcon),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: RoundEdgedButton(
                text: translate("create_private_channel.createChannel"),
                verticalMargin: 20,
                onTap: ()async{
                  if(channelNameController.text==''){
                    showSnackbar(context, translate("create_private_channel.alertCNmae"));
                  }else if(thumbnail==null){
                    showSnackbar(context, translate("create_private_channel.alertCThumbnail"));
                  }else{
                    setState(() {
                      load = true;
                    });
                    var request = {
                      'name': channelNameController.text,
                      'user_id': userId,
                    };
                    var files = {
                      'image': thumbnail!
                    };
                    var jsonResponse = await Webservices.postDataWithImageFunction(body: request, files: files, context: context, endPoint: ApiUrls.create_channels);
                    if(jsonResponse['status']==1){
                      showSnackbar(context, '${jsonResponse['message']}');
                      Navigator.pop(context, channelNameController.text);
                    }
                    else{
                      setState(() {
                        load = false;
                      });
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
