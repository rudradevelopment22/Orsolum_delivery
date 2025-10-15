import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:orsolum_delivery/constant/color_const.dart';

class CustomDropdownField extends StatefulWidget {
  final String hintText;
  final List<String> items;
  final ValueChanged<String> onChanged;
  final String? selectedValue;

  const CustomDropdownField({
    super.key,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.selectedValue,
  });

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Dropdown header
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: ColorConst.grey200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.selectedValue ?? widget.hintText),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
              ],
            ),
          ),
        ),

        // Expandable dropdown list
        AnimatedContainer(
          margin: isExpanded ? const EdgeInsets.only(top: 10) : EdgeInsets.zero,
          duration: const Duration(milliseconds: 300),
          height: isExpanded ? 150 : 0, // Show max 3 items (50px each)
          child: ListView.separated(
            padding: EdgeInsets.all(2),
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  widget.onChanged(widget.items[index]);
                  setState(() {
                    isExpanded = false;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  height: 48,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorConst.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 4,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(widget.items[index]),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
          ),
        ),
      ],
    );
  }
}
