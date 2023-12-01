import 'package:flutter/material.dart';
import 'package:meal_app/model/meal_detail.dart';

class InstructionsWidget extends StatelessWidget {
  const InstructionsWidget({super.key, required this.meal});

  final MealDetail meal;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Instructions:',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        Text(
          meal.strInstructions,
          style: const TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}
