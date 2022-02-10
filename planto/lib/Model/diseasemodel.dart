class DiseaseModel {
  final String id;
  final String name;
  //final String imageUrl;

  DiseaseModel({
    this.id,
    this.name,
    /* this.imageUrl */
  });
  factory DiseaseModel.fromJson(Map<String, dynamic> json) {
    return DiseaseModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
