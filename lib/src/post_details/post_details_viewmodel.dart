import 'dart:io';

import 'package:ahmed_test/src/model/post_model.dart';
import 'package:ahmed_test/src/post_details/post_details_view.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_collection_previewer/enums.dart';
import 'package:media_collection_previewer/media_collection.dart';
import 'package:media_collection_previewer/models/media.dart';
import 'package:media_collection_previewer/models/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:video_player/video_player.dart';

import '../../core/helper_manager.dart';
import '../add_post/audiocontrol.dart';
import '../model/coment_model.dart';
import '../posts/posts_viewmodel.dart';


abstract class PostDetailsViewModel extends State<PostDetailsView>{
  TextEditingController valueControl=TextEditingController();
  bool isValue=false;
  String valueText="";
  static PostModel?postModel;
  PostModel? details;
  int viewRecord=0;
  int view=0;
  String postId="";


  CommentModel commentModel=CommentModel();



  @override
  void initState() {

    setState(() {
    details=PostDetailsViewModel.postModel;
    postId=details!.id!;

      PostDetailsViewModel.postModel!.video!=null?
       loadVideoPlayer(PostDetailsViewModel.postModel!.video!) :null;
    });
    super.initState();
  }


Future<void> addComment() async {

  if(valueControl.text!=""||compressedMainImage!=null||videoPath!=null||recordFilePath!=null){

    setState(() {
      commentModel.id=postId;
      commentModel.text=valueControl.value.text;
      commentModel.image=compressedMainImage;
      commentModel.video=videoPath;

      print(recordFilePath);
      if(recordFilePath.toString()!=""){
        commentModel.audio=recordFilePath;
        commentModel.recordId=DateTime.now().microsecond.toString();
      }

    });
    PostsViewModel.addCommentModel.add(commentModel);
    toastAppSuccess("تم أضافة كومنت بنجاح",context);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PostDetailsView(),));


    print(commentModel.toJson());

  }else{
    toastAppSuccess("حدث خطأ ما",context);
    return;
  }


}

  VideoPlayerController? controller;
  loadVideoPlayer(File file) {
    if(controller != null) {
      controller!.dispose();
    }

    controller = VideoPlayerController.file(file);
    controller!.initialize().then((value) {
      setState(() {});
    });
  }



  void setStatePlayVideo(VideoPlayerController playOrStop) {
    setState(() {
      controller!.value.isPlaying
          ? playOrStop.pause()
          : playOrStop.play();
    });
  }




  AudioController audioController = Get.put(AudioController());
  AudioPlayer audioPlayer = AudioPlayer();
  String audioURL = "";
  String? recordFilePath;



  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {

      recordFilePath = await getFilePath();
      RecordMp3.instance.start(recordFilePath!, (type) {
        setState(() {});
      });
      print("${recordFilePath} 9999999999999999999999999999999999999");

    } else {}
    setState(() {});
  }

  void stopRecord() async {
    bool stop = RecordMp3.instance.stop();
    audioController.end.value = DateTime.now();
    audioController.calcDuration();

    // var ap = AudioPlayer();
    // await ap.setSourceUrl("assets/images/Notification.mp3" );
    // ap.onPlayerComplete.listen((a) {});
    if (stop) {
      setState(()  {
        audioController.isRecording.value = false;
        audioController.isSending.value = true;

      });

      // await uploadAudio();
    }
  }

  int i = 0;

  Future<String> getFilePath() async {

    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath =
        "${storageDirectory.path}/record${DateTime.now().microsecondsSinceEpoch}.acc";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return "$sdPath/test_${i++}.mp3";
  }







  final ImagePicker imagePicker = ImagePicker();
  File? pathForFile;
  File? compressedMainImage;
  File? videoPath;

  Future<void> openExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if (result != null) {
      print("File selected");
      print("${File(result.files.map((e) => e.path).toString().replaceAll("(", "").replaceAll(")", ""))} 222222222222222222");

      setState(() {
        pathForFile=File(result.files.map((e) => e.path).toString().replaceAll("(", "").replaceAll(")", ""));
      });

      if(pathForFile.toString().contains(".jpg")){
        controller=null;
        var res = await FlutterImageCompress.compressAndGetFile(
          pathForFile!.absolute.path,
          pathForFile!.path + 'compressed.jpg',
          quality: 50,
        );

        compressedMainImage = File(res!.path);

        print("${compressedMainImage} 33333333333333333333333333333333333333");
        setState(() {
        });
      }else if(pathForFile.toString().contains(".mp4")){
        compressedMainImage=null;
        videoPath=pathForFile;
        loadVideoPlayer(pathForFile!);
      }
    }



  }









}