import 'package:flutter/material.dart';

class MainTabBarWidget extends StatelessWidget {
  const MainTabBarWidget({
    required this.icon,
    super.key,
  });
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: icon,
    );
  }
}
