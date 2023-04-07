import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String location;
  final Function? openDrawer;

  final List<Widget>? actions;
  final Function onLocationPressed;

  const CustomAppBar(
      {super.key,
      required this.location,
      required this.onLocationPressed,
      this.actions,
      this.openDrawer, required String title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: IconButton(
        icon: const FaIcon(
          FontAwesomeIcons.sliders,
          size: 20,
          color: Colors.black,
        ),
        onPressed: () => openDrawer,
      ),
      title: GestureDetector(
        onTap: () {
          // Open bottom sheet to search or detect location
          onLocationPressed();
        },
        child: Row(
          children: [
            const Icon(
              Icons.location_on,
              color: Colors.black,
            ),
            const SizedBox(width: 3.0),
            Text(
              location,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
