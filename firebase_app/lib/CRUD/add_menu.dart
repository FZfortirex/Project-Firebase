import 'package:firebase_app/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/crud_controller.dart';
import '../model/menu_item_model.dart';
import '../widgets/my_button.dart';

class AddMenuPage extends StatelessWidget {
  final CrudController controller = Get.put(CrudController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Menu', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
        backgroundColor: Colors.red.shade700,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Tambah Menu Restoran',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Isi form berikut untuk menambahkan menu ke daftar.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: controller.tableController,
                labelText: 'Meja',
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: controller.menuController,
                labelText: 'Menu',
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: controller.descriptionController,
                labelText: 'Deskripsi',
              ),
              SizedBox(height: 30),
              MyButton(
                buttonText: 'Tambah Menu',
                backgroundColor: Colors.red.shade700,
                foregroundColor: Colors.white,
                onPressed: () {
                  controller.addMenu();
                },
                width: double.infinity,
                height: 50,
              ),
              SizedBox(height: 30),
              Obx(() {
                return controller.selectedMenuList.isEmpty
                    ? Center(
                        child: Text(
                          "Belum ada menu ditambahkan",
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade500),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.selectedMenuList.length,
                        itemBuilder: (context, index) {
                          final menuItem = controller.selectedMenuList[index];
                          return _buildMenuCard(menuItem, index);
                        },
                      );
              }),
              SizedBox(height: 20),
              MyButton(
                buttonText: 'Simpan Pesanan',
                backgroundColor: Colors.green.shade600,
                foregroundColor: Colors.white,
                onPressed: () {
                  controller.saveOrder();
                  Get.back();
                },
                width: double.infinity,
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(MenuItem menuItem, int index) {
    return GestureDetector(
      onTap: () {
        controller.editMenu(index);
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 8,
        shadowColor: Colors.grey.shade300,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          title: Text(
            menuItem.menu,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          subtitle: Text(
            menuItem.description,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.orange.shade700),
                onPressed: () => controller.editMenu(index),
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red.shade600),
                onPressed: () => controller.deleteMenu(index),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
