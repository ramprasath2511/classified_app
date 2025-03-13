import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/comment_model.dart';
import '../models/post_model.dart';

class PostService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((item) => Post.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<Post> fetchPostById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<List<Comment>> fetchComments({required int postId}) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$postId/comments'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((comment) => Comment.fromJson(comment)).toList();
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (e) {
      print('Error fetching comments: $e');
      return [];
    }
  }
}

