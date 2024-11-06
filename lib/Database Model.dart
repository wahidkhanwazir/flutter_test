class NoteModel {
  final int? id;
  final String name;
  final String title;
  final String category;
  final dynamic duration;
  final String type;
  final dynamic price;
  final String description;

  NoteModel({
    this.id,
    required this.name,
    required this.title,
    required this.category,
    required this.duration,
    required this.type,
    required this.price,
    required this.description,
  });

  NoteModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        name = res['name'],
        title = res['title'],
        category = res['category'],
        duration = res['duration'],
        type = res['type'],
        price = res['price'],
        description = res['description'];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'title': title,
      'category': category,
      'duration': duration,
      'type': type,
      'price': price,
      'description': description,
    };
  }
}
