import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 7 Signup Form',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const SignupScreen(),
    );
  }
}

// -------------------- SIGNUP SCREEN --------------------

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // GlobalKey dùng để kiểm tra trạng thái của Form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controller dùng để lấy nội dung người dùng nhập
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  // FocusNode dùng để chuyển con trỏ giữa các ô nhập
  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  @override
  void dispose() {
    // Giải phóng controller và focus node khi màn hình bị hủy
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    nameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();

    super.dispose();
  }

  // -------------------- VALIDATORS --------------------

  // Kiểm tra Full Name
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    return null;
  }

  // Kiểm tra Email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    // Theo đề bài: email tối thiểu phải có @ và .
    if (!value.contains('@') || !value.contains('.')) {
      return 'Enter a valid email';
    }

    return null;
  }

  // Kiểm tra Password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    // RegExp kiểm tra password có ít nhất 1 số
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least 1 digit';
    }

    return null;
  }

  // Kiểm tra Confirm Password
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }

    if (value != passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  // -------------------- SUBMIT FORM --------------------

  void submitForm() {
    // Ẩn bàn phím khi bấm Submit
    FocusScope.of(context).unfocus();

    // validate() sẽ chạy tất cả validator trong Form
    bool isValid = formKey.currentState!.validate();

    // Nếu form sai thì không submit
    if (!isValid) {
      return;
    }

    // Nếu form đúng thì lưu form
    formKey.currentState!.save();

    // Hiển thị thông báo thành công
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Signup successful!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Bấm ra ngoài ô nhập thì ẩn bàn phím
      onTap: () {
        FocusScope.of(context).unfocus();
      },

      child: Scaffold(
        appBar: AppBar(
          title: const Text('Signup'),
        ),

        // ListView giúp form cuộn được khi bàn phím mở
        body: Form(
          key: formKey,

          // Tự validate sau khi người dùng bắt đầu nhập
          autovalidateMode: AutovalidateMode.onUserInteraction,

          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Create Account',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 24),

              // -------------------- FULL NAME --------------------

              TextFormField(
                controller: nameController,
                focusNode: nameFocus,

                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),

                // Nút Next trên bàn phím
                textInputAction: TextInputAction.next,

                // Khi bấm Next thì chuyển sang Email
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(emailFocus);
                },

                validator: validateName,
              ),

              const SizedBox(height: 16),

              // -------------------- EMAIL --------------------

              TextFormField(
                controller: emailController,
                focusNode: emailFocus,

                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),

                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,

                // Khi bấm Next thì chuyển sang Password
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(passwordFocus);
                },

                validator: validateEmail,
              ),

              const SizedBox(height: 16),

              // -------------------- PASSWORD --------------------

              TextFormField(
                controller: passwordController,
                focusNode: passwordFocus,

                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),

                // Ẩn ký tự password
                obscureText: true,

                textInputAction: TextInputAction.next,

                // Khi bấm Next thì chuyển sang Confirm Password
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(confirmPasswordFocus);
                },

                validator: validatePassword,
              ),

              const SizedBox(height: 16),

              // -------------------- CONFIRM PASSWORD --------------------

              TextFormField(
                controller: confirmPasswordController,
                focusNode: confirmPasswordFocus,

                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),

                obscureText: true,

                // Ô cuối cùng dùng nút Done
                textInputAction: TextInputAction.done,

                // Khi bấm Done thì submit form
                onFieldSubmitted: (value) {
                  submitForm();
                },

                validator: validateConfirmPassword,
              ),

              const SizedBox(height: 24),

              // -------------------- SUBMIT BUTTON --------------------

              ElevatedButton(
                onPressed: submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}