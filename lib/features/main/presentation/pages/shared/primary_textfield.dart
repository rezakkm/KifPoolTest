import 'package:flutter/material.dart';
import 'package:glassy/glassy_card.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({super.key, this.controller});
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return GlassyCard(
        child: SizedBox(
      height: 56,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              textAlignVertical: TextAlignVertical.top,
              style: const TextStyle(
                color: Colors.white, // Text color
                fontSize: 18,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                border: InputBorder.none,
                hintText: 'متن خود را وارد کنید',
                hintStyle: TextStyle(
                  color:
                      Colors.grey.withOpacity(0.5), // Hint color with opacity
                ),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 1,
                height: 36,
                color: Colors.grey.withOpacity(0.4),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.content_copy_rounded,
                  color: Colors.grey.withOpacity(0.5),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}
