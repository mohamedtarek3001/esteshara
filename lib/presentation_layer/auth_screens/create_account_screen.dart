import 'package:esteshara/core/constants/constants.dart';
import 'package:esteshara/generated/assets.dart';
import 'package:esteshara/widgets/custom_main_buttons.dart';
import 'package:esteshara/widgets/custom_password_form_field.dart';
import 'package:esteshara/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/auth_cubit.dart';
import '../main_app/main_hub.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Container(
        height: ScreenSizing.height,
        width: ScreenSizing.width,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.white,
              height: ScreenSizing.height * 0.19,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(
                Assets.imagesAppLogo,
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const AuthTitleWidget(),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Create Account',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Let\'s get started by filling out the form below',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey[700]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return CustomTextFormField(
                              title: 'Email',
                              hint: 'Please enter you email',
                              controller: context.read<AuthCubit>().emailController,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return CustomPasswordFormField(
                              title: 'Password',
                              hint: 'Please enter your password',
                              isVisible: false,
                              controller: context.read<AuthCubit>().passwordController,
                              onTap: () {},
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return CustomPasswordFormField(
                              title: 'Confirm Password',
                              hint: 'Please re-enter your password',
                              isVisible: false,
                              onTap: () {},
                              controller: context.read<AuthCubit>().passwordConfirmationController,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            bool isLoading = context.read<AuthCubit>().isLoading;
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomSignIn_UpOne(
                                  title: 'Get Started',
                                  customizeChild: isLoading
                                      ? const Center(child: CircularProgressIndicator(color: Colors.white,))
                                      : const Text(
                                          'Get Started',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                        ),
                                  ontap: () async {
                                    var res = await context.read<AuthCubit>().signUpWithEmail();
                                    if (res == null) {
                                      Navigator.popUntil(context, (route) => route.isFirst,);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const MainHub(),
                                        ),
                                      );
                                    }
                                  },
                                  color: Colors.blue[900],
                                  padding: const EdgeInsets.only(bottom: 5),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class AuthTitleWidget extends StatelessWidget {
  const AuthTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Create Account',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
          ),
          Divider(
            thickness: 3,
            color: Colors.blue[900]!,
            endIndent: ScreenSizing.width * 0.17,
            indent: ScreenSizing.width * 0.17,
          ),
        ],
      ),
    );
  }
}
