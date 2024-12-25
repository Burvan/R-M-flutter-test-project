import 'package:core/enums/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

extension CustomBottomNavigationBarItemEx on CustomBottomNavigationBarItem {
  IconData get icon {
    switch (this) {
      case CustomBottomNavigationBarItem.characters:
        return Icons.people;
      case CustomBottomNavigationBarItem.settings:
        return Icons.settings;
    }
  }

  String get pageName {
    switch (this) {
      case CustomBottomNavigationBarItem.characters:
        return 'Characters';
      case CustomBottomNavigationBarItem.settings:
        return 'Settings';
    }
  }
}
