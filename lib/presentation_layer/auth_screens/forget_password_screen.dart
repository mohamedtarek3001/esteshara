import 'package:esteshara/business_logic/auth_cubit.dart';
import 'package:esteshara/core/constants/constants.dart';
import 'package:esteshara/widgets/custom_main_buttons.dart';
import 'package:esteshara/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Container(
        height: ScreenSizing.height,
        width: ScreenSizing.width,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Forget Password',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              Text(
                'We will send you an email with a link to reset your password, please enter the email associated with your account.',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey[700]),
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return CustomTextFormField2(
                    title: 'Your email address..',
                    hint: 'Please enter your email address',
                    controller: context.read<AuthCubit>().emailController,
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  bool isLoading = context.read<AuthCubit>().isLoading;
                  return CustomSignIn_UpFour(
                    title: 'Send Link',
                    customizeChild: isLoading
                        ? const Center(child: CircularProgressIndicator(color: Colors.white,))
                        : const Text(
                            'Send Link',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                    color: Colors.blue[900],
                    ontap: () {
                      context.read<AuthCubit>().resetPassword();
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
