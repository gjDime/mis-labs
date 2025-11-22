class Category {
  int id;
  String name;
  String image;
  String description;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
  });

  Category.fromJson(Map<String, dynamic> json)
    : id = int.parse(json['idCategory']),
      name = json['strCategory'],
      image = json['strCategoryThumb'],
      description = json['strCategoryDescription'];
}
