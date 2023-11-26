class TarotCard {
  final String name;
  final int number;
  final String description;

  TarotCard({
    required this.name,
    required this.number,
    required this.description,
  });

  factory TarotCard.fromJson(Map<String, dynamic> json) {
    return TarotCard(
      name: json['name'],
      number: json['number'],
      description: json['description'],
    );
  }
}
