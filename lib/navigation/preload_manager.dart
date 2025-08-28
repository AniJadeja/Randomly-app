import 'package:flutter/material.dart';

class PreloadManager extends StatefulWidget {
  final Widget child;
  final Map<String, WidgetBuilder> routesToPreload;

  const PreloadManager({
    super.key,
    required this.child,
    required this.routesToPreload,
  });

  @override
  State<PreloadManager> createState() => _PreloadManagerState();
}

class _PreloadManagerState extends State<PreloadManager> {
  final Map<String, Widget> _builtScreens = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        for (var entry in widget.routesToPreload.entries) {
          _builtScreens[entry.key] = entry.value(context);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        ..._builtScreens.values.map((w) => Offstage(offstage: true, child: w)),
      ],
    );
  }
}
