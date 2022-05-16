import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/presentation/ui/posts/posts_controller.dart';
import 'package:musicians_shop/shared/core/localization/keys.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> with TickerProviderStateMixin {
  late final TabController tabController;

  final List<Tab> tabs = <Tab>[
    Tab(text: StringsKeys.my.tr),
    Tab(text: StringsKeys.liked.tr),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: tabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostsController>(
      init: PostsController(),
      builder: (PostsController controller) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: 45,
              width: double.infinity,
              child: Center(
                child: TabBar(
                  tabs: tabs,
                  controller: tabController,
                  indicatorSize: TabBarIndicatorSize.label,
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const <Widget>[
                   Center(
                    child: Text(
                      'My',
                    ),
                  ),
                  Center(
                    child: Text(
                      'Liked',
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
