import 'package:flutter/material.dart';
import '../../models/post_model.dart';
import 'package:provider/provider.dart';
import '../../providers/post_provider.dart';
import '../../routes/app_routes_constants.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final PostProvider postProvider;

  const PostCard({super.key, required this.post, required this.postProvider});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          await postProvider.fetchPostById(post.id);
          print("comming here" );
            Navigator.of(context).pushNamed(details);
        },
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
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () async {
                      await postProvider.fetchPostById(post.id);
                      if (context.mounted) {
                        Navigator.of(context).pushNamed(details);
                      }
                    },
                    icon: const Icon(Icons.arrow_forward_ios, size: 16),
                    label: const Text("View Details"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
