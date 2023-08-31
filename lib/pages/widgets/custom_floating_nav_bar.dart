import 'package:flutter/material.dart';

import '../../core/util/constants.dart';
class CustomFloatingNavBar extends StatelessWidget {
  const CustomFloatingNavBar({
    required this.currentIndex,
    required this.onTap ,
    super.key,
  });
 final int currentIndex ;
 final Function (int)? onTap ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.fromLTRB(24, 0, 24, 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BottomNavigationBar(
          currentIndex:currentIndex ,
            onTap: onTap,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: kPrimaryColor,
            selectedItemColor: Colors.white,
            selectedIconTheme: const IconThemeData(size: 28),
            unselectedItemColor: Colors.grey.shade300,
            elevation: 0,

            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.emergency_share_outlined),
                  label: '',
                  activeIcon: Icon(Icons.emergency_share)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: '',
                  activeIcon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: '',
                  activeIcon: Icon(Icons.person)),
            ]),
      ),
    );
  }
}
