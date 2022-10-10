// import 'package:audio_waveforms/audio_waveforms.dart';
//
// List<String> kMessageType = [
//   'text',  //0
//   'image',  //1
//   'audio', //2
//   'video', //3
//   'gift', //4
//
// ];
// class MessageModal {
//   String id;
//   String message;
//   DateTime dateTime;
//   String senderId;
//   String recieverId;
//   String messageType;
//   bool isRead;
//   String timeAgo;
//   Map? giftData;
//   bool load;
//   String? thumbnail;
//   int duration;
//   PlayerController? playerController;
//
//   MessageModal({
//     required this.id,
//     required this.message,
//     required this.dateTime,
//     required this.senderId,
//     required this.recieverId,
//     required this.isRead,
//     required this.messageType,
//     required this.timeAgo,
//     this.giftData,
//     this.playerController,
//     this.load = false,
//     required this.thumbnail,
//     required this.duration,
//   });
//
//   factory MessageModal.fromJson(Map<String, dynamic> message) {
//     // PlayerController temp = PlayerController();
//     return MessageModal(
//       id: message['id'],
//       message: message['message'],
//       dateTime: DateTime.parse(message['create_date']??DateTime.now()),
//       senderId: message['sender_id']'ffdd',
//       recieverId: message['receiver'],
//       isRead: message['is_read']=='1'?true:false,
//       messageType: message['message_type'],
//       timeAgo: message['time_ago'],
//       giftData: message['gift_data'],
//       duration:message['duration']==null?0: int.parse(message['duration'].toString()),
//       thumbnail: message['thumbnail'],
//       // playerController: message['message_type']==kMessageType[2]?temp:null,
//     );
//   }
// }
//
