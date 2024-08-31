class Character {
  String name;
  String description;
  String title;
  String vision;
  String nation;
  int rarity;
  String weapon;
  String queryName;

  Character({
    required this.name,
    required this.description,
    required this.title,
    required this.vision,
    required this.nation,
    required this.rarity,
    required this.weapon,
    required this.queryName,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'],
      description: json['description'],
      title: json['title'],
      vision: json['vision'],
      nation: json['nation'],
      rarity: json['rarity'],
      weapon: json['weapon'],
      queryName: json['name']?.toLowerCase().replaceAll(' ', '-') ?? "",
    );
  }
}
