import 'package:flutter/material.dart';
import 'package:smart_foot_traffic_ui/pages/about/about_screen.dart';
import 'package:smart_foot_traffic_ui/pages/home/home_screen.dart';
import 'package:smart_foot_traffic_ui/pages/gallery/gallery_screen.dart';
import 'package:smart_foot_traffic_ui/pages/map/map_screen.dart';
import 'package:smart_foot_traffic_ui/pages/transport/transport_screen.dart';
import 'appbar_button.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onHomePressed;

  const CustomAppBar({super.key, required this.onHomePressed});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(90);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // When the screen width is less than 950, we consider it as mobile
        bool isMobile = constraints.maxWidth < 950;

        // Column collapsable menu
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.white,
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                toolbarHeight: 90,
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      GestureDetector(
                        // Council logo - When click reset state to home screen
                        onTap: () => navigateWithoutAnimation(context, '/'),
                        child: Image.asset('assets/images/council_logo.png',
                            height: 160),
                      ),
                      const Spacer(),

                      // Show menu icon
                      if (isMobile)
                        IconButton(
                          icon: Icon(
                            _isMenuOpen ? Icons.close : Icons.menu,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() => _isMenuOpen = !_isMenuOpen);
                          },
                        )
                      else
                        Row(children: _buildMenuItems(context)),
                      if (!isMobile) const SizedBox(width: 8),
                      if (!isMobile)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow[700],
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 14),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text("Register Now →"),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            // Show menu items when the menu icon is clicked
            if (_isMenuOpen)
              Container(
                color: Colors.white,
                width: double.infinity,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height -
                      widget.preferredSize.height,
                ),
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ..._buildMenuItems(context),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[700],
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text("Register Now →"),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  // Build menu items for the app bar
  List<Widget> _buildMenuItems(BuildContext context) {
    return [
      AppBarButton(
        label: "Home",
        onPressed: () => navigateWithoutAnimation(context, '/'),
      ),
      AppBarButton(
        label: "Gallery",
        onPressed: () => navigateWithoutAnimation(context, '/gallery'),
      ),
      AppBarButton(
        label: "Map",
        onPressed: () => navigateWithoutAnimation(context, '/map'),
      ),
      AppBarButton(
        label: "Transport",
        onPressed: () => navigateWithoutAnimation(context, '/transport'),
      ),
      AppBarButton(
        label: "About",
        onPressed: () => navigateWithoutAnimation(context, '/about'),
      ),
    ];
  }

  // Remove the animation when navigating to a new screen
  void navigateWithoutAnimation(BuildContext context, String routeName) {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => _getPage(routeName),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
      (route) => false,
    );
  }

  // Routes
  Widget _getPage(String routeName) {
    switch (routeName) {
      case '/gallery':
        return const GalleryScreen();
      case '/transport':
        return const TransportScreen();
      case '/map':
        return const MapScreen();
      case '/about':
        return const AboutScreen();
      case '/':
      default:
        return const HomeScreen();
    }
  }
}
