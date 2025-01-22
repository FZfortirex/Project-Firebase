import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/crud_controller.dart';

class AddMenuPage extends StatelessWidget {
  final CrudController controller = Get.put(CrudController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Menu'),
        backgroundColor: Colors.red.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.tableController,
              decoration: InputDecoration(labelText: 'Meja'),
            ),
            SizedBox(height: 20),
            // TextField untuk menambahkan menu dan deskripsi
            TextField(
              controller: controller.menuController,
              decoration: InputDecoration(labelText: 'Menu'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: controller.descriptionController,
              decoration: InputDecoration(labelText: 'Deskripsi'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.addMenu();
              },
              child: Text('Tambah Menu'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
              ),
            ),
            SizedBox(height: 20),
            // Menampilkan daftar menu yang sudah ditambahkan
            Obx(() {
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.selectedMenuList.length,
                  itemBuilder: (context, index) {
                    final menuItem = controller.selectedMenuList[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(menuItem['menu']),
                        subtitle: Text(menuItem['description']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Edit button
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                controller.editMenu(index);
                              },
                            ),
                            // Delete button
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                controller.deleteMenu(index);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.saveOrder();
                Get.back(); // Kembali ke halaman sebelumnya
              },
              child: Text('Simpan Pesanan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
