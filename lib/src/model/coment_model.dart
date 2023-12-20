import 'dart:io';

class CommentModel {
  String?id;
  File? image;
  String? text;
  File? video;
  late String ? audio;
  String? recordId;


  CommentModel({this.id,this.image, this.text,this.video,this.audio,this.recordId});

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    text = json['text'];
    video = json['video'];
    audio = json['audio'];
    recordId = json['recordId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['text'] = this.text;
    data['video'] = this.video;
    data['audio'] = this.audio;
    data['recordId'] = this.recordId;

    return data;
  }
}