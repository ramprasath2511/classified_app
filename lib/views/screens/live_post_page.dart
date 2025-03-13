import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_flutter/utils/custom_extension.dart';
import '../../providers/post_provider.dart';
import '../widgets/default_message_container.dart';
import '../widgets/post_card.dart';

class LivePostsPage extends StatelessWidget {
  const LivePostsPage({super.key});

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      color: Theme.of(context).primaryColor,
      onRefresh: () async => Provider.of<PostProvider>(context, listen: false).fetchPosts(),
      child: Scaffold(
        body: Consumer<PostProvider>(builder: (context, postProvider, _){
          return postProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : postProvider.errorMessage != null
          ? EmptyStateWidget(message: postProvider.errorMessage!)
          : postProvider.posts.isEmpty
          ? EmptyStateWidget(message: context.translate("postNotFound"))
          : ListView.builder(
          itemCount: postProvider.posts.length,
          itemBuilder: (context, index) {
           return PostCard(post: postProvider.posts[index], postProvider: postProvider,);
                    },
                  );
        }),
      ),
    );
  }
}
