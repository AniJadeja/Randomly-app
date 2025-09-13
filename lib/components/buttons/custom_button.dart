import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/strings/pages.texts.dart';

enum ButtonStyleType { primary, secondary }
enum FileType { any, rml, rmc }

class TileButton extends StatefulWidget {
  final ButtonStyleType styleType;
  final FileType? fileType;
  final String defaultTitle;
  final String defaultDescription;
  final IconData defaultIcon;
  final Function(File file, String path)? onFilePicked;
  final Function()? onButtonPressed;

  const TileButton({
    Key? key,
    required this.styleType,
    required this.defaultTitle,
    required this.defaultDescription,
    required this.defaultIcon,
    this.fileType,
    this.onFilePicked,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  _TileButtonState createState() => _TileButtonState();
}

class _TileButtonState extends State<TileButton> {
  bool _isSelected = false;
  bool _isPressed = false;
  String? _pickedFileName;
  String? _pickedFilePath;

  bool get _isFileType => widget.fileType != null;

  Future<void> _pickFile() async {
    List<XTypeGroup> acceptedTypeGroups = [];
    switch (widget.fileType) {
      case FileType.any:
        acceptedTypeGroups.add(const XTypeGroup(
          label: 'Any file',
          extensions: ['*'],
        ));
        break;
      case FileType.rml:
        acceptedTypeGroups.add(const XTypeGroup(
          label: 'Randomly Key files',
          extensions: ['rml'],
          mimeTypes: ['application/octet-stream'],
        ));
        break;
      case FileType.rmc:
        acceptedTypeGroups.add(const XTypeGroup(
          label: 'Randomly Chat Backup files',
          extensions: ['rmc'],
          mimeTypes: ['application/octet-stream'],
        ));
        break;
      default:
        return;
    }

    try {
      final XFile? pickedXFile = await openFile(acceptedTypeGroups: acceptedTypeGroups);
      if (pickedXFile != null) {
        setState(() {
          _pickedFileName = pickedXFile.name;
          _pickedFilePath = pickedXFile.path;
          _isSelected = true;
          _isPressed = false;
        });
        widget.onFilePicked?.call(File(pickedXFile.path), pickedXFile.path);
      } else {
        setState(() {
          _isPressed = false;
        });
      }
    } catch (e) {
      print('Error picking file: $e');
      setState(() {
        _isPressed = false;
      });
    }
  }

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw '$couldNotLaunchUrlError $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bool isPrimaryLike = widget.styleType == ButtonStyleType.primary;
    final bool isSecondary = widget.styleType == ButtonStyleType.secondary;
    final bool isSecondaryAndSelected = isSecondary && _isSelected;

    final Color unselectedBackgroundColor = Color(0xFF1E1E1E);
    final Color secondarySelectedBackgroundColor = Color(0xFF101010);

    final Gradient primaryUnselectedBackgroundGradient = LinearGradient(
      colors: [unselectedBackgroundColor, unselectedBackgroundColor],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final Gradient primarySelectedBackgroundGradient = LinearGradient(
      colors: [Color(0xFF003D20), Color(0xFF001A33)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    BoxDecoration outerDecoration;
    BoxDecoration innerDecoration;

    if (isPrimaryLike) {
      outerDecoration = BoxDecoration(
        gradient: primaryUnselectedBackgroundGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: _isSelected
            ? [BoxShadow(blurRadius: 10, spreadRadius: 2)]
            : null,
      );
      innerDecoration = BoxDecoration(
        gradient: _isSelected
            ? primarySelectedBackgroundGradient
            : primaryUnselectedBackgroundGradient,
        borderRadius: BorderRadius.circular(20),
      );
    } else {
      outerDecoration = BoxDecoration(
        color: unselectedBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      );
      innerDecoration = BoxDecoration(
        color: _isSelected
            ? secondarySelectedBackgroundColor
            : unselectedBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      );
    }

    Color iconColor = _isSelected
        ? (isPrimaryLike ? Colors.white : Colors.white38)
        : Colors.white70;

    TextStyle titleStyle = textTheme.displaySmall!;
    if (_isSelected) {
      if (isPrimaryLike) {
        titleStyle = titleStyle.copyWith(color: Colors.white);
      } else if (isSecondary) {
        titleStyle = titleStyle.copyWith(color: Colors.white38);
      }
    }

    Color descriptionColor = _isSelected
        ? (isPrimaryLike ? Colors.white54 : Colors.white30)
        : Colors.white54;

    TextStyle baseRichTextStyle = textTheme.bodySmall ?? TextStyle();
    if (_isSelected && isSecondary) {
      baseRichTextStyle = baseRichTextStyle.copyWith(color: Colors.white30);
    } else {
      baseRichTextStyle = baseRichTextStyle.copyWith(
        color: baseRichTextStyle.color ?? Colors.white70,
      );
    }

    return GestureDetector(
      onTapDown: (_) {
        if (!_isSelected) {
          setState(() {
            _isPressed = true;
          });
        }
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      onTap: () async {
        if (_isFileType) {
          if (!_isSelected) {
            await _pickFile();
          }
        } else {
          if (!_isSelected) {
            setState(() {
              _isSelected = true;
            });
            widget.onButtonPressed?.call();
          }
        }
      },
      child: Stack(
        children: [
          AnimatedScale(
            scale: _isPressed && !_isSelected ? 0.95 : 1.0,
            duration: const Duration(milliseconds: 50),
            child: Container(
              padding: EdgeInsets.all(isPrimaryLike ? 2.0 : 0.0),
              decoration: outerDecoration,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                curve: Curves.bounceIn,
                padding: EdgeInsets.all(20),
                decoration: innerDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(widget.defaultIcon, size: 50, color: iconColor),
                    SizedBox(height: 20),
                    Text(
                      _pickedFileName ?? widget.defaultTitle,
                      style: titleStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.defaultDescription,
                      style: TextStyle(fontSize: 12, color: descriptionColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 50),
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        style: baseRichTextStyle,
                        children: [
                          TextSpan(text: "To know more, \n"),
                          TextSpan(
                            text: "Click Here",
                            style: textTheme.bodySmall?.copyWith(
                              color: Color(0xFFBE823D),
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xFFBE823D),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () =>
                                  openUrl("https://example.com/terms"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isSelected)
            Positioned(
              top: 12.0,
              right: 12.0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isSelected = false;
                    _isPressed = false;
                    _pickedFileName = null;
                    _pickedFilePath = null;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.close, color: Colors.white, size: 14.0),
                      SizedBox(width: 4.0),
                      Text(
                        'Clear',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}