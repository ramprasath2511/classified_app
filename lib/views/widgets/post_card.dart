import 'package:flutter/material.dart';
import 'package:technical_flutter/main.dart';
import '../../models/post_model.dart';
import '../../providers/post_provider.dart';
import '../../routes/app_routes_constants.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final PostProvider postProvider;
  final bool isSaved;

  const PostCard({super.key, required this.post, required this.postProvider, this.isSaved = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
            onTap: () => navigateToNextScreen(),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      post.body,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                         postProvider.isPostSaved(post) && !isSaved
                          ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding:  const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_outlined,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    Text( 'Saved in Offline', style: TextStyle(color: Colors.white), ),
                                  ],
                                ),
                              ),
                            ],
                          )
                           : Container(),
                        if(isSaved)
                          TextButton.icon(
                            onPressed: () async => await postProvider.removePost(post),
                            icon: const Icon(Icons.delete_outline, size: 16, color: Colors.red,),
                            label: const Text( 'Delete', style: TextStyle(color: Colors.red),
                          ),
                                                      ),
                         TextButton.icon(
                           onPressed: () => navigateToNextScreen(),
                           icon: const Icon(Icons.arrow_forward_ios, size: 16),
                           label: const Text("View Details"),
                         ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
  Future<void> navigateToNextScreen() async {
    if(isSaved){
      Navigator.of(navigatorKey.currentContext!).pushNamed(details, arguments: {'post': post}, );
    }else {
      await postProvider.fetchPostById(post.id);
      Navigator.of(navigatorKey.currentContext!).pushNamed(details);
    }
  }
}
