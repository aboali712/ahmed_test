import 'package:ahmed_test/src/posts/posts_view.dart';
import 'package:flutter/cupertino.dart';

import '../model/coment_model.dart';
import '../model/post_model.dart';

abstract class PostsViewModel extends State<PostsView>{

  static List<PostModel>postModel=[];
  static List<CommentModel>addCommentModel=[];

}