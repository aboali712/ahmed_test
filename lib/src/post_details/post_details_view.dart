import 'package:ahmed_test/src/post_details/post_details_viewmodel.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_collection_previewer/enums.dart';
import 'package:media_collection_previewer/media_collection.dart';
import 'package:media_collection_previewer/models/media.dart';
import 'package:media_collection_previewer/models/theme.dart';
import 'package:social_media_recorder/audio_encoder_type.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';
import 'package:video_player/video_player.dart';

import '../../core/help.dart';
import '../posts/posts_viewmodel.dart';

class PostDetailsView extends StatefulWidget {
  const PostDetailsView({Key? key}) : super(key: key);

  @override
  State<PostDetailsView> createState() => _PostDetailsViewState();
}

class _PostDetailsViewState extends PostDetailsViewModel {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top, SystemUiOverlay.bottom
    ]);
    return Scaffold(

      backgroundColor:
      PostDetailsViewModel.postModel!.color==5?
      Colors.blue
          :PostDetailsViewModel.postModel!.color==4?
      const Color(0xffD939CD)
          :PostDetailsViewModel.postModel!.color==3?
      const Color(0xffCA26ff)
          :PostDetailsViewModel.postModel!.color==2?
      Colors.green
          : Colors.orange,

      body: Stack(
        children: [


          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 30,),
              Container(height: 65,width: size.width,
                padding: const EdgeInsets.only(top: 7,bottom: 7,left: 15,right: 15),
                decoration:  const BoxDecoration(color: Colors.white),
                child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_outlined,color: Colors.black54,size: 20,)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(elevation: 2,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              padding: const EdgeInsets.all(7),
                              height: 35,width: 35,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                                color: Colors.white
                            ),
                              child: Image.asset("assets/images/rocket.png",color: Colors.black54,),),
                          ),
                          const SizedBox(width: 5,),
                          Text("1",style: GoogleFonts.tajawal(
                              fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black54
                          ),),


                          const SizedBox(width: 5,),
                          Card(elevation: 2,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              padding: const EdgeInsets.all(7),
                              height: 35,width: 35,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                                color: Colors.white
                            ),
                              child:  const Icon(Icons.share,color: Colors.black54,size: 20,),),
                          ),
                          const SizedBox(width: 10,),
                          Card(elevation: 2,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              padding: const EdgeInsets.all(7),
                              height: 35,width: 35,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                                color: Colors.white
                            ),
                              child:  const Icon(Icons.android_sharp,color: Colors.black54,size: 20,),),
                          ),

                        ],),


                    ]),
              ),



            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  GestureDetector(onLongPress: details!.image!=null?(){

                    final imageProvider = Image.file(details!.image!).image;
                    showImageViewer(context, imageProvider, onViewerDismissed: () {
                      print("dismissed");
                    });
                  } :(){},
                    child: Container(width: size.width,
                      padding: const EdgeInsets.only(top: 15,bottom: 15,left: 20,right: 20),
                      margin: const EdgeInsets.only(top: 5,bottom: 5)

                      ,decoration: BoxDecoration(
                        color:
                        details!.audio!=null||details!.video!=null||details!.image!=null?
                        Colors.black26
                            : details!.color==5?
                        Colors.blue
                            :details!.color==4?
                        const Color(0xffD939CD)
                            :details!.color==3?
                        const Color(0xffCA26ff)
                            :details!.color==2?
                        Colors.green
                            : Colors.orange,
                      ),
                      child: Column(children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(crossAxisAlignment: CrossAxisAlignment.end,
                              children: [

                                Container(height: 20,
                                  padding: const EdgeInsets.all(3),decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),color: Colors.black12),
                                  child: Text("@main",style: GoogleFonts.tajawal(
                                      fontSize: 11,fontWeight: FontWeight.bold,color: Colors.white
                                  ),),),
                                const SizedBox(width: 10,),
                                const Icon(Icons.home,color: Colors.white,size: 18,),
                                const SizedBox(width: 5,),
                                Text("القاهرة",style: GoogleFonts.tajawal(
                                    fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white
                                ),),


                                const SizedBox(width: 5,),
                                Text(". 7min",style: GoogleFonts.tajawal(
                                    fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white
                                ),)



                              ],),

                            const Icon(Icons.more_horiz,color: Colors.white,size: 18,)
                          ],),
                        const SizedBox(height: 20,),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 20,),
                            Row(crossAxisAlignment:
                            details!.audio!=null||details!.video!=null||details!.image!=null?
                            CrossAxisAlignment.center
                                :CrossAxisAlignment.start,
                              children: [

                                details!.audio!=null||details!.video!=null||details!.image!=null?

                                SizedBox(width: 230,
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    "Hold to view",style: GoogleFonts.tajawal(
                                      fontWeight: FontWeight.w500,fontSize: 16,
                                      color: Colors.white
                                  ),),
                                )

                                    :  SizedBox(width: 230,
                                  child: Text(
                                    textAlign: TextAlign.end,
                                    details!.text??"",style: GoogleFonts.tajawal(
                                      fontWeight: FontWeight.w500,fontSize: 13,
                                      color: Colors.white
                                  ),),
                                ),
                                const SizedBox(width: 15,),
                                Column(
                                  children: [
                                    Image.asset("assets/images/toparrow.png",color: Colors.white,height: 25,),

                                    Text("2",style: GoogleFonts.tajawal(
                                        fontWeight: FontWeight.bold,fontSize: 15,
                                        color: Colors.white
                                    ),),
                                    Image.asset("assets/images/downarrow.png",color: Colors.white,height: 25,),


                                  ],)

                              ],)

                          ],),




                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.message_rounded,color: Colors.white,size: 18,),
                                const SizedBox(width: 3,),
                                Text(PostsViewModel.addCommentModel.where((element) =>
                                element.id==postId).toList().length.toString(),style: GoogleFonts.tajawal(
                                    fontWeight: FontWeight.w500,fontSize: 12,
                                    color: Colors.white
                                ),),
                              ],
                            ),
                            const SizedBox(width: 20,),


                          ],)


                      ]), ),
                  ),
                  Container(height: 3,width: size.width,color: Colors.white,),

                  Column(children: PostsViewModel.addCommentModel.where((element) => element.id==postId).toList()
                      .map((e) => GestureDetector(

                    child: Container(width: size.width,
                      padding: const EdgeInsets.only(top: 15,bottom: 15,left: 20,right: 20),
                      margin: const EdgeInsets.only(top: 5,bottom: 5)

                      ,decoration: const BoxDecoration(
                        color : Colors.transparent,
                      ),
                      child: Column(children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(crossAxisAlignment: CrossAxisAlignment.end,
                              children: [

                                Text("1",style: GoogleFonts.tajawal(
                                    fontSize: 11,fontWeight: FontWeight.bold,color: Colors.white
                                ),),
                                const SizedBox(width: 5,),
                                const Icon(Icons.location_on,color: Colors.white,size: 10),
                                const SizedBox(width: 5,),
                                Text("far",style: GoogleFonts.tajawal(
                                    fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white
                                ),),


                                const SizedBox(width: 5,),
                                Text(". 7min",style: GoogleFonts.tajawal(
                                    fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white
                                ),),
                                const SizedBox(width: 10,),

                                e.audio!=null?
                                Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      GestureDetector(
                                        onTap: () {

                                          audioController.onPressedPlayButton(int.parse(e.recordId.toString()) , e.audio);
                                          // changeProg(duration: duration);
                                        },
                                        onSecondaryTap: () {

                                          audioPlayer.stop();
                                          //   audioController.completedPercentage.value = 0.0;
                                        },
                                        child: Obx(
                                              () => (audioController.isRecordPlaying &&
                                              audioController.currentId == int.parse(e.recordId.toString()))
                                              ? const Icon(
                                            Icons.cancel,size: 20,
                                            color:  Colors.white ,
                                          )
                                              : const Icon(
                                            Icons.play_arrow,size: 20,
                                            color:  Colors.black,
                                          ),
                                        ),
                                      ),
                                      Obx(
                                            () => SizedBox(

                                          width: 60,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
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
                                                      audioController.currentId == int.parse(e.recordId.toString()))
                                                      ? audioController.completedPercentage.value
                                                      : audioController.totalDuration.value.toDouble(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 1,
                                      ),
                                      Text(
                                        audioController.total.toString(),
                                        style: const TextStyle(
                                            fontSize: 10, color:
                                        Colors.black ),
                                      ),

                                    ])
                                    :const SizedBox.shrink(),

                                e.image!=null?
                                GestureDetector(onTap: (){
                                  final imageProvider = Image.file(e.image!).image;
                                  showImageViewer(context, imageProvider, onViewerDismissed: () {
                                    print("dismissed");
                                  });
                                },
                                  child: const Row(children: [
                                    SizedBox(width: 10,),
                                    Icon(Icons.image,color: Colors.white,size: 18,)
                                  ],),
                                )
                                    :const SizedBox.shrink(),


                                e.video!=null?

                                  Builder(
                                    builder: (context) {

                                      final medias = [
                                         Media(
                                            id: 1,
                                            type: MediaType.video,
                                            url:
                                            e.video!.path.toString()),

                                      ];

                                      return Row(children: [
                                        const SizedBox(width: 10,),

                                        SizedBox(height: 30,width: 30,
                                          child: MediaCollection(
                                            medias: medias,
                                            theme: const MediaCollectionTheme(
                                              arrowColor: Colors.white,
                                              arrowBgColor: Colors.black,
                                              playIconBgColor: Colors.black,
                                              playIconBgSize: 50,
                                              playIconSize: 20,
                                              audioIconBgColor: Colors.black,
                                              audioIconBgSize: 50,
                                              audioIconColor: Colors.white,
                                              audioIconSize: 20,
                                              audioPlayerBgColor: Colors.black,
                                              dividerWidth: 2.5,
                                              mainItemHeight: 20,
                                              subItemHeight: 98.25,
                                            ),
                                          ),
                                        ),

                                      ],);
                                    }
                                  )

                                    :const SizedBox.shrink(),






                              ],),

                            const Icon(Icons.more_horiz,color: Colors.white,size: 18,)
                          ],),
                        const SizedBox(height: 20,),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 20,),
                            Row(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                SizedBox(width: 230,
                                  child: Text(
                                    textAlign: TextAlign.end,
                                    e.text??"",style: GoogleFonts.tajawal(
                                      fontWeight: FontWeight.w500,fontSize: 13,
                                      color: Colors.white
                                  ),),
                                ),
                                const SizedBox(width: 15,),
                                Column(
                                  children: [
                                    Image.asset("assets/images/toparrow.png",color: Colors.white,height: 25,),

                                    Text("2",style: GoogleFonts.tajawal(
                                        fontWeight: FontWeight.bold,fontSize: 15,
                                        color: Colors.white
                                    ),),
                                    Image.asset("assets/images/downarrow.png",color: Colors.white,height: 25,),


                                  ],)

                              ],)

                          ],),




                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                                        color:Colors.white30 ),
                                    child: Image.asset("assets/images/fox.png",height: 23,)),
                               
                              ],
                            ),
                            const SizedBox(width: 20,),


                          ],)


                      ]), ),
                  ),).toList(),),
                  const SizedBox(height: 100,),



                ],),
              ),
            )




          //     details!.image != null
          //     ? Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: GestureDetector(onLongPress: (){
          //     final imageProvider = Image.file(details!.image!).image;
          //     showImageViewer(context, imageProvider, onViewerDismissed: () {
          //       print("dismissed");
          //     });
          //   },onTap: (){
          //
          //   },
          //     child: ClipRRect(
          //       borderRadius: BorderRadius.circular(15),
          //       child: Image.file(
          //         PostDetailsViewModel.postModel!.image!,
          //         height: 230,
          //         width: size.width,
          //         fit: BoxFit.fill,
          //       ),
          //     ),
          //   ),
          // )
          //     : details!.video != null?
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const SizedBox(height: 10,),
          //       TextButton(
          //           style: TextButton.styleFrom(
          //               fixedSize: const Size(120, 45),
          //
          //               shape: RoundedRectangleBorder(
          //                   borderRadius:
          //                   BorderRadius.circular(10.0),
          //                   side: const BorderSide(
          //                       color: Colors.white)),
          //               backgroundColor: Colors.white),
          //           onPressed: () {
          //             setStatePlayVideo(controller!);
          //
          //           }, child: Text(
          //         controller!.value.isPlaying ?
          //         tr("Stop")
          //             :tr("Play")
          //         ,style: GoogleFonts.tajawal(color: Colors.black,fontSize: 15,
          //           fontWeight:FontWeight.w500 ),)),
          //       const SizedBox(height: 10,),
          //
          //
          //       Stack(
          //           children: [
          //             Container(height: 250,width: size.width,
          //
          //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(0),
          //                   border:Border.all(color: const Color(0xffA8A8A8)) ),
          //               child: AspectRatio(
          //                 aspectRatio: controller!.value.aspectRatio,
          //                 child: VideoPlayer(controller!),
          //               ),
          //             ),
          //             Positioned(height: 230,left: 160,
          //               child: Icon(
          //                 controller!.value.isPlaying ?
          //                 Icons.pause : Icons.play_arrow,color: Colors.white,size: 35,
          //               ),
          //             ),
          //           ]),
          //       const SizedBox(height: 70,),
          //
          //     ],
          //   ),
          // )
          //     : const SizedBox.shrink(),
          //
          //
          //
          //     details!.audio!=null?
          // Container(
          //   height:100,width: size.width,
          //   child: Row(mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //
          //       GestureDetector(
          //         onTap: () {
          //           print(details!.audio);
          //           audioController.onPressedPlayButton(0, details!.audio.toString());
          //           // changeProg(duration: duration);
          //         },
          //         onSecondaryTap: () {
          //
          //           audioPlayer.stop();
          //           //   audioController.completedPercentage.value = 0.0;
          //         },
          //         child: Obx(
          //               () => (audioController.isRecordPlaying &&
          //               audioController.currentId == 0)
          //               ? const Icon(
          //             Icons.cancel,
          //             color:  Colors.white ,
          //           )
          //               : const Icon(
          //             Icons.play_arrow,
          //             color:  Colors.black,
          //           ),
          //         ),
          //       ),
          //       Obx(
          //             () => SizedBox(
          //
          //           width: 220,
          //           child: Padding(
          //             padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          //             child: Stack(
          //               clipBehavior: Clip.none,
          //               alignment: Alignment.center,
          //               children: [
          //
          //                 LinearProgressIndicator(
          //                   minHeight: 5,
          //                   backgroundColor: Colors.grey,
          //                   valueColor: const AlwaysStoppedAnimation<Color>(
          //                     Colors.white,
          //                   ),
          //                   value: (audioController.isRecordPlaying &&
          //                       audioController.currentId == 0)
          //                       ? audioController.completedPercentage.value
          //                       : audioController.totalDuration.value.toDouble(),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //       const SizedBox(
          //         width: 5,
          //       ),
          //       Text(
          //         audioController.total.toString(),
          //         style: const TextStyle(
          //             fontSize: 12, color:
          //         Colors.black ),
          //       ),
          //
          //       const SizedBox(
          //         width: 10,
          //       ),
          //
          //
          //
          //
          //     ],
          //   ),)
          // :const SizedBox.shrink() ,
          // const SizedBox(height: 30,),


                  ]),


          Positioned(
              bottom: 0,left: 0,right: 0,
              child: Container(height: 70,width: size.width,color: Colors.white,
                padding:  EdgeInsets.all(viewRecord==1?0:10),
                child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      viewRecord==1?
                          const SizedBox.shrink()
                  : SizedBox(height: 50,width: size.width-160,
                    child: TextFormField(
                      controller: valueControl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(fontSize: 15,color: Colors.black),

                      decoration: InputDecoration(
                        hintText: tr("Jodel back here..."),
                        hintStyle:  GoogleFonts.tajawal(
                            fontSize: 15,fontWeight: FontWeight.w400,
                            color: Colors.black54),

                        errorStyle: const TextStyle(color: Colors.orange),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),

                        filled: true,

                        fillColor:  Colors.transparent,
                        focusedBorder: const UnderlineInputBorder(

                          borderSide: BorderSide(width: 2, color: Colors.orange,),
                        ),
                        disabledBorder: const UnderlineInputBorder(

                          borderSide:
                          BorderSide(width: 2, color: Colors.orange),
                        ),
                        enabledBorder: const UnderlineInputBorder(

                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.orange,
                          ),
                        ),
                        border: const UnderlineInputBorder(

                            borderSide: BorderSide(
                              width: 2,
                            )),
                        errorBorder: const UnderlineInputBorder(
                            borderSide:
                            BorderSide(width: 2, color: Colors.orange)),
                        focusedErrorBorder: const UnderlineInputBorder(

                            borderSide:
                            BorderSide(width: 2, color: Colors.orange)),

                      ),
                      onChanged: (value) {
                        if (value.isEmpty ||
                            value == null ||
                            !InputValidators().nameValidator(
                                name:  value, context: context)) {
                          setState(() {
                            isValue= true;
                            valueText = value;
                          });
                        } else {
                          setState(() {
                            isValue = false;
                            valueText = value;
                          });
                        }
                      },
                      onSaved: (value) {
                        valueText = value ?? "";
                      },

                      cursorColor: Colors.orange,
                      keyboardType: TextInputType.text,
                    ),
                  ),



                  Row(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                    viewRecord==1?
                    const SizedBox.shrink()
                        : InkWell(onTap: () {
                     openExplorer();
                    },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        height: 40,width: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                          color: Colors.black45
                      ),
                        child: const Icon(Icons.camera_alt_rounded,color: Colors.white,size: 25,),),
                    ),


                    SizedBox(width:viewRecord==1?0: 5,),

                    SocialMediaRecorder(
                      backGroundColor: Colors.black45,
                      initRecordPackageWidth: 40,
                      fullRecordPackageHeight: 40,
                      radius: BorderRadius.circular(50),
                      startRecording: () {

                        audioController.start.value = DateTime.now();
                     startRecord();
                        setState(() {
                          viewRecord=1;
                        });
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

                      SizedBox(width:viewRecord==1?0: 5,),






                  ],),


                      valueText==""&&compressedMainImage==null&&videoPath==null&&recordFilePath==null?
                           SizedBox(width:viewRecord==1?0: 30,)
                   :   viewRecord==1?
                      const SizedBox.shrink()
                    :  RawMaterialButton(
                        onPressed: () {
                          addComment();

                        }, //do your action
                        elevation: 1.0,
                        constraints: BoxConstraints(), //removes empty spaces around of icon
                        shape: CircleBorder(), //circular button
                        fillColor: Colors.white, //background color
                        splashColor: Colors.grey,
                        highlightColor: Colors.grey,
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.send,color: Colors.blue,size: 25,),
                      ),


                ]) ,))



      ]),

    );
  }
}
