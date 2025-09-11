// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:randomly/config/config.dart';
//
// class KeyfileButton extends StatelessWidget {
//   final VoidCallback onPressed;
//
//   const KeyfileButton({super.key, required this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return SizedBox(
//       height: 64, // Fixed height for consistent look
//       child: ElevatedButton.icon(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           // Background color
//           backgroundColor: primaryAccentShadeTwo,
//           // Remove default elevation and shadow
//           elevation: 0,
//           shadowColor: Colors.transparent,
//           // Shape and border radius
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           // Padding for the content inside the button
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//         ),
//         icon: Container(
//           width: 36,
//           height: 36,
//           decoration: BoxDecoration(
//             color: theme.colorScheme.secondary,
//             shape: BoxShape.circle,
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(6.0),
//             child: SvgPicture.asset(
//               "lib/assets/images/upload_icon.svg",
//             ),
//           ),
//         ),
//         label: Expanded(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Text(
//               'Select Keyfile',
//               style: theme.textTheme.bodyLarge?.copyWith(
//                 color: theme.colorScheme.onSurface, // Or a specific text color
//               ),
//               textAlign: TextAlign.left,
//               overflow: TextOverflow.ellipsis, // Prevents text from overflowing
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart' as p;
import 'package:randomly/config/config.dart';

class KeyfileButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? fileName;

  const KeyfileButton({
    super.key,
    required this.onPressed,
    this.fileName,
  });

  String _truncateFileName(String fullPath, int maxLength) {
    final baseName = p.basename(fullPath);
    if (baseName.length <= maxLength) return baseName;

    final extension = p.extension(baseName);
    final nameWithoutExt = baseName.replaceAll(extension, '');

    final start = nameWithoutExt.substring(0, maxLength - extension.length - 3);
    return '$start...$extension';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final displayText = fileName != null
        ? _truncateFileName(fileName!, 20)
        : 'Select Keyfile';

    return SizedBox(
      height: 64,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryAccentShadeTwo,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        icon: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: SvgPicture.asset(
              fileName == null
                  ? "lib/assets/images/upload_icon.svg"
                  : "lib/assets/images/file.svg",
              key: ValueKey(fileName == null ? "upload_icon" : "file"), // ✅ fix
            ),
          ),
        ),
        label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            displayText,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
