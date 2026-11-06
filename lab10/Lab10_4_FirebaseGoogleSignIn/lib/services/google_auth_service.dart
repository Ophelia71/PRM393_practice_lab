import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../firebase_options.dart';
import '../models/app_user.dart';

class GoogleAuthService {
  static bool isConfigured = false;
  static String? configurationError;

  static Future<void> initialize() async {
    if (isConfigured) return;
    try {
      // FlutterFire CLI sinh options thật. Không dùng API key hay project ID giả.
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      if (!kIsWeb) await GoogleSignIn.instance.initialize();
      isConfigured = true;
      configurationError = null;
    } catch (_) {
      configurationError = 'Chưa kết nối Firebase. Làm theo FIREBASE_SETUP.md rồi khởi động lại ứng dụng.';
    }
  }

  Future<AppUser> signIn() async {
    if (!isConfigured) {
      throw StateError(configurationError ?? 'Chưa cấu hình Firebase.');
    }
    UserCredential result;
    if (kIsWeb) {
      // Trên web Firebase hỗ trợ cửa sổ đăng nhập Google trực tiếp.
      result = await FirebaseAuth.instance.signInWithPopup(
        GoogleAuthProvider(),
      );
    } else {
      final account = await GoogleSignIn.instance.authenticate();
      final credential = GoogleAuthProvider.credential(
        idToken: account.authentication.idToken,
      );
      result = await FirebaseAuth.instance.signInWithCredential(credential);
    }
    return _toUser(result.user!);
  }

  Future<AppUser?> restore() async {
    if (!isConfigured) return null;
    // Chờ Firebase đọc phiên đã lưu, đặc biệt cần thiết trên trình duyệt.
    final user = await FirebaseAuth.instance.authStateChanges().first;
    return user == null ? null : _toUser(user);
  }

  AppUser _toUser(User user) {
    return AppUser(
      name: user.displayName ?? 'Google User',
      email: user.email ?? '',
    );
  }

  Future<void> signOut() async {
    if (!isConfigured) return;
    await FirebaseAuth.instance.signOut();
    if (!kIsWeb) await GoogleSignIn.instance.signOut();
  }
}
