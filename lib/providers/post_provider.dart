import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/post_feed.dart';
import '../model/comments.dart';
import '../model/post.dart';
import '../services/post_service.dart';

class PostProvider with ChangeNotifier {
  final PostService _postService = PostService();

  List<Post> _posts = [];
  Post? _selectedPost;
  bool _isLoading = false;
  String? _errorMessage;
  List<PostFeed> _savedPostFeed = [];
  List<Post> get posts => _posts;
  Post? get selectedPost => _selectedPost;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Comments> _comments = [];
  List<Comments> get comments => _comments;
  List<PostFeed> get savedPostFeed => _savedPostFeed;


  Future<void> fetchPosts({bool listen= false}) async {
    isLoadingCall(true, listen: false);
    _errorMessage = null;
    try {
      _posts = await _postService.fetchPosts();
    } catch (e) {
      _errorMessage = 'Failed to load posts: Please check your Internet';
    } finally {
      isLoadingCall(false);
    }
  }

  Future<void> fetchPostById(int id) async {
    isLoadingCall(true);
    _errorMessage = null;
    try {
      _selectedPost = await _postService.fetchPostById(id);
    } catch (e) {
      _errorMessage = 'Failed to load post: Please check your Internet';
    } finally {
      isLoadingCall(false);
    }
  }

  bool showComments = false;
  bool commentLoading = false;

  Future<void> toggleComments(int id) async {
    showComments = !showComments;
    if (!showComments) {
      notifyListeners();
      return;
    }
    commentLoading = true;
    notifyListeners();
    PostFeed? savedPost;
    try {
      savedPost = _savedPostFeed.firstWhere((post) => post.post.id == id);
    } catch (e) {
      savedPost = null;
    }
    if (savedPost != null && savedPost.comments.isNotEmpty) {
      _comments = savedPost.comments;
    } else {
      _comments = await _postService.fetchComments(postId: id);
    }
    commentLoading = false;
    notifyListeners();
  }

  Future<void> savePostForOffline(Post post) async {
    final prefs = await SharedPreferences.getInstance();
    List<Comments> postComments = await _postService.fetchComments(postId:post.id);
    PostFeed postFeed = PostFeed(post: post, comments: postComments);
    _savedPostFeed.add(postFeed);
    List<String> savedOrdersJson =
    _savedPostFeed.map((o) => json.encode(o.toJson())).toList();
    prefs.setStringList("saved_orders", savedOrdersJson);
    notifyListeners();
  }

  // Load saved posts for offline reading
  Future<void> loadSavedPosts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedOrdersJson = prefs.getStringList("saved_orders");

    if (savedOrdersJson != null) {
      _savedPostFeed = savedOrdersJson
          .map((orderJson) => PostFeed.fromJson(json.decode(orderJson)))
          .toList();
    }
    notifyListeners();
  }

  Future<void> removePost(Post post) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _savedPostFeed.removeWhere((order) => order.post.id == post.id);
    List<String> savedOrdersJson =
    _savedPostFeed.map((o) => json.encode(o.toJson())).toList();
    prefs.setStringList("saved_orders", savedOrdersJson);
    notifyListeners();
  }

  bool isPostSaved(Post post) {
    return _savedPostFeed.any((savedPost) => savedPost.post.id == post.id);
  }

  void setSelectedPost(Post post) {
    _selectedPost = post;
    _errorMessage = null;
  }

  void resetProvider(){
    showComments = false;
  }

  isLoadingCall(bool value, {listen=true}){
    _isLoading = value;
    if(listen) {
      notifyListeners();
    }
  }
}
