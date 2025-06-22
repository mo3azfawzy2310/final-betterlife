import 'package:better_life/ui/logic/auth/auth_cubit.dart';
import 'package:better_life/ui/login_signup/buildSocialButtons.dart';
import 'package:better_life/ui/login_signup/forgotPasswordScreen/forgoPasswordScreen.dart';
import 'package:better_life/ui/login_signup/signupScreen/signupScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../providers/authProvider.dart';
import '../../../utils/ButtonStyles.dart';
import '../../../utils/dialog_utils.dart';
import '../../home/homeScreen.dart';
import '../buildTextField.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login screen';

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool isObscure = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Authentication failed: ${state.message}"),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is AuthLoading,
            progressIndicator: const CircularProgressIndicator(),
            child: Scaffold(
              backgroundColor: theme.scaffoldBackgroundColor,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  "Login",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                leading: IconButton(
                  icon: Icon(Icons.chevron_left,
                      size: 32, color: theme.colorScheme.onSurface),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        BuildTextField(
                          label: "Enter your email",
                          icon: Icons.email,
                          controller: emailController,
                          isEmail: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your email";
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        BuildTextField(
                          label: "Enter your password",
                          icon: Icons.lock,
                          controller: passwordController,
                          isPassword: true,
                          isObscure: isObscure,
                          toggleObscure: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your password";
                            }
                            if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgotPassword()));
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(color: theme.primaryColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                try {
                                  await context.read<AuthCubit>().loginUser(
                                      email: emailController.text,
                                      password: passwordController.text);
                                } catch (e) {
                                  if (context.mounted) {
                                    DialogUtils.showErrorDialog(
                                      context: context,
                                      title: 'Login Failed',
                                      message: e.toString(),
                                    );
                                  }
                                }
                              }
                            },
                            style: ButtonStyles.primaryButtonStyle,
                            child: Text(
                              "Login",
                              style: theme.textTheme.labelMedium,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.5)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, SignUpScreen.routeName);
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(color: theme.primaryColor),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: theme.dividerColor.withOpacity(0.5),
                                thickness: 1,
                                endIndent: 10,
                              ),
                            ),
                            Text(
                              "OR",
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: theme.textTheme.bodyLarge?.color
                                    ?.withOpacity(0.7),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: theme.dividerColor.withOpacity(0.5),
                                thickness: 1,
                                indent: 10,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () async {
                            try {
                              await context.read<AuthCubit>().signInWithGoogle();
                            } catch (e) {
                              if (context.mounted) {
                                DialogUtils.showErrorDialog(
                                  context: context,
                                  title: 'Google Sign-In Failed',
                                  message: e.toString(),
                                );
                              }
                            }
                          },
                          child: buildSocialButtons(
                            text: "Sign in with Google",
                            icon: "assets/images/icons/google_icon.png",
                          ),
                        ),
                        const SizedBox(height: 15),
                        buildSocialButtons(
                          text: "Sign in with Apple",
                          icon: "assets/images/icons/apple_icon.png",
                        ),
                        const SizedBox(height: 15),
                        buildSocialButtons(
                          text: "Sign in with Facebook",
                          icon: "assets/images/icons/facebook_icon.png",
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
}
