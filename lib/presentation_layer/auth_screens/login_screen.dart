import 'package:esteshara/business_logic/auth_cubit.dart';
import 'package:esteshara/core/constants/constants.dart';
import 'package:esteshara/presentation_layer/auth_screens/create_account_screen.dart';
import 'package:esteshara/presentation_layer/auth_screens/create_consultant_account.dart';
import 'package:esteshara/presentation_layer/auth_screens/forget_password_screen.dart';
import 'package:esteshara/presentation_layer/main_app/main_hub.dart';
import 'package:esteshara/widgets/custom_main_buttons.dart';
import 'package:esteshara/widgets/custom_password_form_field.dart';
import 'package:esteshara/widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generated/assets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void goToCreateAccountScreen(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.blue[900]),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateAccountScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Create User',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      indent: 10,
                      endIndent: 10,
                    ),
                  ),
                  Text('Or'),
                  Expanded(
                    child: Divider(
                      indent: 10,
                      endIndent: 10,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 20,
                    backgroundColor: Colors.blue),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateConsultantAccount(),
                    ),
                  );
                },
                child: const Text(
                  'Create Consultant',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Container(
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
                margin: const EdgeInsets.only(top: 10),
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
                            'Welcome Back',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Fill out the information below in order to access your account',
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
                              bool isLoading = context.read<AuthCubit>().isLoading;
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomSignIn_UpOne(
                                    title: 'Log in',
                                    customizeChild: isLoading
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          )
                                        : const Text(
                                            'Log in',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                    ontap: () async {
                                      var res = await context.read<AuthCubit>().signInWithEmail();

                                      if (res == null) {
                                        Navigator.pushReplacement(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) => const MainHub(),
                                            ));
                                      }
                                    },
                                    color: Colors.blue[900],
                                    padding: const EdgeInsets.only(bottom: 5),
                                  ),
                                ],
                              );
                            },
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgetPasswordScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Forget Password?',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomSignIn_UpOne(
                                title: 'Create Account',
                                customizeChild: const Text(
                                  'Create Account',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                ontap: () {
                                  goToCreateAccountScreen(context);
                                },
                                color: Colors.grey[400],
                                padding: const EdgeInsets.only(top: 5),
                              ),
                            ],
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
            'Log In',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
          ),
          Divider(
            thickness: 3,
            color: Colors.blue[900]!,
            endIndent: ScreenSizing.width * 0.3,
            indent: ScreenSizing.width * 0.3,
          ),
        ],
      ),
    );
  }
}
