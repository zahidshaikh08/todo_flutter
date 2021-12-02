import 'package:flutter/material.dart';

class PageIndicators extends StatelessWidget {
  final List indicatorsList;
  final int index;
  final Color? activeColor;
  final Color? inActiveColor;
  final Color? borderColor;
  final double size;
  final double thickness;
  final bool isFill;
  final bool isScale;

  const PageIndicators({
    Key? key,
    required this.indicatorsList,
    required this.index,
    this.activeColor,
    this.inActiveColor,
    this.borderColor,
    this.size = 13,
    this.thickness = 2.5,
    this.isFill = false,
    this.isScale = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size + 2,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int i = 0; i < indicatorsList.length; i++)
            if (i == index) ...[circleBar(context, true)] else circleBar(context, false),
        ],
      ),
    );
  }

  Widget circleBar(BuildContext context, bool isActive) {
    final primary = Theme.of(context).primaryColor;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: isScale
          ? isActive
              ? size
              : (size / 2) + 0.5
          : size,
      width: isScale
          ? isActive
              ? size
              : (size / 2) + 0.5
          : size,
      decoration: BoxDecoration(
        color: isFill
            ? isActive
                ? activeColor
                : inActiveColor
            : null,
        border: !isFill
            ? Border.all(
                color: isActive ? activeColor ?? primary : borderColor ?? primary.withOpacity(0.5),
                width: isActive ? thickness : thickness - 1,
              )
            : Border.all(
                color: isActive ? activeColor ?? primary : borderColor ?? primary.withOpacity(0.5),
                width: isActive ? thickness : thickness - 1,
              ),
        borderRadius: BorderRadius.all(Radius.circular(size)),
      ),
    );
  }
}
