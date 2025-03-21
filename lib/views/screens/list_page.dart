import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_flutter/views/screens/saved_post_page.dart';
import '../../providers/post_provider.dart';
import '../../utils/custom_extension.dart';
import '../../views/widgets/common_appbar.dart';
import '../widgets/settings_drawer.dart';
import 'live_post_page.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> with SingleTickerProviderStateMixin  {

  TabController? tabController;

  @override
  void initState() {
    super.initState();
        Provider.of<PostProvider>(context, listen: false).fetchPosts(listen: false);
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: SettingsDrawer(),
      appBar: CommonAppBar(
        title:context.translate("listOfPosts"),
      ),
      body: Column(
        children: [
          customTabBar(context),
          Expanded(
            child: TabBarView(
              controller: tabController,
                children: [
                  LivePostsPage(),
                  SavedPostsPage()
                  ]
            ),
          ),
        ],
      ),
      );

  }
  Row customTabBar(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 24),
        customTab(context.translate("live_posts"), 0, context, "tab1"),
        const SizedBox(width: 24),
        customTab(context.translate("saved_post"), 1, context, "tab2"),
        const SizedBox(width: 24),
      ],
    );
  }

  Expanded customTab(String label, int index, BuildContext context, String widgetKey) {
    return Expanded(
        child: InkWell(
          key: Key(widgetKey),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                label, style: TextStyle(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 4),
              Divider(
                height: 2,
                thickness: 2,
                color: (index == tabController!.index)
                    ? Colors.green
                    : Theme.of(context).splashColor,
              ),
            ],
          ),
          onTap: () => setState(() => tabController!.animateTo(index)),
        ));
  }
}
