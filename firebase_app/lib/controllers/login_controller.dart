import 'package:get/get.dart';
import 'package:firebase_app/login/auth_sign_in_up_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var user = Rx<User?>(null);

  // Sign-In dengan Google
  Future<void> signInWithGoogle() async {
    try {
      isLoading(true);
      final User? result = await AuthSignInUpService.signInWithGoogle();
      if (result != null) {
        user.value = result;
      }
    } catch (e) {
      print('Error during Google Sign-In: $e');
    } finally {
      isLoading(false);
    }
  }

  // Sign-In dengan Email dan Password
  Future<void> signInWithEmail(String email, String password) async {
    try {
      isLoading(true);
      final User? result = await AuthSignInUpService.signInWithEmail(email, password);
      if (result != null) {
        user.value = result;
      }
    } catch (e) {
      print('Error during Email Sign-In: $e');
    } finally {
      isLoading(false);
    }
  }

  // Sign-Up dengan Email dan Password
  Future<void> signUpWithEmail(String email, String password) async {
    try {
      isLoading(true);
      final User? result = await AuthSignInUpService.signUpWithEmail(email, password);
      if (result != null) {
        user.value = result;
      }
    } catch (e) {
      print('Error during Email Sign-Up: $e');
    } finally {
      isLoading(false);
    }
  }

  // Sign out
  Future<void> signOut() async {
  try {
    // Start the sign-out process
    await AuthSignInUpService.signOut();
    
    // Clear the user data
    user.value = null;
    
    // Optionally, navigate the user back to the login page after sign-out
    Get.offAllNamed('/login');  // Replaces the entire stack with Login Page
  } catch (e) {
    print('Error during sign-out: $e');
  }
}

}
