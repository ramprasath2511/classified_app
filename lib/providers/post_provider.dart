import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/post_service.dart';

class PostProvider with ChangeNotifier {
  final PostService _postService = PostService();

  List<Post> _posts = [];
  Post? _selectedPost;
  bool _isLoading = false;
  String? _errorMessage;

  List<Post> get posts => _posts;
  Post? get selectedPost => _selectedPost;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPosts() async {
    isLoadingCall(true);
    _errorMessage = null;
    try {
      _posts = await _postService.fetchPosts();
    } catch (e) {
      _errorMessage = 'Failed to load posts: $e';
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
      _errorMessage = 'Failed to load post: $e';
    } finally {
      isLoadingCall(false);
    }
  }

  isLoadingCall(bool value){
    _isLoading = value;
    notifyListeners();
  }
}
