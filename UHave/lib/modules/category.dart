final String tableCategory='category';

class categoryFields{
  static final List<String> values = [
    /// Add all fields
    category_id, category_name
  ];
  static final String category_id = '_category_id';
  static final String category_name = 'category_name';
}

class category{
  final int? category_id;
  final String category_name;

  const category({
    this.category_id,
    required this.category_name
  });
  category Copy({
    int? category_id,
    String? category_name
  }) =>
      category(
          category_id: category_id ?? this.category_id,
          category_name: category_name ?? this.category_name
      );
  static category fromJson(Map<String, Object?>json) => category(
    category_id: json[categoryFields.category_id] as int?,
    category_name: json[categoryFields.category_name] as String,
  );
  Map<String, Object?> toJson() => {
    categoryFields.category_id : category_id,
    categoryFields.category_name: category_id
  };
}