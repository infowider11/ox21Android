import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/custom_circular_image.dart';

import '../../constants/global_constants.dart';
import '../../services/api_urls.dart';
import '../../services/webservices.dart';
import '../../widgets/customLoader.dart';
import 'package:flutter_translate/flutter_translate.dart';

class PendingGroupMembers extends StatefulWidget {
  final Map groupDetail;
  const PendingGroupMembers({Key? key, required this.groupDetail}) : super(key: key);

  @override
  State<PendingGroupMembers> createState() => _PendingGroupMembersState();
}

class _PendingGroupMembersState extends State<PendingGroupMembers> {
  bool load = false;
  List pendingMembers = [];
  Timer? timer;
  getMembers({bool showLoad = false})async{
    if(showLoad){
      setState(() {
        load = true;
      });
    }
    var request = {
      'id':widget.groupDetail['id'].toString(),
      'is_member': '1',
      'user_id': userId,
    };

    pendingMembers = (await Webservices.postData(url: ApiUrls.getGroupDetail, request: request, context: context, isGetMethod: true))['data']['pendingMember']??[];
    if(showLoad){
      load = false;
    }
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getMembers(showLoad: true);

    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      getMembers();
    });
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title:translate("group_members_page.members")),
      body:load?CustomLoader(): Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: pendingMembers.length==0?Center(child: ParagraphText(text: translate("pending_group_members_page.noPendingRequest"),),):ListView.builder(
          itemCount: pendingMembers.length,
          itemBuilder: (context, index){
            return Container(
              // height: 60,
              child: Column(
                children: [
                  vSizedBox05,
                  Row(
                    children: [
                      // CustomCircularImage(imageUrl: members[index]['image']),
                      // hSizedBox,
                      Expanded(child: SubHeadingText(text: pendingMembers[index]['nickname'],),),
                      hSizedBox2,
                     IconButton(onPressed: ()async{

                       setState(() {
                         load = true;
                       });
                       var request = {
                         'group_id':widget.groupDetail['id'].toString(),
                         'user_id':userId,
                         'status':'2',
                         'member_id':pendingMembers[index]['id'].toString(),

                       };
                       var jsonResponse = await Webservices.postData(url: ApiUrls.acceptRejectGroupMemberRequest, request: request, context: context, isGetMethod: true, showSuccessMessage: true);
                       getMembers(showLoad: true);
                     }, icon: Icon(Icons.highlight_remove, color: Colors.red, size: 36,),),
                      IconButton(onPressed: ()async{

                        setState(() {
                          load = true;
                        });
                        var request = {
                          'group_id':widget.groupDetail['id'].toString(),
                        'user_id':userId,
                        'status':'1',
                          'member_id':pendingMembers[index]['id'].toString(),

                        };
                        var jsonResponse = await Webservices.postData(url: ApiUrls.acceptRejectGroupMemberRequest, request: request, context: context, isGetMethod: true, showSuccessMessage: true);
                        getMembers(showLoad: true);
                      }, icon: Icon(Icons.check_circle_outline, color: Colors.green, size: 36,),),
                    ],
                  ),
                  CustomDivider(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
