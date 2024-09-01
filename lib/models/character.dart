class Character {
  String name;
  String description;
  String title;
  String vision;
  String nation;
  int rarity;
  String weapon;
  String id;

  Character({
    required this.name,
    required this.description,
    required this.title,
    required this.vision,
    required this.nation,
    required this.rarity,
    required this.weapon,
    required this.id,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'] ?? "No name",
      description: json['description'] ?? "No description",
      title: json['title'] ?? "No title",
      vision: json['vision'] ?? "No vision",
      nation: json['nation'] ?? "Unknown",
      rarity: json['rarity'] ?? 0,
      weapon: json['weapon'] ?? "Unknown",
      id: json['id'] ?? "",
    );
  }
}
