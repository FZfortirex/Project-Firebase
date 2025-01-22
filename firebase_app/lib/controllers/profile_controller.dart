import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<User?> user = Rx<User?>(null);
  RxString email = ''.obs;
  RxString profileImageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    user.value = _auth.currentUser;
    if (user.value != null) {
      _fetchProfileData(user.value!.uid);
    }
  }

  void _fetchProfileData(String uid) async {
    try {
      DocumentSnapshot userData = await _firestore.collection('users').doc(uid).get();
      if (userData.exists) {
        email.value = userData['email'];
        profileImageUrl.value = userData['profileImageUrl'] ?? '';
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed('/login');  // Navigasi ke halaman login
  }
}
