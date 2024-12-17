// import libraries
import 'package:flutter/material.dart';

// creates BaseCard class which extends from StatelssWidget
class BaseCard extends StatelessWidget {
  // class constructor
  const BaseCard({super.key, required this.child});

  final Widget child;
  // overrides method that builds widget
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromARGB(
          255,
          0,
          0,
          0,
        ),
      ),
      child: child,
    );
  }
}
