// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
//
// import 'CustomTexts.dart';
//
// class CustomDropdownButton extends StatefulWidget {
//   final List? items;
//   final String hint;
//   final BoxBorder? border;
//   final dynamic? selectedItem;
//   final Function(dynamic value)? onChanged;
//   const CustomDropdownButton(
//       {Key? key, required this.items, required this.hint, this.onChanged, this.border, this.selectedItem,})
//       : super(key: key);
//
//   @override
//   _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
// }
//
// class _CustomDropdownButtonState extends State<CustomDropdownButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 12),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           border: widget.border,
//           // border: Border.all(color: MyColors.darkGreyColor),
//           borderRadius: BorderRadius.circular(6)),
//       padding: EdgeInsets.only(left: 10),
//       child: DropdownSearch(
//         selectedItem: widget.selectedItem,
//         dropdownSearchDecoration: InputDecoration.collapsed(
//           hintText: widget.hint,
//           hintStyle:textFieldHintTextStyle,
//         ),
//         mode: Mode.MENU,
//         dropdownSearchBaseStyle: textFieldTextStyle,
//         items: widget.items,
//         onChanged: widget.onChanged,
//       ),
//     );
//   }
// }
//
// class CustomDropdownButtonEditProfile extends StatefulWidget {
//   final List items;
//   final String headingText;
//   final String hintText;
//   final Function(dynamic value)? onChanged;
//   const CustomDropdownButtonEditProfile({
//     Key? key,
//     required this.hintText,
//     required this.headingText,
//     required this.items,
//     this.onChanged,
//   }) : super(key: key);
//
//   @override
//   State<CustomDropdownButtonEditProfile> createState() => _CustomDropdownButtonEditProfileState();
// }
//
// class _CustomDropdownButtonEditProfileState extends State<CustomDropdownButtonEditProfile> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SubHeadingText(text: widget.headingText),
//           DropdownSearch(
//             dropdownSearchDecoration: InputDecoration(
//               hintText: widget.hintText,
//             ),
//             mode: Mode.MENU,
//             items: widget.items,
//             onChanged: widget.onChanged,
//           ),
//         ],
//       ),
//     );
//   }
// }
