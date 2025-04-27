import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget desktop;
  final Widget tablet;
  final Widget mobile;

  const ResponsiveLayout({
    Key? key,
    required this.desktop,
    required this.tablet,
    required this.mobile,
  }) : super(key: key);

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 900;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 900;
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    if (isDesktop(context)) {
      return desktop;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return mobile;
    }
  }
}
