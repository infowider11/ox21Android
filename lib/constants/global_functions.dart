import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ox21/constants/global_keys.dart';
import 'package:ox21/services/api_urls.dart';
import 'package:ox21/services/webservices.dart';
import 'package:ox21/widgets/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'colors.dart';
import 'global_constants.dart';
import 'dart:io';

updateSharedPreference(Map<String,dynamic> userdetail)async{
  SharedPreferences sharedPreferences  =await SharedPreferences.getInstance();
  userId = userdetail['id'].toString();
  userData = userdetail;
  sharedPreferences.setString('data', jsonEncode(userdetail));
}



Future<Map<String,dynamic>> updateSharedPreferenceFromServer()async{

  var data = await Webservices.getData(ApiUrls.getUserData + userId);
  print('updating...');
  print(ApiUrls.getUserData + userId);
  print(data.body);
  if(data.statusCode==200){
    var jsonResponse = jsonDecode(data.body);
    SharedPreferences sharedPreferences  =await SharedPreferences.getInstance();
    sharedPreferences.setString('data', jsonEncode(jsonResponse['data']));
    userData = jsonResponse['data'];
    print('the data is updated');
    print(sharedPreferences.getString('data'));
    return jsonResponse['data'];
  }else{
    print('the data is not updated ${data.statusCode}');
  }
  // userId = data['id'];

  return {};

}



Future<File?> pickAudio()async{
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowedExtensions: ['mp3']
  );

  if (result != null) {
    File file = File(result.files.single.path!);
    return file;
  } else {
    // User canceled the picker
  }
}

Future<File?> pickVideo({bool isGallery = true})async{
  final ImagePicker picker = ImagePicker();
  File? video;
  String? videoFile;
  try{
    XFile? pickedVideo;
    if(isGallery){
      pickedVideo = await picker.pickVideo(source: ImageSource.gallery,);

    }else{
      pickedVideo = await picker.pickVideo(source: ImageSource.camera);
    }

    int videoLength = await pickedVideo!.length();
    print('the length of the video is');
    print(videoLength);
    // if(videoLength>10485760){
    //   if(videoLength>1085760){
    //   showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, 'Video must be less than 1 mb');
    //   // return null;
    // }
    video = File(pickedVideo.path);
    videoFile = pickedVideo.path;
  }catch(e){
    print('Error in picking video $e');
  }


  return video;


}


Future<File?> pickImage({bool isGallery = false}) async {
  final ImagePicker picker = ImagePicker();
  File? image;
  String? _imageFile;
  try {
    print('about to pick image');
    XFile? pickedFile;
    if(isGallery){
      pickedFile = await picker.pickImage(
          source: ImageSource.gallery, imageQuality: 70);
    }
    else{
      pickedFile = await picker.pickImage(
          source: ImageSource.camera, imageQuality: 70);
    }
    print('the error is $pickedFile');
    int length = await pickedFile!.length();
    print('the length is');
    // print('size : ${length}');
    print('size: ${pickedFile.readAsBytes()}');
    File? croppedFile = await ImageCropper().cropImage(
        cropStyle: CropStyle.circle,
        // aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: length > 100000 ?length > 200000 ?length > 300000 ?length > 400000 ? 5:10:20: 30 : 50,
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          // CropAspectRatioPreset.ratio3x2,
          // CropAspectRatioPreset.original,
          // CropAspectRatioPreset.ratio4x3,
          // CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            activeControlsWidgetColor: MyColors.primaryColor,
            toolbarTitle: 'Adjust your Post',
            toolbarColor: MyColors.primaryColor,
            toolbarWidgetColor: MyColors.whiteColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    _imageFile = croppedFile!.path;
    image = File(croppedFile.path);
    print(croppedFile);
    print(image);
    // setState(() {
    // });

    return image;
  } catch (e) {
    print("Image picker error $e");
  }
}


Future<List<File>> pickMultipleImages()async{
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowMultiple: true,
  );
  List<File> tFiles = [];
  result!.files.forEach((element) {
    tFiles.add(File(element.path!));
  });
  return tFiles;
}


String timeAgo(DateTime d) {
  Duration diff = DateTime.now().difference(d);
  print('the diff is ${diff.inMilliseconds}');
  if (diff.inDays > 365)
    return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  if (diff.inDays > 30)
    return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  if (diff.inDays > 7)
    return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  if (diff.inDays > 0)
    return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
  if (diff.inHours > 0)
    return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
  if (diff.inMinutes > 0)
    return "${diff.inMinutes} ${diff.inMinutes == 1 ? "min" : "mins"} ago";
  if(diff.inSeconds>3)
    return "${diff.inSeconds} ${diff.inSeconds == 1 ? "sec" : "secs"} ago";
  if(diff.inSeconds<0){
    return 'Uploading soon';
  }
  return "just now";
}