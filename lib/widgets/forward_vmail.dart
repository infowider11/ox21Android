import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customLoader.dart';

import '../constants/global_constants.dart';
import '../constants/sized_box.dart';
import '../services/api_urls.dart';
import '../services/webservices.dart';
import 'CustomTexts.dart';
import 'customtextfield.dart';
import 'fully_custom_dropdown.dart';
class ForwardVmailPage extends StatefulWidget {
  final Map replyData;
  final List myDomains;
  const ForwardVmailPage({Key? key, required this.replyData, required this.myDomains}) : super(key: key);

  @override
  _ForwardVmailPageState createState() => _ForwardVmailPageState();
}

class _ForwardVmailPageState extends State<ForwardVmailPage> {
  bool load = false;
  TextEditingController receiverDomainController = TextEditingController();
  String? errorDomainMessage;
  String? receiverDomainId;
  String? receiverUserId;
  Map? selectedDomain;
  String isReplied = '0';
  String isForwarded = '1';
  String parentId = '0';
  initializeData()async{
    if(widget.replyData!=null){
      isReplied = '1';
      parentId = widget.replyData['id'].toString();
      if(widget.replyData['sender_id'].toString()==userId){
        widget.myDomains.forEach((element) {
          if(element['id']==widget.replyData['sender_domain'][0]['id']){
            selectedDomain = element;
          }
        });
      }else{

        widget.myDomains.forEach((element) {
          if(element['id']==widget.replyData['receiver_domain'][0]['id']){
            selectedDomain = element;
          }
        });
      }
    }
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/2 + MediaQuery.of(context).viewInsets.bottom,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: load?CustomLoader():SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child:  MainHeadingText(text: 'Forward Vmail', color: MyColors.primaryColor,)),
              vSizedBox2,
              SubHeadingText(text: 'Select Your Domain'),
              vSizedBox05,
              CustomDropDown(
                onChanged: (val) {
                  selectedDomain = val;
                },
                hint: 'Select Domain',
                selectedItem: selectedDomain,
                items: List.generate(
                  widget.myDomains.length,
                      (index) => DropdownMenuItem(
                    value: widget.myDomains[index],
                    child: ParagraphText(
                      text: '${widget.myDomains[index]['domain']}',
                    ),
                  ),
                ),
              ),
              vSizedBox2,
              SubHeadingText(text: 'Forward to'),
              CustomTextField(
                controller: receiverDomainController,
                // errorText: errorDomainMessage,
                hintText: 'Enter receiver\'s Domain',
                onChanged: (val)async{
                  if(val.length!=0){
                    var request = {
                      'user_id': userId,
                      'domain': val
                    };
                    var jsonResponse = await Webservices.postData(url: ApiUrls.get_owner_by_domain, request: request,isGetMethod: true, context: context,showErrorMessage: false);
                    if(jsonResponse['status']==1){
                      errorDomainMessage = null;
                      receiverUserId = jsonResponse['data']['user_id'].toString();
                      receiverDomainId = jsonResponse['data']['domain_id'].toString();
                    }else{
                      errorDomainMessage = jsonResponse['message'];
                      receiverDomainId = null;
                      receiverUserId = null;
                    }

                  }else{
                    receiverDomainId = null;
                    receiverUserId = null;
                    errorDomainMessage = null;
                  }
                  setState(() {

                  });

                },
              ),
              if(errorDomainMessage!=null)
                ParagraphText(text: errorDomainMessage!, color: Colors.red,),

              vSizedBox4,
              RoundEdgedButton(text: 'Forward', onTap: ()async{
                setState(() {
                  load = true;
                });
                var request = {
                  'sender_id': userId,
                  'receiver_id': receiverUserId.toString(),
                  'sender_domain': selectedDomain!['id'].toString(),
                  'receiver_domain': receiverDomainId.toString(),
                  'subject': widget.replyData['subject'],
                  'body': widget.replyData['body'],
                };

                Map<String, List<File>> files = {
                  "images":[],
                  "videos":[]
                };


                print('the videos if ${files}');
                request['is_forwarded'] = isForwarded;
                request['is_replied'] = isReplied;
                request['parent_id'] = parentId;
                var jsonResponse = await Webservices.postDataWithFilesNodeJsFunction(apiUrl: ApiUrls.send_mail, body: request, context: context, nodeFiles: files, showSuccessMessage: true);
                if(jsonResponse['status']==1){
                  Navigator.pop(context);
                }
                setState(() {
                  load = false;
                });

              },),
            ],
          )
      ),
    );
  }
}
