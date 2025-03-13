

import 'package:technical_flutter/models/post_model.dart';

import 'comment_model.dart';

class PostFeed {
  final Post post;
  final List<Comment> comments;

  PostFeed({
    required this.post,
    required this.comments,
  });

  factory PostFeed.fromJson(Map<String, dynamic> json) {
    return PostFeed(
      post: Post.fromJson(json['post']),
      comments: (json['comments'] as List)
          .map((comment) => Comment.fromJson(comment))
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
