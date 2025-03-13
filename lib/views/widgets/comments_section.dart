import 'package:flutter/material.dart';
import 'package:technical_flutter/providers/post_provider.dart'; // Adjust the import to your actual provider

class CommentsWidget extends StatelessWidget {
  final PostProvider postProvider;
  const CommentsWidget({super.key, required this.postProvider});

  @override
  Widget build(BuildContext context) {
    if (!postProvider.showComments) {
      return const SizedBox.shrink();
    }
    return postProvider.commentLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
      children: postProvider.comments.map((comment) {
        return FadeTransition(
          opacity: postProvider.showComments
              ? const AlwaysStoppedAnimation(1.0)
              : const AlwaysStoppedAnimation(0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.person,
                size: 20,
                color: Colors.white,
              ),
            ),
            title: Text(comment.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.email,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 5),
                Text(comment.body),
              ],
            ),
            isThreeLine: true,
          ),
        );
      }).toList(),
    );
  }
}
