// import 'package:flutter/material.dart';
// import 'package:ox21/widgets/appbar.dart';
// import 'package:ox21/widgets/customLoader.dart';
// import 'package:video_player/video_player.dart';
//
// class PlayVideoPage extends StatefulWidget {
//   final String videoUrl;
//   final double? aspectRatio;
//   const PlayVideoPage({Key? key, required this.videoUrl, this.aspectRatio}) : super(key: key);
//
//   @override
//   _PlayVideoPageState createState() => _PlayVideoPageState();
// }
//
// class _PlayVideoPageState extends State<PlayVideoPage> {
//   VideoPlayerController? _controller;
//   bool isPlaying = false;
//
//   bool load = false;
//
//
//   initializeController()async{
//     setState(() {
//       load = true;
//     });
//     _controller = VideoPlayerController.network(
//         widget.videoUrl
//         // "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
//     )
//       ..initialize().then((_) {
//         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//         setState(() {
//           load = false;
//         });
//       }).onError((error, stackTrace){
//         print('the errorr is $error and strach $stackTrace');
//         initializeController();
//       });
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//    initializeController();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     print(widget.videoUrl);
//     return Scaffold(
//       appBar: appBar(context: context,),
//       body:load?CustomLoader(): Center(
//         child: Stack(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: InteractiveViewer(
//                 maxScale:
//                 4,
//                 minScale:
//                 1,
//                 child: AspectRatio(
//                   aspectRatio:widget.aspectRatio?? _controller!.value.aspectRatio,
//                   // aspectRatio: 1.4,
//                   child: VideoPlayer(_controller!),
//                 ),
//               ),
//             ),
//             Positioned(
//               left: 0,
//               right: 0,
//               top: 0,
//               bottom: 0,
//               child: Center(
//                 child: IconButton(
//                   icon: Icon(isPlaying?Icons.pause:Icons.play_arrow, color: Colors.white,size: 50,),
//                   onPressed: (){
//                     !isPlaying?
//                     _controller?.play():_controller?.pause();
//
//                     isPlaying = !isPlaying;
//                     setState(() {
//
//
//                     });
//
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
