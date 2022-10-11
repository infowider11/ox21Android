import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/custom_circular_image.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:ox21/widgets/customtextfield.dart';

import '../../constants/global_functions.dart';
import 'package:flutter_translate/flutter_translate.dart';
class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({Key? key}) : super(key: key);

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  bool load = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionCOntroller = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  File? image;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title:translate("create_group_page.createGroup")),
      body:load?CustomLoader(): Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vSizedBox2,
              SubHeadingText(text: translate("create_group_page.groupTitle"), color: MyColors.primaryColor,),
              vSizedBox05,
              CustomTextField(controller: titleController, hintText: translate("create_group_page.groupName")),
              vSizedBox2,
              SubHeadingText(text:  translate("create_group_page.groupDes"), color: MyColors.primaryColor,),
              vSizedBox05,
              CustomTextField(controller: descriptionCOntroller, hintText: translate("create_group_page.typeSome"), maxLines: 6,),
              vSizedBox2,
              SubHeadingText(text: translate("create_group_page.nName"), color: MyColors.primaryColor,),
              vSizedBox05,
              CustomTextField(controller: nickNameController, hintText: translate("create_group_page.groupName")),
              vSizedBox2,
              SubHeadingText(text: translate("create_group_page.groupImage"), color: MyColors.primaryColor,),
              vSizedBox05,

              GestureDetector(
                onTap: ()async{
                  File? temp = await pickImage(isGallery: true);
                  if(temp!=null){
                    image = temp;
                  }
                  setState(() {
                    
                  });
                },
                child:image==null? Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: MyColors.primaryColor)
                  ),
                  child: Icon(Icons.add, color: MyColors.primaryColor,size: 50,),
                ):CustomCircularImage(imageUrl: '', fileType: CustomFileType.file,image: image, height: 100,width: 100,borderRadius: 20,),
              ),
              vSizedBox4,
              RoundEdgedButton(
                text: translate("create_group_page.createGroup"),
                onTap: ()async{
                  if(titleController.text==''){
                    showSnackbar(context, translate("create_group_page.alertGTitle"));
                  }else if(descriptionCOntroller.text==''){
                    showSnackbar(context, translate("create_group_page.alertGDes"));
                  }else if(nickNameController.text==''){
                    showSnackbar(context, translate("create_group_page.alertGName"));
                  }else if(image==null){
                    showSnackbar(context, translate("create_group_page.alertGImage"));
                  }else{
                    setState(() {
                      load = true;
                    });
                    var request = {
                      'user_id': userId,
                      'title': titleController.text,
                      'description': descriptionCOntroller.text,
                      'nickname': nickNameController.text,
                    };
                    var files = {
                      'image': image!
                    };
                    var jsonResponse = await Webservices.postDataWithImageFunction(body: request, files: files, context: context, endPoint: ApiUrls.createGroup);
                    if(jsonResponse['status']==1){
                      showSnackbar(context, jsonResponse['message']);
                      Navigator.pop(context, true);
                    }else{
                      setState(() {
                        load = false;
                      });
                    }
                  }
                },
              )


            ],
          ),
        ),
      ),
    );
  }
}
