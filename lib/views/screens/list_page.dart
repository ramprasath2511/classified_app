import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/post_provider.dart';
import '../../utils/custom_extension.dart';
import '../../views/widgets/common_appbar.dart';
import '../widgets/post_card.dart';
import '../widgets/settings_drawer.dart';

class ListPage extends StatefulWidget {

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (context.mounted) {
      context.read<PostProvider>().fetchPosts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: SettingsDrawer(),
      appBar: CommonAppBar(
        title:context.translate("listOfPosts"),
      ),
      body: Consumer<PostProvider>(builder: (context, postProvider, _){
        return postProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : postProvider.errorMessage != null
            ? Center(child: Text(postProvider.errorMessage!))
            : ListView.builder(
             itemCount: postProvider.posts.length,
             itemBuilder: (context, index) {
               return PostCard(post: postProvider.posts[index], postProvider: postProvider,);
          },
        );
      }),
    );
  }
}
