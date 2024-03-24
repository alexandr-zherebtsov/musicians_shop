import 'package:flutter/material.dart';
import 'package:musicians_shop/presentation/widgets/app_back_button.dart';
import 'package:musicians_shop/presentation/widgets/divider_widget.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? back;
  final List<IconButton>? actions;
  final bool bottomDivider;

  const AppBarWidget({
    required this.title,
    this.back,
    this.actions,
    this.bottomDivider = true,
    super.key,
  });

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: widget.back == null
          ? null
          : AppBackButton(
              back: widget.back,
            ),
      title: Text(widget.title),
      actions: widget.actions,
      bottom: widget.bottomDivider
          ? const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: DividerWidget(),
            )
          : const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: SizedBox(
                height: 1,
              ),
            ),
    );
  }
}
