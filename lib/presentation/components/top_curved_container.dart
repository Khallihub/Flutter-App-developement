import 'package:flutter/material.dart';

class TopCurvedContainer extends StatelessWidget {
  final Color color;
  final double radius;
  final Widget child;
  const TopCurvedContainer(
      {super.key,
      required this.color,
      required this.radius,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius)),
          color: color),
      child: child,
    );
  }
}
