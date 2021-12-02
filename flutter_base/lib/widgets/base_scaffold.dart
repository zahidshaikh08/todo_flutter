import 'package:flutter/material.dart';

import 'widgets.dart';

class BaseScaffold extends StatefulWidget {
  final bool isLeading;
  final bool isAppbar;
  final bool hasBack;
  final dynamic title;
  final Color? backgroundColor;
  final VoidCallback? onLeading;
  final bool? resizeToAvoidBottomInset;
  final Widget? floatingActionButton;

  final Widget child;
  final Widget? leading;
  final List<Widget>? actions;

  final Color? appBarColor;

  final bool applyShape;

  final FloatingActionButtonLocation? fabLocation;

  final TextStyle? titleStyle;
  final Widget? navigationBar;

  const BaseScaffold({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.isLeading = true,
    this.hasBack = false,
    this.title,
    this.actions,
    this.onLeading,
    this.isAppbar = true,
    this.leading,
    this.resizeToAvoidBottomInset,
    this.floatingActionButton,
    this.appBarColor,
    this.applyShape = false,
    this.fabLocation,
    this.titleStyle,
    this.navigationBar,
  }) : super(key: key);

  @override
  _BaseScaffoldState createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: widget.child,
      floatingActionButton: widget.floatingActionButton,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      backgroundColor: widget.backgroundColor ?? Theme.of(context).backgroundColor,
      floatingActionButtonLocation: widget.fabLocation,
      bottomNavigationBar: widget.navigationBar,
    );
  }

  Widget backButton() => BackButton(
        color: Colors.white,
        onPressed: widget.onLeading ?? () => Navigator.of(context).maybePop(),
      );

  AppBar? getAppBar() {
    if (!widget.isAppbar) {
      return null;
    }

    return AppBar(
      centerTitle: true,
      backgroundColor: widget.appBarColor,
      leading: widget.isLeading ? widget.leading ?? backButton() : nil,
      title: widget.title == null
          ? null
          : widget.title is Widget
              ? widget.title
              : Texts(
                  widget.title ?? "",
                  style: widget.titleStyle ??
                      Texts.customTextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                        color: Theme.of(context).textTheme.bodyText2?.color,
                      ),
                ),
      actions: widget.actions,
      shape: widget.applyShape
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18.0),
                bottomRight: Radius.circular(18.0),
              ),
            )
          : null,
    );
  }
}
