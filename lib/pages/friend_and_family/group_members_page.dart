import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/confirmation_dialog.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/custom_circular_image.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:ox21/widgets/customtextfield.dart';

import '../../constants/colors.dart';
import '../../constants/global_constants.dart';
import '../../constants/global_keys.dart';
import '../../services/api_urls.dart';
import '../../services/webservices.dart';
import '../../widgets/buttons.dart';

class GroupMembersPage extends StatefulWidget {
  final Map groupDetail;
  const GroupMembersPage({Key? key, required this.groupDetail}) : super(key: key);

  @override
  State<GroupMembersPage> createState() => _GroupMembersPageState();
}

class _GroupMembersPageState extends State<GroupMembersPage> {
  bool load = false;
  List members = [];
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

    members = (await Webservices.postData(url: ApiUrls.getGroupDetail, request: request, context: context, isGetMethod: true))['data']['members']??[];
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
      appBar: appBar(context: context, title: 'Members'),
      body:load?CustomLoader(): Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child:members.length==0?Center(child: ParagraphText(text: 'No Members Found',),): ListView.builder(
          itemCount: members.length,
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
                      Expanded(child: Row(
                        children: [
                          SubHeadingText(text: '${members[index]['nickname']} ',),
                          if(members[index]['is_owner']==1)
                            SubHeadingText(text: '(Admin)',),
                          if(members[index]['user_id'].toString()==userId)
                            SubHeadingText(text: '(You)',),

                        ],
                      ),),
                      hSizedBox2,
                      if(widget.groupDetail['owner_id'].toString()==userId)
                      IconButton(onPressed: ()async{
                        String? nickname = await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            TextEditingController nicknameController = TextEditingController();
                            nicknameController.text = members[index]['nickname']??'';
                            return Container(
                              // margin: viewInset,
                              height: 260 + MediaQuery.of(context).viewInsets.bottom,
                              padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              decoration: BoxDecoration(
                                  color: MyColors.whiteColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                  )),
                              child: Scaffold(
                                body: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                  SubHeadingText(text: 'Change Nickname'),
                                    vSizedBox2,
                                    CustomTextField(controller: nicknameController, hintText: 'Enter new name for ${members[index]['nickname']}'),
                                    vSizedBox,
                                    RoundEdgedButton(text: 'Update', onTap: (){
                                      if(nicknameController.text==''){
                                        showSnackbar(context, 'Name cannot be empty');
                                      }else{
                                        Navigator.pop(context, nicknameController.text);
                                      }
                                    },)
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        print('the confirmation result is $nickname');
                        if(nickname!=null){
                          var request = {
                            'group_id': widget.groupDetail['id'].toString(),
                            'user_id': userId,
                            'member_id': members[index]['id'].toString(),
                            'nickname': nickname
                          };
                          setState(() {
                            load = true;
                          });
                          var jsonResponse = await Webservices.postData(url: ApiUrls.edit_group_member_nickname, request: request, context: context, isGetMethod: true, showSuccessMessage: true);
                          getMembers(showLoad: true);
                        }
                      }, icon: Icon(Icons.edit),),
                      // hSizedBox05,
                      if(widget.groupDetail['owner_id'].toString()==userId && members[index]['user_id'].toString()!=userId)
                      IconButton(onPressed: ()async{
                        bool? result = await showCustomConfirmationDialog(description: 'This user will be removed from your group');
                        print('the confirmation result is $result');
                        if(result==true){
                          var request = {
                            'group_id': widget.groupDetail['id'].toString(),
                            'user_id': userId,
                            'member_id': members[index]['id'].toString()
                          };
                          setState(() {
                            load = true;
                          });
                          var jsonResponse = await Webservices.postData(url: ApiUrls.removeMemberFromGroup, request: request, context: context, isGetMethod: true, showSuccessMessage: true);
                          getMembers(showLoad: true);
                        }
                      }, icon: Icon(Icons.remove_circle),),
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
