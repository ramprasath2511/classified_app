import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/comment_model.dart';
import '../models/post_model.dart';
import 'internet_connection.dart';

class PostService {

  final http.Client client;

  PostService({http.Client? client}) : client = client ?? http.Client();

  static const String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> fetchPosts() async {
    if (await InternetConnection.checkInternetConnectivity()) {
      final response = await client.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        return body.map((item) => Post.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    }else{
    return [];
    }
  }

  Future<Post> fetchPostById(int id) async {
    if (await InternetConnection.checkInternetConnectivity()) {
      final response = await client.get(Uri.parse('$baseUrl/$id'));
      if (response.statusCode == 200) {
        return Post.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load post');
      }
    }else{
      throw Exception('No Internet');
    }
  }

  Future<List<Comment>> fetchComments({required int postId}) async {
    if (await InternetConnection.checkInternetConnectivity()) {
      try {
        final response = await client.get(
            Uri.parse('$baseUrl/$postId/comments'));
        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          return data.map((comment) => Comment.fromJson(comment)).toList();
        } else {
          throw Exception('Failed to load comments');
        }
      } catch (e) {
        return [];
      }
    }else{
      return [];
    }
  }
}

