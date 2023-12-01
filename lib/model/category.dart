class Category {
  final String id;
  final String title;
  final String thumbnailUrl;

  Category({
    required this.id,
    required this.title,
    required this.thumbnailUrl
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['idCategory'],
      title: json['strCategory'],
      thumbnailUrl: json['strCategoryThumb'],
    );
  }
}