import 'package:flutter/material.dart';

import '../uitilies/app_colors.dart';

class CustomDropdown extends StatefulWidget {
  final String initialValue;
  final List<String> items;
  final Function(String?) onChanged;

  const CustomDropdown({
    required this.initialValue,
    required this.items,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF99).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.secondColor.withOpacity(0.2)),
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        isExpanded: true,
        dropdownColor: AppColors.bgColor,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.white),
        underline: Container(height: 0),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
          widget.onChanged(newValue);
        },
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(color: Colors.white), // Dropdown list text color white
            ),
          );
        }).toList(),
      ),
    );
  }
}
