import 'package:flutter/material.dart';
import 'package:smart_foot_traffic_ui/pages/about/about_screen.dart';
import 'package:smart_foot_traffic_ui/pages/home/home_screen.dart';
import 'package:smart_foot_traffic_ui/pages/location/location_screen.dart';
import 'package:smart_foot_traffic_ui/pages/map/map_screen.dart';
import 'package:smart_foot_traffic_ui/pages/transport/transport_screen.dart';
import 'appbar_button.dart'; // ✅ still needed

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onHomePressed;

  const CustomAppBar({super.key, required this.onHomePressed});

  @override
  Size get preferredSize => const Size.fromHeight(90);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 90,
        title: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Wrap Image inside GestureDetector for both click and hover effect
              GestureDetector(
                onTap: () {
                  navigateWithoutAnimation(context, '/');
                },
                child: MouseRegion(
                  onEnter: (_) {
                    // Changes cursor to hand pointer when hovering
                    SystemMouseCursors.click;
                  },
                  child: Image.asset('assets/images/council_logo.png',
                      height: 160),
                ),
              ),
              const Spacer(),
              // AppBar buttons to navigate between screens with hover effect and pointer cursor
              MouseRegion(
                onEnter: (_) {
                  SystemMouseCursors.click;
                },
                child: AppBarButton(
                  label: "Home",
                  onPressed: () {
                    navigateWithoutAnimation(context, '/');
                  },
                ),
              ),
              MouseRegion(
                onEnter: (_) {
                  SystemMouseCursors.click;
                },
                child: AppBarButton(
                  label: "Location",
                  onPressed: () {
                    navigateWithoutAnimation(context, '/location');
                  },
                ),
              ),
              MouseRegion(
                onEnter: (_) {
                  SystemMouseCursors.click;
                },
                child: AppBarButton(
                  label: "Transport",
                  onPressed: () {
                    navigateWithoutAnimation(context, '/transport');
                  },
                ),
              ),
              MouseRegion(
                onEnter: (_) {
                  SystemMouseCursors.click;
                },
                child: AppBarButton(
                  label: "Map",
                  onPressed: () {
                    navigateWithoutAnimation(context, '/map');
                  },
                ),
              ),
              MouseRegion(
                onEnter: (_) {
                  SystemMouseCursors.click;
                },
                child: AppBarButton(
                  label: "About",
                  onPressed: () {
                    navigateWithoutAnimation(context, '/about');
                  },
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[700],
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
    );
  }

  // 👉 This handles instant no-animation navigation
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

  // 👉 This finds the correct page based on route name
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
