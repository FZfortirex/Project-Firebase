import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CrudPage extends StatefulWidget {
  @override
  _CrudPageState createState() => _CrudPageState();
}

class _CrudPageState extends State<CrudPage> {
  final CollectionReference _itemsCollection =
      FirebaseFirestore.instance.collection('itemss');
  final List<String> _menuMakanan = [
    'Nasi Goreng',
    'Mie Goreng',
    'Sate Ayam',
    'Bakso',
    'Ayam Bakar',
  ];

  // Fungsi untuk menampilkan dialog pilihan makanan
  Future<void> _showMenuOptions(BuildContext context) async {
    final TextEditingController tableController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    String? selectedMenu;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Pilih Menu Makanan',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: tableController,
                    decoration: const InputDecoration(
                      labelText: 'Nomor Meja',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  // Dropdown untuk memilih menu
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Pilih Menu',
                      border: OutlineInputBorder(),
                    ),
                    value: selectedMenu,
                    items: _menuMakanan
                        .map((menu) => DropdownMenuItem<String>(
                              value: menu,
                              child: Text(menu),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMenu = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  // Form untuk mengisi deskripsi
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Deskripsi',
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                if (tableController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty &&
                    selectedMenu != null) {
                  await _itemsCollection.add({
                    'order': selectedMenu,
                    'description': descriptionController.text,
                    'table': tableController.text,
                    'createdAt': FieldValue.serverTimestamp(),
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk update item
  Future<void> _updateItem(
      BuildContext context, String docId, String currentOrder, String currentDescription, String currentTable) async {
    final TextEditingController tableController = TextEditingController(text: currentTable);
    final TextEditingController descriptionController = TextEditingController(text: currentDescription);
    String? selectedMenu = currentOrder;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Menu Makanan'),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: tableController,
                    decoration: const InputDecoration(labelText: 'Nomor Meja'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  // Dropdown untuk memilih menu (memiliki nilai default)
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Pilih Menu',
                      border: OutlineInputBorder(),
                    ),
                    value: selectedMenu,
                    items: _menuMakanan
                        .map((menu) => DropdownMenuItem<String>(
                              value: menu,
                              child: Text(menu),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMenu = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  // Form untuk mengisi deskripsi
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Deskripsi'),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                if (selectedMenu != null &&
                    tableController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  await _itemsCollection.doc(docId).update({
                    'order': selectedMenu,
                    'description': descriptionController.text,
                    'table': tableController.text,
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      appBar: AppBar(
        title: const Text('Menu Restoran'),
        backgroundColor: Colors.orange.shade700,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            _itemsCollection.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          }

          final data = snapshot.data?.docs;

          if (data == null || data.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada menu tersedia',
                style: TextStyle(color: Colors.brown),
              ),
            );
          }

          return Container(
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                final docId = item.id;
                final order = item['order'];
                final description = item['description'];
                final table = item['table'];

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    title: Text(
                      order,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('$description\nMeja: $table'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _updateItem(
                              context, docId, order, description, table),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _itemsCollection.doc(docId).delete();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () => _showMenuOptions(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
