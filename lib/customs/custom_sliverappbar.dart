import "package:flutter/material.dart";
import "package:flutter/src/widgets/framework.dart";

class CustomSliverAppBar extends StatefulWidget {
  final Widget leadingIcon;
  final Widget title;
  final List<Widget> actions;
  final Widget? bottom;
  final FlexibleSpaceBar? flexibleSpaceBar;

  const CustomSliverAppBar(
      {super.key,
      required this.leadingIcon,
      required this.title,
      required this.actions,
      this.bottom,
      this.flexibleSpaceBar});

  @override
  @override
  State<CustomSliverAppBar> createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<CustomSliverAppBar> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: _pinned,
      floating: _floating,
      delegate: _SliverAppBarDelegate(
        leadingIcon: widget.leadingIcon,
        title: widget.title,
        actions: widget.actions,
        bottom: widget.bottom ?? null,
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget leadingIcon;
  final Widget title;
  final List<Widget> actions;
  final Widget? bottom;
  final FlexibleSpaceBar? flexibleSpaceBar;

  _SliverAppBarDelegate(
      {required this.leadingIcon,
      required this.title,
      required this.actions,
      this.bottom,
      this.flexibleSpaceBar});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: leadingIcon,
      title: overlapsContent ? bottom : title,
      actions: actions,
      flexibleSpace: flexibleSpaceBar,
    );
  }

  @override
  double get maxExtent =>
      kToolbarHeight + (bottom as PreferredSizeWidget).preferredSize.height;

  @override
  double get minExtent => kToolbarHeight + 25;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
