import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/post_provider.dart';
import '../../utils/custom_extension.dart';
import '../../views/widgets/common_appbar.dart';

class DetailsPage extends StatelessWidget {
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
            : Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(postProvider.selectedPost?.title ?? "",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(postProvider.selectedPost?.body ?? "", style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        );
      }),
    );
  }
}
