import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/customtextfield.dart';
class CommentsPageInHomeFeed extends StatefulWidget {
  final String postId;
  const CommentsPageInHomeFeed({Key? key, required this.postId}) : super(key: key);

  @override
  State<CommentsPageInHomeFeed> createState() => _CommentsPageInHomeFeedState();
}

class _CommentsPageInHomeFeedState extends State<CommentsPageInHomeFeed> {
  List comments = [];
  bool load = false;
  TextEditingController messageController = TextEditingController();
  getComments({bool shouldLoad = true})async{


    if(shouldLoad)
      setState(() {
        load = true;
      });
    var request = {
      'user_id': userId,
      'post_id': widget.postId
    };
    comments = await Webservices.getListFromRequestParameters(ApiUrls.getPostComments, request);
    if(shouldLoad)
      load = false;
    setState(() {

    });
  }

  Timer? commentsTimer;
  @override
  void initState() {
    // TODO: implement initState
    getComments();
    commentsTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      getComments(shouldLoad: false);
    });
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose


    commentsTimer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      // load?CustomLoader():comments.length==0?Center(child: ParagraphText(text: 'No Comments Found',),)
      // :
      Column(
        children: [
          Expanded(
            child:load?CustomLoader(): comments.length==0?Center(child: ParagraphText(text: 'No Comments Found',),): ListView.builder(
              itemCount: comments.length ,
              itemBuilder: (context, index){
                return Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(comments[index]['createdBy']!=null)
                            SubHeadingText(text: '${comments[index]['createdBy']['domain']??'Anonymous'}')
                            else
                              SubHeadingText(text: 'Anonymous'),
                            ParagraphText(text: '${comments[index]['message']}'),
                          ],
                        ),
                      ),

                      hSizedBox,
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(child: CustomTextField(controller: messageController,hintText: 'Type something here',)),
              IconButton(
                  onPressed: () async {
                    var request = {
                      "user_id":userId,
                      "post_id":widget.postId,
                      "message":messageController.text,
                    };
                    Webservices.postData(url: ApiUrls.comment_on_post, request: request, context: context);
                    FocusScope.of(context).requestFocus(new FocusNode());
                    messageController.clear();
                  },
                  icon: Icon(Icons.send)),
            ],
          ),
          Container(
            height: MediaQuery.of(context).viewInsets.bottom,
          )
        ],
      ),
    );
  }
}
