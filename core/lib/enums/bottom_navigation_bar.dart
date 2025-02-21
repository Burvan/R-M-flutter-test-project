import 'package:flutter/material.dart';

enum CustomBottomNavigationBarItem {
  characters(Icons.people, 'Characters'),
  settings(Icons.settings, 'Settings');

  final IconData icon;
  final String pageName;

  const CustomBottomNavigationBarItem(
    this.icon,
    this.pageName,
  );
}
