import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const AppBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    const List<CustomBottomNavigationBarItem> _bottomNavigationBarItems =
        CustomBottomNavigationBarItem.values;

    return Container(
      color: AppColors.transparentLimeGreen,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.padding5),
        child: GNav(
          gap: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          tabBackgroundColor: AppColors.limeGreen,
          tabBorderRadius: AppBorderRadius.borderRadius30,
          color: AppColors.black,
          onTabChange: onTabChange,
          selectedIndex: selectedIndex,
          tabs: _bottomNavigationBarItems
              .map(
                (CustomBottomNavigationBarItem tab) => GButton(
                  icon: tab.icon,
                  text: tab.pageName,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}