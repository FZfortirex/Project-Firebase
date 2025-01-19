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

  Future<void> _showMenuOptions(BuildContext context) async {
    final TextEditingController tableController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    String? selectedMenu;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white.withOpacity(0.95),
          title: const Text(
            'Pilih Menu Makanan',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orange,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: tableController,
                    decoration: InputDecoration(
                      labelText: 'Nomor Meja',
                      labelStyle: TextStyle(color: Colors.orange.shade700),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.orange.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.orange.shade700),
                      ),
                      filled: true,
                      fillColor: Colors.orange.shade50,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Pilih Menu',
                      labelStyle: TextStyle(color: Colors.orange.shade700),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.orange.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.orange.shade700),
                      ),
                      filled: true,
                      fillColor: Colors.orange.shade50,
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
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Deskripsi',
                      labelStyle: TextStyle(color: Colors.orange.shade700),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.orange.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.orange.shade700),
                      ),
                      filled: true,
                      fillColor: Colors.orange.shade50,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Batal',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
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
              child: const Text('Simpan', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateItem(
      BuildContext context, String docId, String currentOrder, String currentDescription, String currentTable) async {
    final TextEditingController tableController = TextEditingController(text: currentTable);
    final TextEditingController descriptionController = TextEditingController(text: currentDescription);
    String? selectedMenu = currentOrder;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white.withOpacity(0.95),
          title: Text(
            'Edit Menu Makanan',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade700,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: tableController,
                    decoration: InputDecoration(
                      labelText: 'Nomor Meja',
                      labelStyle: TextStyle(color: Colors.orange.shade700),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.orange.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.orange.shade700),
                      ),
                      filled: true,
                      fillColor: Colors.orange.shade50,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Pilih Menu',
                      labelStyle: TextStyle(color: Colors.orange.shade700),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.orange.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.orange.shade700),
                      ),
                      filled: true,
                      fillColor: Colors.orange.shade50,
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
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Deskripsi',
                      labelStyle: TextStyle(color: Colors.orange.shade700),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.orange.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.orange.shade700),
                      ),
                      filled: true,
                      fillColor: Colors.orange.shade50,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Batal',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
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
              child: const Text('Simpan', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text(
          'Menu Restoran',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange.shade700,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            _itemsCollection.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange.shade700),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error fetching data',
                style: TextStyle(color: Colors.red.shade700),
              ),
            );
          }

          final data = snapshot.data?.docs;

          if (data == null || data.isEmpty) {
            return Center(
              child: Text(
                'Belum ada menu tersedia',
                style: TextStyle(
                  color: Colors.orange.shade700,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }

          return Container(
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                final docId = item.id;
                final order = item['order'];
                final description = item['description'];
                final table = item['table'];

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.orange.shade50,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        order,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.orange.shade900,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          '$description\nMeja: $table',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            height: 1.5,
                          ),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue.shade700),
                            onPressed: () => _updateItem(
                                context, docId, order, description, table),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red.shade700),
                            onPressed: () {
                              _itemsCollection.doc(docId).delete();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orange.shade700,
        onPressed: () => _showMenuOptions(context),
        icon: const Icon(Icons.add),
        label: const Text('Tambah Menu'),
      ),
    );
  }
}