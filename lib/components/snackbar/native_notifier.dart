import 'dart:io';
import 'package:flutter/material.dart';
import 'package:randomly/components/snackbar/android_snackbar.dart';
import 'ios_toast.dart';

class NativeNotifier {
  static OverlayEntry? _currentOverlay;

  static void show(BuildContext context, String message, {int duration = 2}) {
    // Remove any existing toast
      _currentOverlay?.safeRemove();
      _currentOverlay = null;

    if (Platform.isIOS) {
      _currentOverlay = IosToast.show(context, message, duration: duration);
    } else {
      _currentOverlay = AndroidToast.show(context, message, duration: duration);
    }
  }

  static void dismiss() {
      _currentOverlay?.safeRemove();
      _currentOverlay = null;
  }
}
extension OverlayEntrySafeRemove on OverlayEntry {
  void safeRemove() {
    try {
      remove();
    } catch (_) {
      // Already removed, ignore
    }
  }
}
