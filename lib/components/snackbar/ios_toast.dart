import 'package:flutter/material.dart';

class IosToast {
  static OverlayEntry show(
    BuildContext context,
    String message, {
    int duration = 2,
  }) {
    final theme = Theme.of(context);
    final overlay = Overlay.of(context)!;

    final animationController = AnimationController(
      vsync: overlay,
      duration: const Duration(milliseconds: 300),
    );

    final animation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        );

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 80,
        left: 24,
        right: 24,
        child: Material(
          color: Colors.transparent,
          child: SlideTransition(
            position: animation,
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceBright,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Text(
                message,
                style: TextStyle(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    animationController.forward();

    bool removed = false;

    Future.delayed(Duration(seconds: duration), () async {
      if (!removed) {
        await animationController.reverse();
        overlayEntry.remove();
        removed = true;
        animationController.dispose();
      }
    });

    return overlayEntry;
  }
}
