class MenuItem {
  final String menu;
  final String description;

  MenuItem({
    required this.menu,
    required this.description,
  });

  // Metode toMap
  Map<String, dynamic> toMap() {
    return {
      'menu': menu,
      'description': description,
    };
  }

  // Metode fromMap untuk parsing data dari Firestore (opsional)
  factory MenuItem.fromMap(Map<String, dynamic> map) {
    return MenuItem(
      menu: map['menu'] ?? '',
      description: map['description'] ?? '',
    );
  }
}
