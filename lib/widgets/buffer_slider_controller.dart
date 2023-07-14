import 'package:flutter/material.dart';

class BufferSliderController extends StatelessWidget {
  final String minText;
  final String maxText;
  final double maxValue;
  final double currentValue;
  final Function(double) onChanged;

  const BufferSliderController({
    super.key,
    required this.maxText,
    required this.minText,
    required this.maxValue,
    required this.currentValue,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: currentValue,
          min: 0,
          max: maxValue, 
          onChanged: (value) => onChanged(value)
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(minText),
              Text(maxText),
            ],
          ),
        )
      ],
    );
  }
}