import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mengambil controller menggunakan GetX
    final ProfileController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
        backgroundColor: Colors.red.shade700,
      ),
      body: Obx(() {
        // Menggunakan Obx untuk merespon perubahan data
        if (controller.user.value == null) {
          return Center(child: CircularProgressIndicator());
        }

        // Jika data pengguna sudah diambil
        return Padding(
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
                    : AssetImage('assets/default_profile.png') as ImageProvider,
                backgroundColor: Colors.grey.shade200,
              ),
              SizedBox(height: 20),
              // Email
              Text(
                controller.email.value.isNotEmpty
                    ? controller.email.value
                    : 'Email tidak tersedia',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.red.shade700,
                ),
              ),
              SizedBox(height: 20),
              // Tombol Logout
              ElevatedButton(
                onPressed: () => controller.logout(),
                child: Text('Log Out'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
