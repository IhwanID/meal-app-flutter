import 'package:flutter/material.dart';
import 'package:meal_app/model/meal_detail.dart';

class IngredientsWidget extends StatelessWidget {
  const IngredientsWidget({super.key, required this.meal});
  final MealDetail meal;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ingredients:',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        Table(border: TableBorder.all(), children: buildIngredientsList()),
      ],
    );
  }

  List<TableRow> buildIngredientsList() {
    List<TableRow> ingredientsWidgets = [];
    for (int i = 1; i <= 20; i++) {
      String? ingredient = meal.getIngredient(i);
      String? measure = meal.getMeasure(i);
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredientsWidgets.add(
          TableRow(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(ingredient),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("$measure"),
            ),
          ]),
        );
      }
    }
    return ingredientsWidgets;
  }
}
