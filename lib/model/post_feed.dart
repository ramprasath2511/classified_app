

import 'package:technical_flutter/model/post.dart';

import 'comments.dart';

class PostFeed {
  final Post post;
  final List<Comments> comments;

  PostFeed({
    required this.post,
    required this.comments,
  });

  factory PostFeed.fromJson(Map<String, dynamic> json) {
    return PostFeed(
      post: Post.fromJson(json['post']),
      comments: (json['comments'] as List)
          .map((comment) => Comments.fromJson(comment))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'post': post.toJson(),
      'comments': comments.map((comment) => comment.toJson()).toList(),
    };
  }
}
