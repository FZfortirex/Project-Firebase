import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/crud_controller.dart';
import '../model/menu_item_model.dart';

class AddMenuPage extends StatelessWidget {
  final CrudController controller = Get.put(CrudController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Menu'),
        backgroundColor: Colors.red.shade700,
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
              _buildTextField(controller.tableController, 'Meja'),
              SizedBox(height: 20),
              _buildTextField(controller.menuController, 'Menu'),
              SizedBox(height: 10),
              _buildTextField(controller.descriptionController, 'Deskripsi'),
              SizedBox(height: 30),
              _buildActionButton('Tambah Menu', Colors.red.shade700, () {
                controller.addMenu();
              }),
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
              _buildActionButton('Simpan Pesanan', Colors.green.shade600, () {
                controller.saveOrder();
                Get.back();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black54),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, Color color, VoidCallback onPressed) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [color.withOpacity(0.8), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
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