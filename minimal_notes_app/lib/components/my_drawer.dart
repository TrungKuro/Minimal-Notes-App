import 'package:flutter/material.dart';
import 'package:minimal_notes_app/components/drawer_tile.dart';
import 'package:minimal_notes_app/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // HEADER
          const DrawerHeader(
            child: Icon(
              Icons.edit,
            ),
          ),
          const SizedBox(height: 25),

          // NOTES TILE
          DrawerTile(
            tile: 'Notes',
            leading: const Icon(Icons.home),
            // Quay lại Notes Page
            onTap: () => Navigator.pop(context),
          ),
          //SETTING TILE
          DrawerTile(
            tile: 'Settings',
            leading: const Icon(Icons.settings),
            onTap: () {
              // Quay lại Notes Page
              Navigator.pop(context);
              // Nhảy sang Settings Page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
