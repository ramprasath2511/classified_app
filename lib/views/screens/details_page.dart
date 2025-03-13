import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/post_model.dart';
import '../../providers/post_provider.dart';
import '../../utils/custom_extension.dart';
import '../../views/widgets/common_appbar.dart';


class DetailsPage extends StatefulWidget {
  final Post? post;

  DetailsPage({
    Key? key,
     this.post,
  }) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print(widget.post);
    if (widget.post != null) {
      Provider.of<PostProvider>(context, listen: false).setSelectedPost(widget.post!);
    }
    Provider.of<PostProvider>(context, listen: false).resetProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
          title: context.translate("postDetails"), showBackButton: true),
      body: Consumer<PostProvider>(builder: (context, postProvider, _){
        return postProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : postProvider.errorMessage != null
            ? Center(child: Text(postProvider.errorMessage!))
            : postProvider.selectedPost == null
            ? Center(child: Text(context.translate("postNotFound")))
            : SingleChildScrollView(
             padding: const EdgeInsets.all(15),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: postProvider.isPostSaved(postProvider.selectedPost!) ? Colors.green: Colors.white,
                    ),
                    onPressed: () async
                    {
                      if (postProvider.isPostSaved(postProvider.selectedPost!)) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Post already saved')));
                      } else {
                        await postProvider.savePostForOffline(postProvider.selectedPost!);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Post saved for offline reading')));
                      }
                    },
                    child: Row(
                      children: [
                        if(postProvider.isPostSaved(postProvider.selectedPost!))
                        Icon(
                          Icons.check_outlined,
                          size: 20,
                          color: postProvider.isPostSaved(postProvider.selectedPost!) ?Colors.white :Colors.deepPurple,
                        ),
                        Text(postProvider.isPostSaved(postProvider.selectedPost!) ? 'Saved' : 'Save for Offline', style: TextStyle(color: postProvider.isPostSaved(postProvider.selectedPost!) ?Colors.white :Colors.deepPurple), ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(postProvider.selectedPost?.title ?? "",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(postProvider.selectedPost?.body ?? "", style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: ()=> postProvider.toggleComments(postProvider.selectedPost!.id),
                child: Text(postProvider.showComments ? "Hide Comments" : "Show Comments", ),
              ),
              const SizedBox(height: 20),
              // Fetching Comments
              if (postProvider.showComments)
                postProvider.commentLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                  children: postProvider.comments.map((comment) {
                    return FadeTransition(
                      opacity: postProvider.showComments ? AlwaysStoppedAnimation(1.0) : AlwaysStoppedAnimation(0.0),
                      child: ListTile(
                        leading:  CircleAvatar(
                          radius: 20,  // Radius for the profile picture
                            child:  const Icon(
                              Icons.person,
                              size: 20,
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                        ),
                        title: Text(comment.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(comment.email, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                            const SizedBox(height: 5),
                            Text(comment.body),  // Comment body
                          ],
                        ),
                        isThreeLine: true,
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        );
      }),
    );
  }
}
