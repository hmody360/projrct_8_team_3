import 'package:flutter/material.dart';

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  final FloatingActionButtonLocation location;
  final double offsetY; // Positive value to move downwards

  const CustomFloatingActionButtonLocation(
    this.location, {
    required this.offsetY,
  });

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final Offset offset = location.getOffset(scaffoldGeometry);
    return Offset(offset.dx, offset.dy + offsetY);
  }
}