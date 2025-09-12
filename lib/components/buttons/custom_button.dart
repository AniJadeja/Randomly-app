import 'package:flutter/material.dart';

class CustomGlowButton extends StatefulWidget {
  @override
  _CustomGlowButtonState createState() => _CustomGlowButtonState();
}

class _CustomGlowButtonState extends State<CustomGlowButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    // Define the colors and gradients for the different states.
    final Color unselectedBackgroundColor = Color(0xFF1E1E1E);
    final Gradient borderGradient = LinearGradient(
      colors: [Color(0xFF004D29), Color(0xFF00274B)], // Darker versions of your theme colors
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
    );

    // For even more noticeable selected state
    final Gradient unSelectedBackgroundGradient = LinearGradient(
      colors: [Color(0xFF1E1E1E), Color(0xFF1E1E1E)], // Darker versions of your theme colors
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    // For even more noticeable selected state
    final Gradient selectedBackgroundGradient = LinearGradient(
      colors: [Color(0xFF003D20), Color(0xFF001A33)], // Darker versions of your theme colors
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          print('Button tapped. isSelected is now: $_isSelected'); // Debug print
        });
      },
      child: Container(
        padding: EdgeInsets.all(2.0), // Padding to create the gradient border
        width: 180,
        decoration: BoxDecoration(
          gradient: borderGradient,
          borderRadius: BorderRadius.circular(20),
          // Add a subtle glow effect when selected
          boxShadow: _isSelected ? [
            BoxShadow(
              // color: Color(0xFF00FF7F).withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ] : null,
        ),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100), // Increased duration
          curve: Curves.bounceIn, // Smoother curve
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            // color: _isSelected ? null : unSelectedBackgroundGradient,
            gradient: _isSelected ? selectedBackgroundGradient : unSelectedBackgroundGradient,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon color changes based on selection state
              Icon(
                  Icons.key,
                  size: 50,
                  color: _isSelected ? Colors.white : Colors.white70
              ),
              SizedBox(height: 10),
              Text(
                'Your Keyfile',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Keyfile provides the identity of your account.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: null, // Keep this null so GestureDetector handles taps
                child: Text(
                  _isSelected ? 'Selected' : 'Click here', // Visual feedback
                  style: TextStyle(
                    color: _isSelected ? Color(0xFF00FF7F) : Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}