class CategoriesModel{
  String label;
  String image;
  String id;

  CategoriesModel({required this.label,required this.image,required this.id});
  static List<CategoriesModel> getCategories(){
    return [
      CategoriesModel(label: "science", image: "assets/images/science.png", id: "science"),
      CategoriesModel(label: "Business", image: "assets/images/business.png", id: "business"),
      CategoriesModel(label: "entertainment", image: "assets/images/entertainment.png", id: "entertainment"),
      CategoriesModel(label: "health", image: "assets/images/health.png", id: "health"),
      CategoriesModel(label: "general", image: "assets/images/general.png", id: "general"),
      CategoriesModel(label: "technology", image: "assets/images/technology.png", id: "technology"),
      CategoriesModel(label: "sport", image: "assets/images/sport.png", id: "sport"),






    ];
  }
}