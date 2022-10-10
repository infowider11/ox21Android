import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/widgets/appbar.dart';
import 'package:flutter_html/flutter_html.dart';
import '../services/webservices.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
  bool load = false;
  String result = "";
  getData()async{
    setState(() {
      load = true;
    });
    result = await Webservices.getPoliciesData(url: ApiUrls.termsAndConditionsLink);
    setState(() {
      load = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Terms And Conditions', style: TextStyle(color: Colors.black),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
      ),
      body:
      load?
      Center(child: CircularProgressIndicator(color: MyColors.primaryColor,)):
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Html(
            data: """$result""",
          ),
        ),
      ),
    );
  }
}



class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
  bool load = false;
  String result = "";
  getData()async{
    setState(() {
      load = true;
    });
    result = await Webservices.getPoliciesData(url:ApiUrls.privacyPolicy);
    setState(() {
      load = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Privacy Policy', style: TextStyle(color: Colors.black),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
      ),
      body:
      load?
      Center(child: CircularProgressIndicator(color: MyColors.primaryColor,)):
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Html(
            data: """$result""",
          ),
        ),
      ),
    );
  }
}

class CopyrightPage extends StatefulWidget {
  const CopyrightPage({Key? key}) : super(key: key);

  @override
  State<CopyrightPage> createState() => _CopyrightPageState();
}

class _CopyrightPageState extends State<CopyrightPage> {
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
  bool load = false;
  String result = "";
  getData()async{
    setState(() {
      load = true;
    });
    result = await Webservices.getPoliciesData(url: ApiUrls.copyrightsUrl);
    setState(() {
      load = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Copyrights', style: TextStyle(color: Colors.black),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
      ),
      body:
      load?
      Center(child: CircularProgressIndicator(color: MyColors.primaryColor,)):
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Html(
            data: """$result""",
          ),
        ),
      ),
    );
  }
}


