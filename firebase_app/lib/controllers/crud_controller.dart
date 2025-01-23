import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrudController extends GetxController {
  final CollectionReference ordersCollection =
      FirebaseFirestore.instance.collection('orders');
  final TextEditingController tableController = TextEditingController();
  final TextEditingController menuController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  RxList<Map<String, dynamic>> selectedMenuList = <Map<String, dynamic>>[].obs;

  // Menghapus pesanan berdasarkan docId
  Future<void> deleteOrder(String docId) async {
    try {
      await ordersCollection.doc(docId).delete();
    } catch (e) {
      print("Error deleting order: $e");
    }
  }

  // Menghapus menu dari daftar
  void deleteMenu(int index) {
    selectedMenuList.removeAt(index); // Hapus menu yang dipilih
  }

  // Menambahkan menu ke dalam daftar selectedMenuList
  void addMenu() {
    if (menuController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
      selectedMenuList.add({
        'menu': menuController.text,
        'description': descriptionController.text,
      });
      menuController.clear(); // Bersihkan input menu
      descriptionController.clear(); // Bersihkan input deskripsi
    } else {
      Get.snackbar("Input Error", "Menu dan Deskripsi tidak boleh kosong", snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Menyimpan pesanan ke Firestore
  Future<void> saveOrder() async {
    if (tableController.text.isNotEmpty && selectedMenuList.isNotEmpty) {
      try {
        await ordersCollection.add({
          'table': tableController.text,
          'menuList': selectedMenuList,
          'createdAt': FieldValue.serverTimestamp(),
        });
        clearFields(); // Bersihkan setelah menyimpan
        Get.back(); // Kembali ke halaman sebelumnya setelah menyimpan
      } catch (e) {
        Get.snackbar("Error", "Gagal menyimpan pesanan", snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar("Input Error", "Meja dan menu harus diisi", snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Menghapus semua inputan dan menu yang ada
  void clearFields() {
    tableController.clear();
    menuController.clear();
    descriptionController.clear();
    selectedMenuList.clear();
  }

  // Mengedit menu yang ada
  void editMenu(int index) {
    final selectedMenu = selectedMenuList[index];
    menuController.text = selectedMenu['menu'];
    descriptionController.text = selectedMenu['description'];

    // Hapus menu yang ada sebelum menambahkan yang baru
    selectedMenuList.removeAt(index);
  }
}
