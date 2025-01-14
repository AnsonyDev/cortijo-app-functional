// ignore_for_file: library_private_types_in_public_api

import 'package:cortijo_app/theme/colors.dart';
import 'package:flutter/material.dart';

class StringRadioButtons<T> extends StatefulWidget {
  const StringRadioButtons({
    super.key,
    this.initOption,
    required this.options,
    required this.onSelectionChanged,
    this.reset = false,
  });
  final List<T> options;
  final Function(T) onSelectionChanged;
  final bool reset;
  final T? initOption;

  @override
  _StringRadioButtonsState<T> createState() => _StringRadioButtonsState<T>();
}

class _StringRadioButtonsState<T> extends State<StringRadioButtons<T>> {
  T? _selectedOption;

  @override
  void initState() {
    _selectedOption = widget.initOption;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.reset && _selectedOption != null) {
      setState(() {
        _selectedOption = null;
      });
    }
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceBetween,
      children: widget.options.map((option) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * .40,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<T>(
                value: option,
                groupValue: _selectedOption,
                activeColor: AppColors.oliveGreen,
                splashRadius: 20,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                  widget.onSelectionChanged(value as T);
                },
              ),
              Expanded(child: Text(option.toString())),
            ],
          ),
        );
      }).toList(),
    );
  }
}
