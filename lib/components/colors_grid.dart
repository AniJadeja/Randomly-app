import 'package:flutter/material.dart';

class DualColorGridScreen extends StatelessWidget {
  final Color seedColor;

  const DualColorGridScreen({super.key, required this.seedColor});

  @override
  Widget build(BuildContext context) {
    // Generate light and dark color schemes
    final lightScheme = ColorScheme.fromSeed(seedColor: seedColor);
    final darkScheme =
    ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.dark);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generated Colors (Light & Dark)'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            // Light Theme Colors
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text('Light Theme', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            _buildColorGrid(lightScheme),

            const Divider(height: 32, thickness: 2),

            // Dark Theme Colors
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text('Dark Theme', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            _buildColorGrid(darkScheme),
          ],
        ),
      ),
    );
  }

  /// Helper to build a grid of colors from a ColorScheme
  Widget _buildColorGrid(ColorScheme scheme) {
    final colorsMap = {
      'primary': scheme.primary,
      'onPrimary': scheme.onPrimary,
      'primaryContainer': scheme.primaryContainer,
      'onPrimaryContainer': scheme.onPrimaryContainer,
      'secondary': scheme.secondary,
      'onSecondary': scheme.onSecondary,
      'secondaryContainer': scheme.secondaryContainer,
      'onSecondaryContainer': scheme.onSecondaryContainer,
      'tertiary': scheme.tertiary,
      'onTertiary': scheme.onTertiary,
      'tertiaryContainer': scheme.tertiaryContainer,
      'onTertiaryContainer': scheme.onTertiaryContainer,
      'error': scheme.error,
      'onError': scheme.onError,
      'errorContainer': scheme.errorContainer,
      'onErrorContainer': scheme.onErrorContainer,
      'background': scheme.background,
      'onBackground': scheme.onBackground,
      'surface': scheme.surface,
      'onSurface': scheme.onSurface,
      'surfaceVariant': scheme.surfaceVariant,
      'onSurfaceVariant': scheme.onSurfaceVariant,
      'outline': scheme.outline,
      'shadow': scheme.shadow,
      'inverseSurface': scheme.inverseSurface,
      'onInverseSurface': scheme.onInverseSurface,
      'inversePrimary': scheme.inversePrimary,
    };

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: colorsMap.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final name = colorsMap.keys.elementAt(index);
        final color = colorsMap.values.elementAt(index);

        return Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black12),
          ),
          child: Center(
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _getTextColor(color),
                fontWeight: FontWeight.bold,
                fontSize: 8,
              ),
            ),
          ),
        );
      },
    );
  }

  /// Returns a readable text color based on the background
  Color _getTextColor(Color background) {
    return ThemeData.estimateBrightnessForColor(background) == Brightness.dark
        ? Colors.white
        : Colors.black;
  }
}
