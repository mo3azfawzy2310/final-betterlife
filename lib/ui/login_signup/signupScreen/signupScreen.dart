import 'dart:developer';

import 'package:better_life/models/regester_model.dart';
import 'package:better_life/ui/home/homeScreen.dart';
import 'package:better_life/ui/logic/auth/auth_cubit.dart';
import 'package:better_life/ui/login_signup/buildTextField.dart';
import 'package:better_life/utils/ButtonStyles.dart';
import 'package:better_life/utils/dialog_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
  final formKey = GlobalKey<FormState>();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String? selectedGender;

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    birthDateController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            log("Error during registration: ${state.message}");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Registration failed: ${state.message}"),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Registration successful!"),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is AuthLoading,
            child: Scaffold(
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
                  icon: const Icon(Icons.chevron_left,
                      size: 32, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    autovalidateMode: autoValidateMode,
                    child: Column(
                      children: [
                        // Google Sign Up Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            icon: Image.asset(
                              "assets/images/icons/google_icon.png",
                              height: 24,
                            ),
                            label: Text(
                              "Sign up with Google",
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: Colors.black87,
                              ),
                            ),
                            onPressed: () async {
                              try {
                                await context.read<AuthCubit>().signInWithGoogle();
                              } catch (e) {
                                if (context.mounted) {
                                  DialogUtils.showErrorDialog(
                                    context: context,
                                    title: 'Google Sign-Up Failed',
                                    message: e.toString(),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text("OR", style: TextStyle(color: Colors.grey)),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 20),
                        
                        BuildTextField(
                          label: "Enter your Name",
                          icon: Icons.person,
                          controller: nameController,
                          onChanged: (_) => updateButtonState(),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Name is required";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        BuildTextField(
                          label: "Enter your Username",
                          icon: Icons.account_circle,
                          controller: usernameController,
                          onChanged: (_) => updateButtonState(),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Username is required";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: BuildTextField(
                                label: "Phone Number",
                                icon: Icons.phone,
                                controller: phoneController,
                                onChanged: (_) => updateButtonState(),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Phone number is required";
                                  }
                                  if (!RegExp(r'^\d{10,15}$').hasMatch(value)) {
                                    return "Enter a valid phone number";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime(2000),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                  );
                                  if (picked != null) {
                                    setState(() {
                                      birthDateController.text =
                                          "${picked.toLocal()}".split(' ')[0];
                                    });
                                  }
                                },
                                child: AbsorbPointer(
                                  child: BuildTextField(
                                    label: "Birth Date",
                                    icon: Icons.calendar_today,
                                    controller: birthDateController,
                                    onChanged: (_) => updateButtonState(),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return "Birth date is required";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: selectedGender,
                                decoration: InputDecoration(
                                  labelText: "Gender",
                                  prefixIcon: const Icon(Icons.person_outline),
                                  border: const OutlineInputBorder(),
                                ),
                                items: ['Male', 'Female', 'Other']
                                    .map((gender) => DropdownMenuItem(
                                          value: gender,
                                          child: Text(gender),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value;
                                  });
                                  updateButtonState();
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please select a gender";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: BuildTextField(
                                label: "Address",
                                icon: Icons.home,
                                controller: addressController,
                                onChanged: (_) => updateButtonState(),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Address is required";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Divider(thickness: 1),
                        const SizedBox(height: 20),
                        BuildTextField(
                          label: "Enter your Email",
                          icon: Icons.email,
                          controller: emailController,
                          isEmail: true,
                          onChanged: (_) => updateButtonState(),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Email is required";
                            }
                            RegExp emailRegExp = RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                            if (!emailRegExp.hasMatch(value)) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
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
                            if (value.length < 6) {
                              return "Password must be at least 6 characters";
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
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.color),
                                  children: [
                                    const TextSpan(
                                        text: "I agree to the BetterLife "),
                                    TextSpan(
                                      text: "Terms of Services ",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          decoration: TextDecoration.underline),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                    ),
                                    const TextSpan(text: "and "),
                                    TextSpan(
                                      text: "Privacy Policy",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          decoration: TextDecoration.underline),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: isButtonEnabled
                                ? () async {
                                    setState(() {
                                      autoValidateMode =
                                          AutovalidateMode.always;
                                    });
                                    if (formKey.currentState?.validate() ==
                                            true &&
                                        isChecked) {
                                      try {
                                        await context.read<AuthCubit>().registerUser(
                                              RegisterRequestModel(
                                                  phoneNumber:
                                                      phoneController.text,
                                                  role: "Patient",
                                                  userName:
                                                      usernameController.text,
                                                  password:
                                                      passwordController.text,
                                                  email: emailController.text,
                                                  displayName:
                                                      nameController.text,
                                                  address: addressController.text,
                                                  birthDate:
                                                      birthDateController.text,
                                                  gender: selectedGender ?? "",
                                                  name: nameController.text),
                                            );
                                      } catch (e) {
                                        if (context.mounted) {
                                          DialogUtils.showErrorDialog(
                                            context: context,
                                            title: 'Registration Failed',
                                            message: e.toString(),
                                          );
                                        }
                                      }
                                    }
                                  }
                                : null,
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
              ),
            ),
          );
        },
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
