import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CrudPage extends StatefulWidget {
  @override
  _CrudPageState createState() => _CrudPageState();
}

class _CrudPageState extends State<CrudPage> {
  final CollectionReference _itemsCollection =
      FirebaseFirestore.instance.collection('items');

  // Fungsi untuk menampilkan dialog pilihan makanan
  Future<void> _showMenuOptions(BuildContext context) async {
    final List<Map<String, String>> _menuMakanan = [
      {'title': 'Nasi Goreng', 'description': 'Nasi goreng dengan ayam dan sayuran.'},
      {'title': 'Mie Goreng', 'description': 'Mie goreng pedas manis.'},
      {'title': 'Sate Ayam', 'description': 'Sate ayam dengan bumbu kacang.'},
      {'title': 'Bakso', 'description': 'Bakso daging sapi dengan kuah segar.'},
      {'title': 'Ayam Bakar', 'description': 'Ayam bakar dengan sambal terasi.'},
    ];

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Pilih Menu Makanan',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: _menuMakanan.length,
              itemBuilder: (context, index) {
                final menu = _menuMakanan[index];
                return ListTile(
                  title: Text(menu['title']!),
                  subtitle: Text(menu['description']!),
                  onTap: () async {
                    // Tambahkan menu ke Firestore
                    await _itemsCollection.add({
                      'title': menu['title'],
                      'description': menu['description'],
                      'createdAt': FieldValue.serverTimestamp(),
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  // Fungsi Update
  Future<void> _updateItem(
      BuildContext context, String docId, String currentTitle, String currentDescription) async {
    final TextEditingController titleController =
        TextEditingController(text: currentTitle);
    final TextEditingController descriptionController =
        TextEditingController(text: currentDescription);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Menu Makanan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Nama Menu'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                if (titleController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  // Update data ke Firestore
                  await _itemsCollection.doc(docId).update({
                    'title': titleController.text,
                    'description': descriptionController.text,
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

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              final docId = item.id;
              final title = item['title'];
              final description = item['description'];

              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  title: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _updateItem(context, docId, title, description),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _itemsCollection.doc(docId).delete(),
                      ),
                    ],
                  ),
                ),
              );
            },
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
