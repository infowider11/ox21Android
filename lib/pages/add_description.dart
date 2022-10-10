import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/sized_box.dart';
import 'package:ox21/widgets/CustomTexts.dart';
import 'package:ox21/widgets/appbar.dart';

class Add_Description_Page extends StatefulWidget {
  static const String id="Add_Description_Page";
  final TextEditingController descriptionController;
  const Add_Description_Page({Key? key,required this.descriptionController, }) : super(key: key);

  @override
  State<Add_Description_Page> createState() => _Add_Description_PageState();
}

class _Add_Description_PageState extends State<Add_Description_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Add description', titleColor: MyColors.secondary, toolbarHeight: 50, actions: [
        TextButton(
            onPressed: () {
              // Navigator.pushNamed(context, Select_Audience.id);
              Navigator.pop(context);
            },
            child: ParagraphText(
              text: 'Done',
              color: MyColors.secondary,
              fontSize: 16,
              fontFamily: 'semibold',
            ))
      ]),
      body: Container(
        padding: EdgeInsets.all(16),
        child:  Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // ParagraphText(text: 'Add Description', fontSize: 14,color: MyColors.blackColor.withOpacity(0.5),),
              // vSizedBox2,
              TextFormField(
                maxLength: 5000,
                controller: widget.descriptionController,
                maxLines: 6,

                // initialValue: 'description here..',
                decoration: InputDecoration(
                  // labelText: 'Add description',
                  hintText: 'Add Description',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
