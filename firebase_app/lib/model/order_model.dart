import 'menu_item_model.dart';

class Order {
  final String id;
  final String table;
  final List<MenuItem> menuList;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.table,
    required this.menuList,
    required this.createdAt,
  });

  // Metode toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'table': table,
      'menuList': menuList.map((menuItem) => menuItem.toMap()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Metode fromMap untuk parsing data dari Firestore (opsional)
  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] ?? '',
      table: map['table'] ?? '',
      menuList: (map['menuList'] as List<dynamic>)
          .map((menuItem) => MenuItem.fromMap(menuItem as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
