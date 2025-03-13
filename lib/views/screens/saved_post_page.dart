import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/post_provider.dart';
import '../widgets/post_card.dart';

class SavedPostsPage extends StatelessWidget {
  const SavedPostsPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Consumer<PostProvider>(
        builder: (context, postProvider, _) {
          if (postProvider.savedPostFeed.isEmpty) {
            return Center(child: Text('No saved posts'));
          }
          return ListView.builder(
            itemCount: postProvider.savedPostFeed.length,
            itemBuilder: (context, index) {
              return PostCard(post: postProvider.savedPostFeed[index].post, postProvider: postProvider, isSaved: true,);
            },
          );
        },
      ),
    );
  }
}
