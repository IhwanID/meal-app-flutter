import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meal_app/detail/widget/ingredients_widget.dart';
import 'package:meal_app/detail/widget/instruction_widget.dart';
import 'dart:convert';

import 'package:meal_app/model/meal_detail.dart';
import 'package:meal_app/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  MealDetail? meal;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('${Constants.baseUrl}/lookup.php?i=${widget.id}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final Map<String, dynamic> mealData = data['meals'][0];

      setState(() {
        meal = MealDetail.fromJson(mealData);
      });
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: meal == null
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            )
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  leading: const BackButton(
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  expandedHeight: 200.0,
                  pinned: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      meal?.strMealThumb ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              meal?.strMeal ?? '',
                              style: const TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                Chip(label: Text(meal?.strCategory ?? '')),
                                const SizedBox(width: 8.0),
                                Chip(label: Text(meal?.strArea ?? '')),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            IngredientsWidget(meal: meal!),
                            const SizedBox(height: 16.0),
                            InstructionsWidget(meal: meal!),
                            const SizedBox(height: 16.0),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await launchUrl(
                                          Uri.parse(meal?.strYoutube ?? ''));
                                    },
                                    child: const Text('Watch Video'),
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await launchUrl(
                                          Uri.parse(meal?.strSource ?? ''));
                                    },
                                    child: const Text('View Source'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
