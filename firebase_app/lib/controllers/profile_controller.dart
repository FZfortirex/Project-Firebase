import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/login/auth_sign_in_up_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<User?> user = Rx<User?>(null);
  RxString email = 'Email tidak tersedia'.obs;
  RxString profileImageUrl = ''.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    user.value = _auth.currentUser;

    if (user.value != null) {
      fetchProfileData(user.value!.uid);
    } else {
      print("No user is currently logged in.");
    }
  }

  Future<void> fetchProfileData(String uid) async {
    isLoading(true);
    try {
      DocumentSnapshot userData =
          await _firestore.collection('users').doc(uid).get();

      if (userData.exists) {
        email.value = userData.get('email') ?? 'Email tidak tersedia';

        print("Email: ${email.value}");
        print("Profile Image URL: ${profileImageUrl.value}");
      } else {
        print("User document does not exist.");
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> logout() async {
    await AuthSignInUpService.signOut();
    isLoading(true);
    isLoading.value = false;
    Get.offAllNamed('/login');
  }
}
