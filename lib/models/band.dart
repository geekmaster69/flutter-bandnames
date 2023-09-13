class Band {
  final String id;
  final String name;
  final int vote;

  Band({required this.id, required this.name, required this.vote});

  factory Band.fromMap(Map<String, dynamic> obj) =>
      Band(id: obj['id'], name: obj['name'], vote: obj['votes']);
}
