import 'package:better_life/ui/logic/auth/auth_cubit.dart';
import 'package:better_life/ui/login_signup/loginScreen/loginScreen.dart';
import 'package:better_life/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogOutDialog{
  LogOutDialog(BuildContext context);

  static void showLogOutDialog(BuildContext context){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          // We need to create a new context that has access to BlocProvider
          return BlocProvider.value(
            value: BlocProvider.of<AuthCubit>(context),
            child: Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              child: Padding(padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.logout,size: 40,color: Color(0xFF199A8E),),
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    "Are you sure you want to log out?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30,),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthInitial) {
                        // Successfully logged out
                        Navigator.pop(context); // Close dialog
                        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                      } else if (state is AuthFailure) {
                        // Show error message
                        Navigator.pop(context); // Close dialog
                        DialogUtils.showErrorDialog(
                          context: context,
                          title: 'Logout Failed',
                          message: state.message,
                        );
                      }
                    },
                    builder: (context, state) {
                      return SizedBox(
                        width: 183,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: state is AuthLoading 
                              ? null // Disable button while loading
                              : () {
                                  context.read<AuthCubit>().logout();
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF199A8E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: state is AuthLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  "Log Out",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10,),
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF199A8E),
                        ),
                      ),
                  ),
                ],
              ),
              ),
            ),
          );
        },
    );
  }
}