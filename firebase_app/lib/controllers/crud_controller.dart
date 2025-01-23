import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/model/menu_item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_app/model/order_model.dart' as app;

class CrudController extends GetxController {
  final CollectionReference ordersCollection =
      FirebaseFirestore.instance.collection('orders');
  final TextEditingController tableController = TextEditingController();
  final TextEditingController menuController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  RxList<MenuItem> selectedMenuList = <MenuItem>[].obs;

  Future<void> deleteOrder(String docId) async {
    try {
      await ordersCollection.doc(docId).delete();
    } catch (e) {
      print("Error deleting order: $e");
    }
  }

  void deleteMenu(int index) {
    selectedMenuList.removeAt(index);
  }

  void addMenu() {
    if (menuController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      selectedMenuList.add(
        MenuItem(
          menu: menuController.text,
          description: descriptionController.text,
        ),
      );
      menuController.clear();
      descriptionController.clear();
    } else {
      Get.snackbar("Input Error", "Menu dan Deskripsi tidak boleh kosong",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> saveOrder() async {
    if (tableController.text.isNotEmpty && selectedMenuList.isNotEmpty) {
      try {
        await ordersCollection.add(app.Order(
          id: '',
          table: tableController.text,
          menuList: selectedMenuList.toList(),
          createdAt: DateTime.now(),
        ).toMap());

        clearFields();
        Get.back();
      } catch (e) {
        Get.snackbar("Error", "Gagal menyimpan pesanan",
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar("Input Error", "Meja dan menu harus diisi",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void clearFields() {
    tableController.clear();
    menuController.clear();
    descriptionController.clear();
    selectedMenuList.clear();
  }

  void editMenu(int index) {
    final selectedMenu = selectedMenuList[index];
    menuController.text = selectedMenu.menu;
    descriptionController.text = selectedMenu.description;

    selectedMenuList.removeAt(index);
  }
}