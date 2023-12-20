import 'package:ahmed_test/src/add_post/add_post_view.dart';
import 'package:ahmed_test/src/posts/posts_viewmodel.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../post_details/post_details_view.dart';
import '../post_details/post_details_viewmodel.dart';

class PostsView extends StatefulWidget {
  const PostsView({Key? key}) : super(key: key);

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends PostsViewModel {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top, SystemUiOverlay.bottom
    ]);
    return Scaffold(
      backgroundColor: Colors.white,
      body:


      Stack(
        children: [
          SizedBox(height: size.height,),

          Column(children: [
          const SizedBox(height: 40,),
          Container(height: 65,width: size.width,
          padding: const EdgeInsets.all(15),
          decoration:  BoxDecoration(color: Colors.grey.shade100),
          child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
            const SizedBox(width: 50,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const Icon(Icons.location_on,color: Colors.orange,size: 18,),
              const SizedBox(width: 5,),
              Text("AL Hay Al Asher",style: GoogleFonts.tajawal(fontWeight: FontWeight.bold,fontSize: 14,
              color: Colors.black54
              ),),

              const Icon(Icons.arrow_drop_down_sharp,color: Colors.black54,size: 20,),

            ],),

              Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("+114",style: GoogleFonts.tajawal(fontWeight: FontWeight.bold,fontSize: 14,
                    color: Colors.black54
                            ),),

                  Text("MY KARMA",style: GoogleFonts.tajawal(fontWeight: FontWeight.bold,fontSize: 6,
                      color: Colors.orange
                  ),),
                ],
              ),
          ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Column(children: [

                  PostsViewModel.postModel.isNotEmpty?
                  Column(children:

                  PostsViewModel.postModel.map((e) =>

                      GestureDetector(
                        onLongPress: e.image!=null?(){

                          final imageProvider = Image.file(e.image!).image;
                          showImageViewer(context, imageProvider, onViewerDismissed: () {
                            print("dismissed");
                          });
                        } :(){},

                        onTap: () {
                        setState(() {
                          PostDetailsViewModel.postModel=e;
                        });

                        Navigator.push(context, MaterialPageRoute(builder: (context) => const PostDetailsView(),));

                      },
                        child: Container(width: size.width,
                                          padding: const EdgeInsets.only(top: 15,bottom: 15,left: 20,right: 20),
                                          margin: const EdgeInsets.only(top: 5,bottom: 5)

                                          ,decoration: BoxDecoration(
                          color:
                          e.audio!=null||e.video!=null||e.image!=null?
                              Colors.black26
                         : e.color==5?
                          Colors.blue
                              :e.color==4?
                          const Color(0xffD939CD)
                              :e.color==3?
                          const Color(0xffCA26ff)
                              :e.color==2?
                          Colors.green
                              : Colors.orange,
                          borderRadius: BorderRadius.circular(10)),
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
                            e.audio!=null||e.video!=null||e.image!=null?
                                CrossAxisAlignment.center
                            :CrossAxisAlignment.start,
                              children: [

                                e.audio!=null||e.video!=null||e.image!=null?

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
                                const Icon(Icons.message_rounded,color: Colors.white,size: 18,),
                                const SizedBox(width: 3,),
                                Text(PostsViewModel.addCommentModel.where((element) =>
                                element.id==e.id).toList().length.toString(),style: GoogleFonts.tajawal(
                                    fontWeight: FontWeight.w500,fontSize: 12,
                                    color: Colors.white
                                ),),
                              ],
                            ),
                            const SizedBox(width: 20,),


                          ],)


                                          ]), ),
                      )  ).toList(),)
                  :const SizedBox.shrink(),









                ],),
              ),
            ),
          )


            ]),


          Positioned(bottom: 20,left: 155,
            child: InkWell(onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPostView(),));
            },
              child: Container(height: 65,width: 65,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                  color:Colors.black38 ,border: Border.all(width: 5,color: Colors.white),),
                child: const Center(child: Icon(Icons.add,color: Colors.white,size: 35,)),
              ),
            ),
          )




      ]),);
  }
}
