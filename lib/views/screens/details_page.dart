import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_flutter/services/internet_connection.dart';
import '../../model/post.dart';
import '../../providers/post_provider.dart';
import '../../utils/custom_extension.dart';
import '../../views/widgets/common_appbar.dart';
import '../widgets/comments_section.dart';


class DetailsPage extends StatefulWidget {
  final Post? post;

  DetailsPage({Key? key, this.post,}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
        bool saved = postProvider.isPostSaved(postProvider.selectedPost!);
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
                      backgroundColor: saved ? Colors.green: Colors.white,
                    ),
                    onPressed: () async
                    {
                      if (saved) {
                        InternetConnection.displayToastMessage(context.translate("post_already_saved"));
                      } else {
                        await postProvider.savePostForOffline(postProvider.selectedPost!);
                        InternetConnection.displayToastMessage(context.translate("post_saved_for_offline"));
                      }
                    },
                    child: Row(
                      children: [
                        if(saved)
                        Icon(
                          Icons.check_outlined,
                          size: 20,
                          color: saved ?Colors.white :Colors.deepPurple,
                        ),
                        Text(saved ? context.translate("saved") :  context.translate("save_for_offline"), style: TextStyle(color: saved ?Colors.white :Colors.deepPurple), ),
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
                child: Text(postProvider.showComments ? context.translate("hide_comments") : context.translate("show_comments"), ),
              ),
              const SizedBox(height: 20),
              // Fetching Comments
              CommentsWidget(postProvider:postProvider),
            ],
          ),
        );
      }),
    );
  }
}
