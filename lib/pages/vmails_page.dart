import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/global_constants.dart';
import 'package:ox21/constants/global_keys.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/functions/navigation_functions.dart';
import 'package:ox21/pages/vmail_detail_page.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:ox21/widgets/customLoader.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:ox21/widgets/send_vmail.dart';
import 'package:flutter_translate/flutter_translate.dart';
class VMailPage extends StatefulWidget {
  const VMailPage({Key? key}) : super(key: key);

  @override
  _VMailPageState createState() => _VMailPageState();
}
const List<Tab> tabs = <Tab>[
  Tab(text: 'Received'),
  Tab(text: 'Sent'),
];
class _VMailPageState extends State<VMailPage> {
  bool load = false;
  bool onLastIndex = true;
  List sentVMails = [];
  List receivedVMails = [];
  List myDomains = [];
  int pageNo = 1;



  getDomains() async {
    setState(() {
      load = true;
    });
    myDomains =
        await Webservices.getList(ApiUrls.getMyDomains + 'user_id=$userId&status=1');
    if (myDomains.length == 0) {
      Navigator.pop(MyGlobalKeys.navigatorKey.currentContext!);
      showSnackbar(MyGlobalKeys.navigatorKey.currentContext!,
          translate("vmails_page.text"));
    }
  }

  getVmails() async {
    setState(() {
      load = true;
    });
    await getDomains();
    // var request = {
    //   'user_id': userId,
    //   'type': 'received'
    // };
    sentVMails = [];
    sentVMails = await Webservices.getList(
        ApiUrls.get_vmails + '?user_id=$userId&type=sent');
    receivedVMails = [];
    receivedVMails = await Webservices.getList(
        ApiUrls.get_vmails + '?user_id=$userId&type=received');
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getVmails();
    super.initState();
  }


  buildSentMails(){
    return load
        ? CustomLoader()
        : RefreshIndicator(
      onRefresh: ()async{
        getVmails();
      },
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: 16),
          child: NotificationListener<ScrollUpdateNotification>(
            onNotification: (scroll) {
              if (onLastIndex &&
                  scroll.metrics.maxScrollExtent == scroll.metrics.pixels) {
                onLastIndex = false;
                String lastObjectId = sentVMails.last['id'].toString();
                List newData = [];
                setState(() {});
                // items = await Webservices.getList(ApiUrls.Community_court_post + 'user_id=$userId');
                // Webservices.getList(ApiUrls.getAllPost +
                //     'user_id=$userId&last_id=$lastObjectId&page=${++pageNo}')

                Webservices.getList(ApiUrls.get_vmails +
                    'user_id=$userId&page=${++pageNo}')
                    .then((value) {
                  newData = value;
                  setState(() {
                    print('about to add new items ${sentVMails.length}');
                    sentVMails = sentVMails + newData;
                    print('added new items ${sentVMails.length}');
                    onLastIndex = true;
                  });
                });
              }

              return true;
            },
            child: sentVMails==0?Center(
              child: ParagraphText(text:translate("vmails_page.noData")),
            ):ListView.builder(
              itemCount: sentVMails.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: ()async{

                    await push(context: context, screen: VmailDetailPage(vmailData: sentVMails[index],));
                    getVmails();
                  },
                  child: Container(
                    color: Colors.grey.shade200,
                    margin: EdgeInsets.symmetric(vertical: 4),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: SubHeadingText(
                                text: sentVMails[index]['subject'],
                              ),
                            ),
                            Expanded(
                              child: ParagraphText(
                                textAlign: TextAlign.end,
                                text: DateFormat.yMMMd().add_jm().format(
                                  DateTime.parse(
                                    sentVMails[index]['created_at'],
                                  ).toLocal(),
                                ),
                              ),
                            )
                          ],
                        ),
                        vSizedBox,
                        Container(
                          height: 25,
                          // padding: const EdgeInsets.only(right: 40),
                          child: ParagraphText(text: sentVMails[index]['body'],overflow: TextOverflow.ellipsis,maxLines: 2,),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }
  buildReceivedMails(){
    return load
        ? CustomLoader()
        : RefreshIndicator(
      onRefresh: ()async{
        getVmails();
      },
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: 16),
          child: NotificationListener<ScrollUpdateNotification>(
            onNotification: (scroll) {
              if (onLastIndex &&
                  scroll.metrics.maxScrollExtent == scroll.metrics.pixels) {
                onLastIndex = false;
                String lastObjectId = receivedVMails.last['id'].toString();
                List newData = [];
                setState(() {});
                // items = await Webservices.getList(ApiUrls.Community_court_post + 'user_id=$userId');
                // Webservices.getList(ApiUrls.getAllPost +
                //     'user_id=$userId&last_id=$lastObjectId&page=${++pageNo}')

                Webservices.getList(ApiUrls.get_vmails +
                    'user_id=$userId&page=${++pageNo}')
                    .then((value) {
                  newData = value;
                  setState(() {
                    print('about to add new items ${receivedVMails.length}');
                    receivedVMails = receivedVMails + newData;
                    print('added new items ${receivedVMails.length}');
                    onLastIndex = true;
                  });
                });
              }

              return true;
            },
            child: receivedVMails==0?Center(
              child: ParagraphText(text:translate("vmails_page.noData")),
            ):ListView.builder(
              itemCount: receivedVMails.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: ()async{
                    await push(context: context, screen: VmailDetailPage(vmailData: receivedVMails[index],));
                    getVmails();
                  },
                  child: Container(
                    color: Colors.grey.shade200,
                    margin: EdgeInsets.symmetric(vertical: 4),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: SubHeadingText(
                                text: receivedVMails[index]['subject'],
                              ),
                            ),
                            Expanded(
                              child: ParagraphText(
                                textAlign: TextAlign.end,
                                text: DateFormat.yMMMd().add_jm().format(
                                  DateTime.parse(
                                    receivedVMails[index]['created_at'],
                                  ).toLocal(),
                                ),
                              ),
                            )
                          ],
                        ),
                        vSizedBox,
                        Container(
                          height: 25,
                          // padding: const EdgeInsets.only(right: 40),
                          child: ParagraphText(text: receivedVMails[index]['body'],overflow: TextOverflow.ellipsis,maxLines: 2,),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }




  @override
  Widget build(BuildContext context) {
    print('the userData is $userData');
    return Scaffold(
      appBar: appBar(context: context, title: translate("vmails_page.title")),
      floatingActionButton: IconButton(
        icon: Icon(
          Icons.add_box,
          color: Colors.black,
          size: 50,
        ),
        onPressed: ()async {
          bool? result = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return SendVmailBottomSheet(
                myDomains: myDomains,
              );
            },
          );
          if(result==true){
            getVmails();
          }
        },
      ),
      body: DefaultTabController(
        length: tabs.length,
        // The Builder widget is used to have a different BuildContext to access
        // closest DefaultTabController.
        child: Builder(builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context)!;
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              // Your code goes here.
              // To get index of current tab use tabController.index
            }
          });
          return Column(
            children: [
              TabBar(
                tabs: tabs,
                labelColor: MyColors.primaryColor,
                indicatorColor: MyColors.primaryColor,
              ),
              Expanded(
                child: TabBarView(
                  children: [
                  buildReceivedMails(),
                    buildSentMails(),
                  ]
                ),
              ),
            ],
          );
        }),
      ),
      // body: load
      //     ? CustomLoader()
      //     : RefreshIndicator(
      //   onRefresh: ()async{
      //     getVmails();
      //   },
      //       child: Container(
      //           // padding: EdgeInsets.symmetric(horizontal: 16),
      //           child: NotificationListener<ScrollUpdateNotification>(
      //           onNotification: (scroll) {
      //             if (onLastIndex &&
      //                 scroll.metrics.maxScrollExtent == scroll.metrics.pixels) {
      //               onLastIndex = false;
      //               String lastObjectId = receivedVMails.last['id'].toString();
      //               List newData = [];
      //               setState(() {});
      //               // items = await Webservices.getList(ApiUrls.Community_court_post + 'user_id=$userId');
      //               // Webservices.getList(ApiUrls.getAllPost +
      //               //     'user_id=$userId&last_id=$lastObjectId&page=${++pageNo}')
      //
      //               Webservices.getList(ApiUrls.get_vmails +
      //                       'user_id=$userId&page=${++pageNo}')
      //                   .then((value) {
      //                 newData = value;
      //                 setState(() {
      //                   print('about to add new items ${receivedVMails.length}');
      //                   receivedVMails = receivedVMails + newData;
      //                   print('added new items ${receivedVMails.length}');
      //                   onLastIndex = true;
      //                 });
      //               });
      //             }
      //
      //             return true;
      //           },
      //           child: receivedVMails==0?Center(
      //             child: ParagraphText(text:'No Mails Found'),
      //           ):ListView.builder(
      //             itemCount: receivedVMails.length,
      //             itemBuilder: (context, index) {
      //               return GestureDetector(
      //                 onTap: (){
      //                   push(context: context, screen: VmailDetailPage(vmailData: receivedVMails[index],));
      //                 },
      //                 child: Container(
      //                   color: Colors.grey.shade200,
      //                   margin: EdgeInsets.symmetric(vertical: 4),
      //                   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Row(
      //                         children: [
      //                           Expanded(
      //                             flex: 2,
      //                             child: SubHeadingText(
      //                               text: receivedVMails[index]['subject'],
      //                             ),
      //                           ),
      //                           Expanded(
      //                             child: ParagraphText(
      //                               textAlign: TextAlign.end,
      //                               text: DateFormat.yMMMd().add_jm().format(
      //                                     DateTime.parse(
      //                                       receivedVMails[index]['created_at'],
      //                                     ).toLocal(),
      //                                   ),
      //                             ),
      //                           )
      //                         ],
      //                       ),
      //                       vSizedBox,
      //                       Container(
      //                         height: 25,
      //                         // padding: const EdgeInsets.only(right: 40),
      //                         child: ParagraphText(text: receivedVMails[index]['body'],overflow: TextOverflow.ellipsis,maxLines: 2,),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //               );
      //             },
      //           ),
      //         )),
      //     ),
    );
  }
}
