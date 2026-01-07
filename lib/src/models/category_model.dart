class CategoryModel {
  final String image;
  final String name;
  CategoryModel({required this.image, required this.name});
}

List<CategoryModel> categoryModel = [
  CategoryModel(image: 'assets/art.jpg', name: "Art"),
  CategoryModel(image: 'assets/enter.jpg', name: "Entertainment"),
  CategoryModel(image: 'assets/fashion.jpg', name: "Fashion"),
  CategoryModel(image: 'assets/game.jpg', name: "Game"),
  CategoryModel(image: 'assets/sport.jpg', name: "Sport"),
  CategoryModel(image: 'assets/tech.jpg', name: "Technology"),
];
