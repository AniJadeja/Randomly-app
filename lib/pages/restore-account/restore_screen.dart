import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:randomly/components/buttons/custom_button.dart';
import 'package:randomly/config/config.dart';
import 'package:randomly/config/paths.dart';

class RestoreScreen extends StatelessWidget {
  const RestoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        toolbarHeight: 80,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(logoSvgPath, height: 24),
            const SizedBox(width: 8),
            Text(
              appName,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "To restore your account, provide your keyfile and optionally chat backup file",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Container(
              // This Container automatically fills the available width
              margin: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  // This widget will fill half the available width
                  Expanded(child: CustomGlowButton()),

                  // This creates a fixed-size gap
                  const SizedBox(width: 16),

                  // This widget will also fill half the available width
                  Expanded(
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainer, // Set color here
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: const Center(child: Text('Widget 2')),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
