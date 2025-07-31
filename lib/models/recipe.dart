class Recipe {
  final String id;
  final String title;
  final String description;
  final String? imagePath;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    this.imagePath,
  });

  Recipe copyWith({
    String? id,
    String? title,
    String? description,
    String? imagePath,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}