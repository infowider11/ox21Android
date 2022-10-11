import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/global_functions.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/widgets/buttons.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/custom_circular_image.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:ox21/widgets/customtextfield.dart';
import 'package:ox21/widgets/fully_custom_dropdown.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'CustomTexts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_translate/flutter_translate.dart';
class SendVmailBottomSheet extends StatefulWidget {
  final List myDomains;
  final Map? replyData;
  const SendVmailBottomSheet({Key? key, required this.myDomains, this.replyData})
      : super(key: key);

  @override
  State<SendVmailBottomSheet> createState() => _SendVmailBottomSheetState();
}

class _SendVmailBottomSheetState extends State<SendVmailBottomSheet> {
  TextEditingController receiverDomainController = TextEditingController();
  Map? selectedDomain;
  TextEditingController subjectController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  List<File> images = [];
  List<File> videos = [];
  String? errorDomainMessage;
  String? receiverDomainId;
  String? receiverUserId;
  bool load = false;
  String isReplied = '0';
  String isForwarded = '0';
  String parentId = '0';



  initializeData()async{
    if(widget.replyData!=null){
      isReplied = '1';
      parentId = widget.replyData!['id'].toString();
      subjectController.text = widget.replyData!['subject'];
      if(widget.replyData!['sender_id'].toString()==userId){
        receiverDomainController.text = widget.replyData!['receiver_domain'][0]['domain'];
        receiverUserId = widget.replyData!['receiver_id'].toString();
        receiverDomainId = widget.replyData!['receiver_domain'][0]['id'].toString();

        widget.myDomains.forEach((element) {
          if(element['id']==widget.replyData!['sender_domain'][0]['id']){
            selectedDomain = element;
          }
        });
      }else{
        receiverUserId = widget.replyData!['sender_id'].toString();
        receiverDomainId = widget.replyData!['sender_domain'][0]['id'].toString();
        receiverDomainController.text = widget.replyData!['sender_domain'][0]['domain'];
        widget.myDomains.forEach((element) {
          if(element['id']==widget.replyData!['receiver_domain'][0]['id']){
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
    print(widget.myDomains);
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.of(context).size.height-100 + MediaQuery.of(context).viewInsets.bottom,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: load?CustomLoader():SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: MainHeadingText(text:translate("send_vmail.title"))),
              vSizedBox2,
              SubHeadingText(text:translate("send_vmail.selectDomain")),
              vSizedBox05,
              CustomDropDown(
                onChanged: (val) {
                  selectedDomain = val;
                },
                hint: translate("send_vmail.selectDomain"),
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
              SubHeadingText(text:translate("send_vmail.enterDomain")),
              CustomTextField(
                  controller: receiverDomainController,
                  // errorText: errorDomainMessage,
                  hintText:translate("send_vmail.enterDomain"),
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

              vSizedBox2,
              SubHeadingText(text:translate("send_vmail.subject")),
              vSizedBox05,
              CustomTextField(controller: subjectController, hintText: translate("send_vmail.enterSubject")),
              vSizedBox2,
              SubHeadingText(text:translate("send_vmail.body")),
              vSizedBox05,
              CustomTextField(controller: bodyController, hintText:translate("send_vmail.enterSomthing"), maxLines: 6,),
              vSizedBox2,
              SubHeadingText(text:translate("send_vmail.addImg")),
              vSizedBox,
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      images = await pickMultipleImages();
                      setState(() {});
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 124,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                                child: CustomCircularImage(
                                  imageUrl: '',
                                  fileType: CustomFileType.file,
                                  image: images[index],
                                  height: 100,
                                  width: 100,
                                  borderRadius: 18,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 4,
                                child: GestureDetector(
                                  onTap: (){
                                    images.removeAt(index);
                                    setState(() {

                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: Colors.red
                                    ),
                                    child: Icon(Icons.close, color: Colors.white,),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
              vSizedBox2,
              SubHeadingText(
                  text:translate("send_vmail.addVideos"),
                      ),
              vSizedBox,
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      File? temp = await pickVideo();
                      if(temp!=null){
                        videos.add(temp);
                      }
                      setState(() {});
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 124,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: videos.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                                child: CustomCircularImage(
                                  imageUrl: MyImages.upload_video,
                                  fit: BoxFit.fill,
                                  fileType: CustomFileType.asset,
                                  image: videos[index],
                                  height: 100,
                                  width: 100,
                                  borderRadius: 18,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 4,
                                child: GestureDetector(
                                  onTap: (){
                                    images.removeAt(index);
                                    setState(() {

                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: Colors.red
                                    ),
                                    child: Icon(Icons.close, color: Colors.white,),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
              vSizedBox2,
              RoundEdgedButton(text: widget.replyData==null?'Send Mail':'Reply', onTap: ()async{
                if(selectedDomain==null){
                  showSnackbar(context, translate("send_vmail.enterSelectDomain"));
                }else if(errorDomainMessage!=null || receiverDomainId==null){
                  showSnackbar(context, translate("send_vmail.validType"));
                }else{
                  setState(() {
                    load = true;
                  });
                  var request = {
                    'sender_id': userId,
                    'receiver_id': receiverUserId.toString(),
                    'sender_domain': selectedDomain!['id'].toString(),
                    'receiver_domain': receiverDomainId.toString(),
                    'subject': subjectController.text,
                    'body': bodyController.text,
                  };

                  Map<String, List<File>> files = {
                    "images":[],
                    "videos":[]
                  };
                  if(images.length!=0){
                    files['images'] = images;
                    // for(int i = 0;i<images.length;i++){
                    //
                    //   // files['images[$i]'] = images[i];
                    // }
                  }
                  print('the videos are ${videos.length}');


                  if(videos.length!=0){
                    print('the videos are ${videos.length}');
                    List<File> thumbnails = [];
                    files['videos']=videos;

                    print('kkk $videos');
                    print('the files are $files');


                    for(int x=0;x<videos.length;x++){
                      Uint8List? uint8list = await VideoThumbnail.thumbnailData(
                        video: videos[x].path,
                        imageFormat: ImageFormat.JPEG,
                        maxWidth: 400, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
                        maxHeight: 400,
                        quality: 50,
                      );
                      final tempDir = await getTemporaryDirectory();

                      File thumbnail = await File('${tempDir.path}/image.png').create();
                      thumbnail.writeAsBytesSync(uint8list!.toList());
                      thumbnails.add(thumbnail);
                    }
                    files['thumbnails'] = thumbnails;
                  }

                  print('the videos if ${files}');
                  request['is_forwarded'] = isForwarded;
                  request['is_replied'] = isReplied;
                  request['parent_id'] = parentId;
                  var jsonResponse = await Webservices.postDataWithFilesNodeJsFunction(apiUrl: ApiUrls.send_mail, body: request, context: context, nodeFiles: files, showSuccessMessage: true);
                  if(jsonResponse['status']==1){
                    Navigator.pop(context, true);
                  }
                  setState(() {
                    load = false;
                  });


                }
              },)
            ],
          ),
        ),
      ),
    );
  }
}
