import 'package:flutter/material.dart';
import 'package:smart_foot_traffic_ui/pages/about/about_screen.dart';
import 'package:smart_foot_traffic_ui/pages/home/home_screen.dart';
import 'package:smart_foot_traffic_ui/pages/location/location_screen.dart';
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
        bool isMobile = constraints.maxWidth < 750;

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
                        onTap: () => navigateWithoutAnimation(context, '/'),
                        child: Image.asset('assets/images/council_logo.png',
                            height: 160),
                      ),
                      const Spacer(),
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

  List<Widget> _buildMenuItems(BuildContext context) {
    return [
      AppBarButton(
        label: "Home",
        onPressed: () => navigateWithoutAnimation(context, '/'),
      ),
      AppBarButton(
        label: "Location",
        onPressed: () => navigateWithoutAnimation(context, '/location'),
      ),
      AppBarButton(
        label: "Transport",
        onPressed: () => navigateWithoutAnimation(context, '/transport'),
      ),
      AppBarButton(
        label: "Map",
        onPressed: () => navigateWithoutAnimation(context, '/map'),
      ),
      AppBarButton(
        label: "About",
        onPressed: () => navigateWithoutAnimation(context, '/about'),
      ),
    ];
  }

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

  Widget _getPage(String routeName) {
    switch (routeName) {
      case '/location':
        return const LocationScreen();
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
