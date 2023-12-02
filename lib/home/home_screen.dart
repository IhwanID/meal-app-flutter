import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meal_app/home/widget/category_chip_widget.dart';
import 'package:meal_app/home/widget/meal_card.dart';
import 'dart:convert';

import 'package:meal_app/model/category.dart';
import 'package:meal_app/model/meal.dart';
import 'package:meal_app/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Category> categories = [];
  Category? selectedCategory;
  List<Meal> meals = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('${Constants.baseUrl}/categories.php'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> categoriesData = data['categories'];

      setState(() {
        categories = categoriesData
            .map((category) => Category.fromJson(category))
            .toList();
        selectedCategory = categories[0];

        fetchMeal();
      });
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<void> fetchMeal() async {
    final response = await http.get(Uri.parse(
        '${Constants.baseUrl}/filter.php?c=${selectedCategory?.title}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> mealsData = data['meals'];

      setState(() {
        meals = mealsData.map((category) => Meal.fromJson(category)).toList();
      });
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Meal App', style: TextStyle(color: Colors.black)),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: categories.isEmpty ? const Center(child: CircularProgressIndicator(color: Colors.amber,),) : SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 75,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: categories
                      .map((item) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = item;
                              fetchMeal();
                            });
                          },
                          child: CategoryChipWidget(
                            label: item.title,
                            imageUrl: item.thumbnailUrl,
                            isSelected: item.id == selectedCategory?.id,
                          )))
                      .toList(),
                ),
              ),
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: meals.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MealCard(meal: meals[index]);
                  })
            ],
          ),
        ));
  }
}
