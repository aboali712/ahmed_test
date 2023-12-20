import 'dart:io';

class PostModel {
  String? id;
  File? image;
  String? text;
  File? video;
late String ? audio;
  int? color;

  PostModel({this.id,this.image, this.text,this.video,this.audio,this.color});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    text = json['text'];
    video = json['video'];
    audio = json['audio'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['text'] = this.text;
    data['video'] = this.video;
    data['audio'] = this.audio;
    data['color'] = this.color;
    return data;
  }
}