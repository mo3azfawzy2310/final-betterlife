import 'package:flutter/material.dart';
class BuildTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPassword;
  final bool isEmail;
  final bool confirmPassword;
  final TextEditingController? controller;
  final bool isObscure;
  final VoidCallback? toggleObscure;
  final TextEditingController? passwordController;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onChanged;

  const BuildTextField({
    super.key,
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.isEmail = false,
    this.confirmPassword = false,
    this.controller,
    this.isObscure = false,
    this.toggleObscure,
    this.passwordController,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? isObscure : false,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        prefixIcon: Icon(icon, color: Colors.black.withOpacity(0.5)),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            isObscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.black.withOpacity(0.5),
          ),
          onPressed: toggleObscure,
        )
            : null,
      ),
      onChanged: onChanged,
    );
  }
}
