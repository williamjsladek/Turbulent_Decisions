import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text("Drawer Header"),
          ),
          ListTile(
            title: const Text("Home"),
            onTap: () {
              Navigator.pushNamed(
                  context,
                  '/'
              );
            },
          ),
          ListTile(
            title: const Text("Roulette"),
            onTap: () {
              Navigator.pushNamed(
                  context,
                  '/roulette'
              );
            },
          ),
          ListTile(
            title: const Text("Dice"),
            onTap: () {
              Navigator.pushNamed(
                  context,
                  '/dice'
              );
            },
          ),
        ],
      ),
    );
  }
}