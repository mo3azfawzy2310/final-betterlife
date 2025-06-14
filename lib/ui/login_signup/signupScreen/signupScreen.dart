import 'package:better_life/ui/login_signup/buildTextField.dart';
import 'package:better_life/ui/login_signup/loginScreen/loginScreen.dart';
import 'package:better_life/utils/ButtonStyles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../utils/dialog_utils.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = 'Sign Up Screen';

  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isButtonEnabled = false;
  bool isChecked = false;
  bool isObscure = true;
  bool isObscureConfirm = true;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "BetterLife",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 32, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          autovalidateMode: autoValidateMode,
          child: Column(
            children: [
              BuildTextField(
                  label: "Enter your Name",
                  icon: Icons.person,
                  onChanged: (_) => updateButtonState(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Name is required";
                    }
                    return null;
                  }
              ),
              const SizedBox(height: 15),
              BuildTextField(
                  label: "Enter your Username",
                  icon: Icons.account_circle,
                  onChanged: (_) => updateButtonState(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Username is required";
                    }
                    return null;
                  }
              ),
              const SizedBox(height: 15),
              BuildTextField(
                  label: "Enter your Email",
                  icon: Icons.email,
                  isEmail: true,
                  onChanged: (_) => updateButtonState(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Email is required";
                    }
                    RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                    if (!emailRegExp.hasMatch(value)) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  }
              ),
              const SizedBox(height: 15),
              BuildTextField(
                label: "Enter your Password",
                icon: Icons.lock,
                isPassword: true,
                controller: passwordController,
                isObscure: isObscure,
                onChanged: (_) => updateButtonState(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Password is required";
                  }
                  return null;
                },
                toggleObscure: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
              ),
              const SizedBox(height: 15),
              BuildTextField(
                label: "Enter your Confirmation Password",
                icon: Icons.lock,
                isPassword: true,
                controller: confirmPasswordController,
                isObscure: isObscureConfirm,
                onChanged: (_) => updateButtonState(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Confirmation Password is required";
                  }
                  if (value != passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
                toggleObscure: () {
                  setState(() {
                    isObscureConfirm = !isObscureConfirm;
                  });
                },
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value ?? false;
                      });
                      updateButtonState();
                    },
                    activeColor: Colors.green,
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                        children: [
                          const TextSpan(text: "I agree to the BetterLife"),
                          TextSpan(
                            text: "Terms of Services ",
                            style: TextStyle(color: Theme.of(context).colorScheme.secondary, decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                          const TextSpan(text: "and "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(color: Theme.of(context).colorScheme.secondary, decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isButtonEnabled ? () {
                    setState(() {
                      autoValidateMode = AutovalidateMode.always;
                    });
                    if (formKey.currentState?.validate() == true && isChecked) {
                      DialogUtils.showSuccessDialog(
                        context: context,
                        title: "Success",
                        message: "Your account has been successfully registered",
                        buttonText: "Login",
                        routeName: LoginScreen.routeName,
                      );
                    }
                  } : null,
                  style: ButtonStyles.primaryButtonStyle,
                  child: Text(
                    "Sign Up",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateButtonState() {
    final isFormValid = formKey.currentState?.validate() ?? false;
    setState(() {
      isButtonEnabled = isFormValid && isChecked;
    });
  }
}
