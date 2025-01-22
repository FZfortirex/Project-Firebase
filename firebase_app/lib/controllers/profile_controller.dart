import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observables for user profile data and loading state
  Rx<User?> user = Rx<User?>(null);
  RxString email = 'Email tidak tersedia'.obs;
  RxString profileImageUrl = ''.obs;
  RxBool isLoading = false.obs; // Loading state

  @override
  void onInit() {
    super.onInit();
    // Get the current logged-in user
    user.value = _auth.currentUser;

    // If user is logged in, fetch profile data
    if (user.value != null) {
      fetchProfileData(user.value!.uid);
    } else {
      print("No user is currently logged in.");
    }
  }

  // Fetch user profile data from Firestore
  Future<void> fetchProfileData(String uid) async {
    isLoading(true); // Set loading to true
    try {
      // Fetch the user document from Firestore based on UID
      DocumentSnapshot userData = await _firestore.collection('users').doc(uid).get();

      if (userData.exists) {
        // Update profile data if user document exists
        email.value = userData.get('email') ?? 'Email tidak tersedia';
        profileImageUrl.value = userData.get('profileImageUrl') ?? '';
      } else {
        print("User document does not exist.");
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      isLoading(false); // Set loading to false
    }
  }

  // Logout function
  Future<void> logout() async {
    try {
      isLoading(true); // Set loading to true
      await _auth.signOut(); // Sign out from Firebase
      user.value = null; // Reset user data
      Get.offAllNamed('/login'); // Navigate to login page
    } catch (e) {
      print("Error during logout: $e");
    } finally {
      isLoading(false); // Set loading to false
    }
  }
}
