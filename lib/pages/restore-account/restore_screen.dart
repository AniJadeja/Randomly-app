import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:randomly/components/buttons/button_primary.dart';
import 'package:randomly/components/buttons/button_secondary.dart';
import 'package:randomly/components/buttons/custom_button.dart';
import 'package:randomly/config/config.dart';
import 'package:randomly/config/paths.dart';
import 'package:randomly/l10n/generated/app_localizations.dart';

class RestoreScreen extends StatefulWidget {
  const RestoreScreen({super.key});

  @override
  State<RestoreScreen> createState() => _RestoreScreenState();
}

class _RestoreScreenState extends State<RestoreScreen> {
  bool _isKeyProtected = false;
  bool _isPasswordValid = false;
  final FocusNode _passwordFocusNode = FocusNode();
  String userKeyFilePassword = '';

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void setKeyProtection(bool protection) {
    setState(() {
      _isKeyProtected = protection;
    });
    // When the key becomes protected, request focus for the password field.
    if (protection) {
      // Use post-frame callback to ensure the widget is in the tree before requesting focus.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _passwordFocusNode.requestFocus();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        setState(() => _isPasswordValid = userKeyFilePassword.length >= 12);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final lang = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () {
        // Unfocus the text field when tapping outside.
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.surfaceContainerLow,
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
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(20),
          child: Stack(
            // Wrap content with Stack
            children: [
              Column(
                // This is the main content
                children: [
                  const SizedBox(height: 20),
                  Text(
                    lang.restoreAccountInstructionString,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: Row(
                      children: [
                        Expanded(
                          child: TileButton(
                            styleType: ButtonStyleType.primary,
                            fileType: FileType.any,
                            defaultTitle: lang.keyfileButtonString,
                            defaultDescription: lang.keyfileDescriptionString,
                            defaultIcon: Icons.key,
                            onFilePicked: (file, path) {
                              print('File picked: ${file.path}');
                              setKeyProtection(true);
                            },
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: TileButton(
                            styleType: ButtonStyleType.secondary,
                            fileType: FileType.any,
                            defaultTitle: lang.chatBackupButtonString,
                            defaultDescription:
                                lang.chatBackupDescriptionString,
                            defaultIcon: Icons.article_rounded,
                            onFilePicked: (file, path) {
                              print('File picked: ${file.path}');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 42), // Added spacing
                  if (_isKeyProtected)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lang.keyFileProtectionString,
                          textAlign: TextAlign.left,
                          style: textTheme.bodyMedium?.copyWith(
                            color: _isPasswordValid
                                ? textTheme.bodyMedium?.color
                                : theme.colorScheme.error,
                          ),
                        ),
                        const SizedBox(height: 24), // Added spacing
                        TextField(
                          focusNode: _passwordFocusNode,
                          onChanged: (value) => userKeyFilePassword = value,
                          style: TextStyle(color: theme.colorScheme.onSurface),
                          cursorColor: theme.colorScheme.onSurface,
                          decoration: InputDecoration(
                            hintText: lang.enterPasswordHintString,
                            // Assuming this key exists
                            hintStyle: TextStyle(
                              color: theme.colorScheme.onSurfaceVariant
                                  .withAlpha(_isPasswordValid ? 80 : 200),
                            ),
                            filled: true,
                            fillColor: _isPasswordValid
                                ? theme.colorScheme.surfaceDim
                                : theme.colorScheme.errorContainer,
                            // Use enabledBorder to show the border when the field is not focused.
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.transparent,
                              ),
                            ),
                            // Use focusedBorder to keep the border red when the field is focused.
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                width: 2,
                                color: theme
                                    .colorScheme
                                    .error, // Or your theme's primary color
                              ),
                            ),
                            // The 'border' property can be used as a fallback for other states.
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              Positioned(
                // Positioned buttons at the bottom
                bottom: 0,
                // Adjusted to be at the very bottom of the SafeArea
                left: 0,
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ButtonPrimary(
                      text: lang.letsStartString,
                      cornerRadius: 5,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 16),
                    ButtonSecondary(
                      text: lang.cancelRestoreButtonString,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      isCancelAction: true,
                    ),
                    const SizedBox(height: 16),
                    // Added for some padding from bottom if needed
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
