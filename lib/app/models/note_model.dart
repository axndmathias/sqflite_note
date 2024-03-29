class NoteModel {
  final int? id;
  final String title;
  final String description;

  const NoteModel({required this.title, required this.description, this.id});

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
      id: json['id'], title: json['title'], description: json['description']);

  Map<String, dynamic> toJson() =>
      {'id': id, 'title': title, 'description': description};
}
