class Character {
  final int id;
  final String name;
  final String gender;
  final String intelligence;
  final String image;

  const Character({
    required this.id,
    required this.name,
    required this.gender,
    required this.intelligence,
    required this.image,
  });

  Character.fromJson(Map<String, dynamic> json)
      : id = int.parse(json["id"]),
        name = json["name"],
        gender = json["appearance"]["gender"],
        intelligence = json["powerstats"]["intelligence"],
        image = json["image"]["url"];

  Character.fromDatabaseMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        gender = map["gender"],
        intelligence = map["intelligence"],
        image = map["image"];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'intelligence': intelligence,
      'image': image
    };
  }
}
