
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';
import 'package:video_player/video_player.dart';

import '../../core/help.dart';


import 'package:social_media_recorder/audio_encoder_type.dart';

import 'add_post_viewmodel.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({Key? key}) : super(key: key);

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends AddPostViewModel {





  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top, SystemUiOverlay.bottom
    ]);
    return Scaffold(
      backgroundColor:
      colorType==5?
      Colors.blue
      :colorType==4?
      const Color(0xffD939CD)
      :colorType==3?
      const Color(0xffCA26ff)
      :colorType==2?
      Colors.green
      : Colors.red,




      body: Stack(
        children: [
          SizedBox(height: size.height,width: size.width,),

          Flex(
            direction: Axis.horizontal,
            children: [ Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                const SizedBox(height: 30,),

                Container(width: size.width,height: 50,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(color: Colors.white),
                  child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back_outlined,size: 20,color: Colors.black,)),
                    InkWell(onTap: () {
                      add();

                    },child: Text("Post",style: GoogleFonts.tajawal(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),))

                  ]),
                ),

                const SizedBox(height: 10,),
                TextFormField(
                  controller:valueControl,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(fontSize: 19,color: Colors.white,),
                  maxLines: 5,

                  decoration: InputDecoration(
                    hintMaxLines: 2,
                    hintText: tr("Share your thoughts and experiences with the people around you"),
                    hintStyle:  GoogleFonts.tajawal(
                        fontSize: 20,fontWeight: FontWeight.w500,
                        color:Colors.white60 ),

                    errorStyle: const TextStyle(color: Colors.red),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    filled: true,
                    fillColor:  Colors.transparent,

                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,



                  ),
                  onChanged: (value) {
                    if (value.isEmpty ||
                        value == null ||
                        !InputValidators().nameValidator(
                            name:  value, context: context)) {

                      isValue= true;
                      valueText = value;

                    } else {

                      isValue = false;
                      valueText = value;

                    }
                  },
                  onSaved: (value) {
                    valueText = value ?? "";
                  },

                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                ),

                  compressedMainImage != null
                      ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(
                        compressedMainImage!,
                        height: 230,
                        width: size.width,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                  : controller != null?
                     Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                        TextButton(
                            style: TextButton.styleFrom(
                                fixedSize: const Size(120, 45),

                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                    side: const BorderSide(
                                        color: Colors.white)),
                                backgroundColor: Colors.white),
                            onPressed: () {
                              setStatePlayVideo(controller!);

                            }, child: Text(
                          controller!.value.isPlaying ?
                          tr("Stop")
                              :tr("Play")
                          ,style: GoogleFonts.tajawal(color: Colors.black,fontSize: 15,
                            fontWeight:FontWeight.w500 ),)),
                        const SizedBox(height: 10,),


                        Stack(
                            children: [
                              Container(height: 250,width: size.width,

                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(0),
                                    border:Border.all(color: const Color(0xffA8A8A8)) ),
                                child: AspectRatio(
                                  aspectRatio: controller!.value.aspectRatio,
                                  child: VideoPlayer(controller!),
                                ),
                              ),
                              Positioned(height: 230,left: 160,
                                child: Icon(
                                  controller!.value.isPlaying ?
                                  Icons.pause : Icons.play_arrow,color: Colors.white,size: 35,
                                ),
                              ),
                            ]),
                        const SizedBox(height: 70,),

                      ],
                    ),
                  )
                  : const SizedBox.shrink(),




                  Container(
                    height:100,width: size.width,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      GestureDetector(
                        onTap: () {
                          print(recordFilePath);
                         audioController.onPressedPlayButton(0, recordFilePath);
                          // changeProg(duration: duration);
                        },
                        onSecondaryTap: () {
                          audioPlayer.stop();
                          //   audioController.completedPercentage.value = 0.0;
                        },
                        child: Obx(
                              () => (audioController.isRecordPlaying &&
                              audioController.currentId == 0)
                              ? const Icon(
                            Icons.cancel,
                            color:  Colors.white ,
                          )
                              : const Icon(
                            Icons.play_arrow,
                            color:  Colors.black,
                          ),
                        ),
                      ),
                      Obx(
                            () => SizedBox(

                          width: 220,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.center,
                              children: [

                                LinearProgressIndicator(
                                  minHeight: 5,
                                  backgroundColor: Colors.grey,
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                     Colors.white,
                                  ),
                                  value: (audioController.isRecordPlaying &&
                                      audioController.currentId == 0)
                                      ? audioController.completedPercentage.value
                                      : audioController.totalDuration.value.toDouble(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                       Text(
                        audioController.total.toString(),
                        style: const TextStyle(
                            fontSize: 12, color:
                        Colors.black ),
                      ),

                      const SizedBox(
                        width: 10,
                      ),




                    ],
                  ),),
                   const SizedBox(height: 30,),






                        ]),
              ),
            ),
          ]),


        view==0?
          Positioned(bottom: 10,left: viewRecord==1?0:15,right:viewRecord==1?0: 15,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                viewRecord==1?
                    const SizedBox.shrink()
                :Container(
                  padding: const EdgeInsets.all(10),
                  height: 45,width: 45,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                    color: Colors.black45
                ),
                  child: Image.asset("assets/images/rocket.png",color: Colors.white,),),





            Row(children: [
              viewRecord==1?
                const SizedBox.shrink()
             : InkWell(onTap: (){
                setState(() {
                  view=3;
                });
              },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 45,width: 45,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                    color: Colors.black45
                ),
                  child: const Icon(Icons.invert_colors,color: Colors.white,size: 25,),),
              ),
               SizedBox(width:viewRecord==1?0: 15,),

              viewRecord==1?
               const SizedBox.shrink()
             : InkWell(onTap: () {
              openExplorer();
              },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 45,width: 45,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                    color: Colors.black45
                ),
                  child: const Icon(Icons.camera_alt_rounded,color: Colors.white,size: 25,),),
              ),


              SizedBox(width:viewRecord==1?0: 15,),

              Align(alignment: AlignmentDirectional.centerEnd,
                child: SocialMediaRecorder(

                  backGroundColor: Colors.black45,
                  initRecordPackageWidth: 50,
                  fullRecordPackageHeight: 50,
                  radius: BorderRadius.circular(50),
                  startRecording: () {
                   setState(() {
                     viewRecord=1;
                   });
                    audioController.start.value = DateTime.now();
                    startRecord();
                    audioController.isRecording.value = true;
                  },
                  stopRecording: (time) {

                    stopRecord();
                    setState(() {
                      viewRecord=0;
                    });
                  },
                  encode: AudioEncoderType.AAC, sendRequestFunction: (soundFile,time) {  },
                ),
              ),



            ],),




            ],),
          )

              :  Positioned(bottom: 10,left: 15,right: 15,
          child: Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [

              const SizedBox(width: 10,),
              InkWell(onTap: (){
                setState(() {
                  view=0;
                  colorType=5;
                });
              },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 45,width: 45,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.white,width: 2),
                    color: Colors.blue
                ),
                ),
              ),
              const SizedBox(width: 10,),
              InkWell(onTap: (){
                setState(() {
                  view=0;
                  colorType=4;
                });
              },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 45,width: 45,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.white,width: 2),
                    color: const Color(0xffD939CD)
                ),
                ),
              ),
              const SizedBox(width: 10,),
              InkWell(onTap: (){
                setState(() {
                  view=0;
                  colorType=3;
                });
              },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 45,width: 45,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.white,width: 2),
                    color: const Color(0xffCA26ff)
                ),
                ),
              ),
              const SizedBox(width: 10,),
              InkWell(onTap: (){
                setState(() {
                  view=0;
                  colorType=2;
                });
              },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 45,width: 45,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.white,width: 2),
                    color: Colors.green
                ),
                ),
              ),
              const SizedBox(width: 10,),
              InkWell(onTap: (){
                setState(() {
                  view=0;
                  colorType=1;
                });
              },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 45,width: 45,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.white,width: 2),
                    color: Colors.red
                ),
                ),
              ),
              const SizedBox(width: 10,),
              InkWell(onTap: (){
                setState(() {
                  view=0;
                });
              },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 45,width: 45,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                    color: Colors.black45
                ),
                  child: const Icon(Icons.close,color: Colors.white,size: 25,),),
              ),








            ],),
        )







      ]),

    );
  }
}
