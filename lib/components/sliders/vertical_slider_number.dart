import 'package:flutter/material.dart';

class NumberPicker extends StatefulWidget {
  final int lowerBound;
  final int upperBound;
  final int defaultNumber;
  final ValueChanged<int>? onNumberChanged;


  const NumberPicker({
    super.key,
    this.lowerBound = 18,
    this.upperBound = 70,
    this.defaultNumber = 24,
    this.onNumberChanged
  });

  @override
  State<NumberPicker> createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPicker> {
  late int _selectedNumber;
  late int _selectedIndex;
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // Initialize with the provided default Number
    _selectedNumber = widget.defaultNumber;
    // Calculate the initial index
    _selectedIndex = widget.defaultNumber - widget.lowerBound;
    _scrollController = FixedExtentScrollController(initialItem: _selectedIndex);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    const double itemExtent = 60.0;
    const int visibleItems = 5;

    // Generate the list of Numbers based on the bounds
    final List<int> Numbers = List.generate(
      widget.upperBound - widget.lowerBound + 1,
          (index) => widget.lowerBound + index,
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: itemExtent,
          width: 80,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        SizedBox(
          height: visibleItems * itemExtent,
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black,
                  Colors.black,
                  Colors.transparent,
                ],
                stops: [0.0, 0.25, 0.75, 1.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: ListWheelScrollView.useDelegate(
              controller: _scrollController,
              itemExtent: itemExtent,
              physics: const FixedExtentScrollPhysics(),
              perspective: 0.003,
              magnification: 1.5,
              onSelectedItemChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                  _selectedNumber = Numbers[index];
                });
                if (widget.onNumberChanged != null) {
                  widget.onNumberChanged!(_selectedNumber); // Call the callback with the new age
                }
              },
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (BuildContext context, int index) {
                  final Number = Numbers[index];
                  final distance = (index - _selectedIndex).abs();

                  double fontSize;
                  if (distance == 0) {
                    fontSize = 40;
                  } else if (distance == 1) {
                    fontSize = 28;
                  } else {
                    fontSize = 20;
                  }

                  final isSelected = Number == _selectedNumber;

                  return Center(
                    child: Text(
                      '$Number',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? theme.colorScheme.surfaceDim : theme.colorScheme.onSurface,
                      ),
                    ),
                  );
                },
                childCount: Numbers.length,
              ),
            ),
          ),
        ),
      ],
    );
  }
}






