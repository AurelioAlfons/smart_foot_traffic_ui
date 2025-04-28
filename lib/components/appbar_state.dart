import 'package:flutter/material.dart';
import 'appbar_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // 👈 ADD implements PreferredSizeWidget
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
              Image.asset('assets/images/council_logo.png', height: 160),
              const Spacer(),
              AppBarButton(label: "Home", onPressed: onHomePressed),
              AppBarButton(label: "Location", onPressed: () {}),
              AppBarButton(label: "Transport", onPressed: () {}),
              AppBarButton(label: "Map", onPressed: () {}),
              AppBarButton(label: "About", onPressed: () {}),
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
}
