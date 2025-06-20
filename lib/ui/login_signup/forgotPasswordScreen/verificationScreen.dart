import 'package:better_life/ui/login_signup/forgotPasswordScreen/creatNewPassword.dart';
import 'package:better_life/utils/ButtonStyles.dart';
import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  static const String routName = "verification screen";
  final String userInput;

  const VerificationScreen({super.key, required this.userInput});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController codeController = TextEditingController();

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter Verification Code",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Enter the code that we have sent to your ${widget.userInput.contains('@') ? 'email' : 'phone'}: ${widget.userInput}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 40),
            PinCodeTextField(
              appContext: context,
              controller: codeController,
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              autoFocus: true,
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(12),
                fieldHeight: 55,
                fieldWidth: 50,
                activeColor: const Color(0xFF199A8E),
                selectedColor: Colors.grey.shade400,
                inactiveColor: Colors.grey.shade300,
                activeFillColor: Colors.grey.shade100,
                selectedFillColor: Colors.white,
                inactiveFillColor: Colors.grey.shade100,
              ),
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              onChanged: (value) {
                // we can put logic here if we need
              },
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CreateNewPasswordScreen()),
                  );

                  print("Entered Code: ${codeController.text}");
                },
                style: ButtonStyles.primaryButtonStyle,
                child: const Text(
                  "Verify",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Align(
                alignment: Alignment.center,
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: "Didn't receive the code? ",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      TextSpan(
                        text: "Resend",
                        style: const TextStyle(
                          color: Color(0xFF199A8E),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {
                        },
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
