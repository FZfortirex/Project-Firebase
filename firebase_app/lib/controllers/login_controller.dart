import 'package:get/get.dart';
import 'package:firebase_app/login/auth_sign_in_up_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  // Rx untuk memantau state
  var isLoading = false.obs; // Indikator proses sedang berjalan
  var user = Rx<User?>(null); // Data pengguna yang sedang login

  // Sign-In dengan Google
  Future<void> signInWithGoogle() async {
    try {
      isLoading(true); // Tampilkan loading
      final User? result = await AuthSignInUpService.signInWithGoogle();
      if (result != null) {
        user.value = result; // Update data pengguna
        Get.offAllNamed('/profile'); // Navigasi ke halaman profil setelah login
      } else {
        Get.snackbar('Gagal Login', 'Tidak dapat login menggunakan Google');
      }
    } catch (e) {
      print('Error during Google Sign-In: $e');
      Get.snackbar('Error', 'Gagal login dengan Google. Silakan coba lagi.');
    } finally {
      isLoading(false); // Sembunyikan loading
    }
  }

  // Sign-In dengan Email dan Password
  Future<void> signInWithEmail(String email, String password) async {
    try {
      isLoading(true);
      final User? result =
          await AuthSignInUpService.signInWithEmail(email, password);
      if (result != null) {
        user.value = result;
        Get.offAllNamed('/profile');
      } else {
        Get.snackbar('Gagal Login', 'Email atau password salah.');
      }
    } catch (e) {
      print('Error during Email Sign-In: $e');
      Get.snackbar('Error', 'Terjadi kesalahan saat login. Silakan coba lagi.');
    } finally {
      isLoading(false);
    }
  }

  // Sign-Up dengan Email dan Password
  Future<void> signUpWithEmail(String email, String password) async {
    try {
      isLoading(true);
      final User? result =
          await AuthSignInUpService.signUpWithEmail(email, password);
      if (result != null) {
        user.value = result;
        Get.offAllNamed('/profile'); // Arahkan pengguna ke halaman profil
      } else {
        Get.snackbar(
            'Gagal Registrasi', 'Tidak dapat membuat akun. Coba lagi.');
      }
    } catch (e) {
      print('Error during Email Sign-Up: $e');
      Get.snackbar(
          'Error', 'Terjadi kesalahan saat registrasi. Silakan coba lagi.');
    } finally {
      isLoading(false);
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      isLoading(true); // Tampilkan loading
      await AuthSignInUpService.signOut(); // Proses sign-out
      user.value = null; // Hapus data pengguna
      Get.offAllNamed('/login'); // Arahkan ke halaman login
    } catch (e) {
      print('Error during sign-out: $e');
      Get.snackbar(
          'Error', 'Gagal logout. Silakan coba lagi.'); // Tampilkan error
    } finally {
      isLoading(false); // Sembunyikan loading
    }
  }
}
