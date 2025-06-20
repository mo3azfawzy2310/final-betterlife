import 'package:better_life/utils/ButtonStyles.dart';
import 'package:flutter/material.dart';
import 'package:better_life/ui/login_signup/buildTextField.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  static const String routeName = 'create new password';

  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isObscure = true;
  bool isConfirmObscure = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 32, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create New Password",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                "Your new password must be different from previously used password.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 30),
              BuildTextField(
                label: "New Password",
                icon: Icons.lock,
                isPassword: true,
                controller: passwordController,
                isObscure: isObscure,
                toggleObscure: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your new password";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              BuildTextField(
                label: "Confirm Password",
                icon: Icons.lock_outline,
                isPassword: true,
                controller: confirmPasswordController,
                isObscure: isConfirmObscure,
                toggleObscure: () {
                  setState(() {
                    isConfirmObscure = !isConfirmObscure;
                  });
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please confirm your password";
                  }
                  if (value != passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Password created successfully')),
                      );
                      Future.delayed(const Duration(seconds: 1),(){
                        Navigator.pop(context);
                      });
                    }
                  },
                  style: ButtonStyles.primaryButtonStyle,
                  child: const Text("Create Password"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
