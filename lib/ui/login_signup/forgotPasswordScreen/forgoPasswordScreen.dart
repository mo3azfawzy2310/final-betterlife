import 'package:better_life/ui/login_signup/forgotPasswordScreen/verificationScreen.dart';
import 'package:better_life/utils/ButtonStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:better_life/utils/validators.dart';

class ForgotPassword extends StatefulWidget {
  static const String routeName = 'forgot password';

  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController inputController = TextEditingController();

  String selectedOption = "email";
  bool isButtonEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 32, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Forgot Your Password?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Enter your email or your phone number, we will send you a confirmation code.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey.withOpacity(0.4)),
                  color: const Color(0xFFF9FAFB), // Make background transparent
                ),
                child: Row(
                  children: [
                    // Email option
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedOption = "email";
                            inputController.clear();
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: selectedOption == "email"
                                ? const Color(0xFF199A8E).withOpacity(0.1)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            "Email",
                            style: TextStyle(
                              color: selectedOption == "email"
                                  ? const Color(0xFF199A8E)
                                  : Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Phone option
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedOption = "phone";
                            inputController.clear();
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: selectedOption == "phone"
                                ? const Color(0xFF199A8E).withOpacity(0.1)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            "Phone",
                            style: TextStyle(
                              color: selectedOption == "phone"
                                  ? const Color(0xFF199A8E)
                                  : Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Input field based on selected option
              TextFormField(
                controller: inputController,
                decoration: InputDecoration(
                  labelText: selectedOption == "email"
                      ? "Enter Your Email"
                      : "Enter Your Phone",
                  prefixIcon: Icon(
                    selectedOption == "email" ? Icons.email : Icons.phone,
                    color: const Color(0xFF199A8E),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                keyboardType: selectedOption == "email"
                    ? TextInputType.emailAddress
                    : TextInputType.phone,
                inputFormatters: selectedOption == "phone"
                    ? [FilteringTextInputFormatter.digitsOnly,
                       LengthLimitingTextInputFormatter(12),
                      ]
                    : [],
                onChanged: (_) => updateButtonState(),
              ),
              const SizedBox(height: 30),
              // Reset Password Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isButtonEnabled? () {
                    String input = inputController.text.trim();
                    if (selectedOption == "email" && !Validators.isValidEmail(input)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please enter a valid email address")),
                      );
                      return;
                    }
                    if (selectedOption == "phone" && !Validators.isValidPhone(input)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Phone number must be between 6 and 12 digits")),
                      );
                      return;
                    }
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerificationScreen(userInput: inputController.text,),
                      ),
                    );
                  }
                  : null,
                  style: ButtonStyles.primaryButtonStyle,
                  child: const Text(
                    "Reset Password",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  updateButtonState() {
    setState(() {
      // Button is always enabled
      isButtonEnabled = inputController.text.isNotEmpty;
    });
  }
}
