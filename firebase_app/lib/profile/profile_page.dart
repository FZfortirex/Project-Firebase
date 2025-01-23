import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileController controller;

  @override
  void initState() {
    super.initState();
    // Mengambil instance controller menggunakan GetX
    controller = Get.find<ProfileController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
        backgroundColor: Colors.red.shade700,
      ),
      body: Obx(() {
        // Memantau perubahan data menggunakan Obx
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(), // Loading indikator
          );
        }

        if (controller.user.value == null) {
          // Jika tidak ada data pengguna
          return Center(
            child: Text(
              'Tidak ada data pengguna',
              style: TextStyle(fontSize: 16, color: Colors.red.shade700),
            ),
          );
        }

        // Jika data pengguna sudah tersedia
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Gambar Profil
                CircleAvatar(
                  radius: 50,
                  backgroundImage: controller.profileImageUrl.value.isNotEmpty
                      ? NetworkImage(controller.profileImageUrl.value)
                      : const AssetImage('lib/assets/profile_picture.png')
                          as ImageProvider,
                  backgroundColor: Colors.grey.shade200,
                ),
                const SizedBox(height: 20),
                // Email Pengguna
                Text(
                  controller.email.value.isNotEmpty
                      ? controller.email.value
                      : 'Email tidak tersedia',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.red.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Tombol Logout
                ElevatedButton(
                  onPressed: () => controller.logout(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade700,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
