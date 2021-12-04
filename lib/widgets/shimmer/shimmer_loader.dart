import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/material.dart' hide RefreshIndicator, RefreshIndicatorState;
import 'package:flutter_base/flutter_base.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ShimmerHeader extends RefreshIndicator {
  final Color baseColor, highlightColor;
  final Widget text;
  final Duration period;

  final Function? outerBuilder;

  const ShimmerHeader({
    prefix0.Key? key,
    required this.text,
    this.baseColor = Colors.grey,
    this.highlightColor = Colors.white,
    this.outerBuilder,
    double height = 80.0,
    this.period = const Duration(milliseconds: 1000),
  }) : super(key: key, height: height, refreshStyle: RefreshStyle.Behind);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ShimmerHeaderState();
  }
}

class _ShimmerHeaderState extends RefreshIndicatorState<ShimmerHeader> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;

  @override
  void initState() {
    // TODO: implement initState
    _scaleController = AnimationController(vsync: this);
    _fadeController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void onOffsetChange(double offset) {
    // TODO: implement onOffsetChange
    if (!floating) {
      _scaleController.value = offset / configuration!.headerTriggerDistance;
      _fadeController.value = offset / configuration!.footerTriggerDistance;
    }
  }

  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    // TODO: implement buildContent

    final Widget body = ScaleTransition(
      scale: _scaleController,
      child: FadeTransition(
        opacity: _fadeController,
        child: mode == RefreshStatus.refreshing
            ? const Texts("Create new item")
            : Center(
                child: widget.text,
              ),
      ),
    );
    return widget.outerBuilder != null
        ? widget.outerBuilder!.call(body)
        : Container(
            alignment: prefix0.Alignment.center,
            child: body,
            decoration: const prefix0.BoxDecoration(color: Colors.black12),
          );
  }
}

class ShimmerFooter extends LoadIndicator {
  final Color baseColor, highlightColor;
  final Widget? text, failed, noMore;
  final Duration period;

  final Function? outerBuilder;

  const ShimmerFooter({
    prefix0.Key? key,
    required this.text,
    this.baseColor = Colors.grey,
    this.highlightColor = Colors.white,
    this.outerBuilder,
    double height = 80.0,
    this.failed,
    this.noMore,
    this.period = const Duration(milliseconds: 1000),
    LoadStyle loadStyle = LoadStyle.ShowAlways,
  }) : super(key: key, height: height, loadStyle: loadStyle);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ShimmerFooterState();
  }
}

class _ShimmerFooterState extends LoadIndicatorState<ShimmerFooter> {
  @override
  Widget buildContent(BuildContext context, LoadStatus mode) {
    // TODO: implement buildContent

    final prefix0.Widget? body = mode == LoadStatus.failed
        ? widget.failed
        : mode == LoadStatus.noMore
            ? widget.noMore
            : mode == LoadStatus.idle
                ? Center(child: widget.text)
                : const NativeLoader.android();
    return widget.outerBuilder != null
        ? widget.outerBuilder!.call(body)
        : Container(
            height: widget.height,
            child: body,
            decoration: const prefix0.BoxDecoration(color: Colors.black12),
          );
  }
}
