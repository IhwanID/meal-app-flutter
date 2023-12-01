import 'package:flutter/material.dart';

class CategoryChipWidget extends StatelessWidget {
  const CategoryChipWidget(
      {super.key,
      required this.label,
      required this.imageUrl,
      required this.isSelected});

  final String label;
  final String imageUrl;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        child: Chip(
          labelPadding: const EdgeInsets.fromLTRB(16, 8, 8, 10),
          avatar: CircleAvatar(
            backgroundColor: Colors.amber[50],
            backgroundImage: NetworkImage(imageUrl),
          ),
          label: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: isSelected ? Colors.amber : Colors.white,
          elevation: 6.0,
          shadowColor: Colors.grey[60],
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        ),
      ),
    );
  }
}
