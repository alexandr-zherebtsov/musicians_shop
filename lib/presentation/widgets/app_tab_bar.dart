import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/styles/styles.dart';

class AppTabBar extends StatelessWidget {
  final ResponsiveScreen screen;
  final List<Tab> tabs;
  final TabController tabController;

  const AppTabBar({
    required this.screen,
    required this.tabs,
    required this.tabController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: Center(
        child: TabBar(
          tabs: tabs,
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.label,
          indicator: const LineTabIndicator(),
          dividerColor: Colors.transparent,
          splashBorderRadius: BorderRadius.circular(
            AppStyles.clipRadius,
          ),
          padding: screen.isPhone
              ? const EdgeInsets.symmetric(
                  horizontal: 12,
                )
              : const EdgeInsets.only(
                  top: 6,
                  left: 28,
                  right: 28,
                ),
        ),
      ),
    );
  }
}

class LineTabIndicator extends Decoration {
  final BorderSide borderSide;
  final EdgeInsetsGeometry insets;

  const LineTabIndicator({
    this.borderSide = const BorderSide(
      width: 4,
    ),
    this.insets = EdgeInsets.zero,
  });

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is LineTabIndicator) {
      return LineTabIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is LineTabIndicator) {
      return LineTabIndicator(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _UnderlinePainter(this, onChanged);
  }

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);
    return Rect.fromLTWH(
      indicator.left,
      indicator.bottom - borderSide.width,
      indicator.width,
      borderSide.width,
    );
  }

  @override
  Path getClipPath(Rect rect, TextDirection textDirection) {
    return Path()..addRect(_indicatorRectFor(rect, textDirection));
  }
}

class _UnderlinePainter extends BoxPainter {
  final LineTabIndicator decoration;

  _UnderlinePainter(
    this.decoration,
    VoidCallback? onChanged,
  ) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final TextDirection textDirection = configuration.textDirection!;
    final Rect indicator = decoration
        ._indicatorRectFor(rect, textDirection)
        .deflate(decoration.borderSide.width / 2);
    final Paint paint = decoration.borderSide.toPaint()
      ..strokeCap = StrokeCap.round
      ..color = Get.theme.primaryColor
      ..strokeWidth = decoration.borderSide.width;
    canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);
  }
}
