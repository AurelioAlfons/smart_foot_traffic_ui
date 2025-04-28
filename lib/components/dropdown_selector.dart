import 'package:flutter/material.dart';

class DropdownSelector extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final ValueChanged<bool>? onDropdownStateChanged; // 👈 ADD THIS

  const DropdownSelector({
    super.key,
    required this.label,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.onDropdownStateChanged, // 👈 ADD THIS
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.yellow[700],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          hint: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          dropdownColor: Colors.yellow[700],
          iconEnabledColor: Colors.black,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          items: items
              .map((value) => DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  ))
              .toList(),
          onChanged: (value) {
            onChanged(value); // update selected value
            if (onDropdownStateChanged != null) {
              onDropdownStateChanged!(false); // 👈 dropdown closed
            }
          },
          onTap: () {
            if (onDropdownStateChanged != null) {
              onDropdownStateChanged!(true); // 👈 dropdown opened
            }
          },
        ),
      ),
    );
  }
}
