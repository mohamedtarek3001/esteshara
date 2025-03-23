import 'package:esteshara/business_logic/auth_cubit.dart';
import 'package:esteshara/core/constants/constants.dart';
import 'package:esteshara/generated/assets.dart';
import 'package:esteshara/widgets/custom_main_buttons.dart';
import 'package:esteshara/widgets/custom_password_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/custom_text_form_field.dart';

class CreateConsultantAccount extends StatelessWidget {
  const CreateConsultantAccount({super.key});

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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const AuthTitleWidget(),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Create Consultant Account',
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
                              hint: 'Please enter your email',
                              controller: context.read<AuthCubit>().emailController,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return CustomTextFormField(
                              title: 'Name',
                              hint: 'Please enter your Name',
                              controller: context.read<AuthCubit>().nameController,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return CustomTextFormField(
                              title: 'Phone',
                              hint: 'Please enter your Phone number',
                              controller: context.read<AuthCubit>().phoneController,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return CustomTextFormField(
                              title: 'About me',
                              hint: ' Enter About you',
                              controller: context.read<AuthCubit>().aboutMeController,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return CustomTextFormField(
                              title: 'Major',
                              hint: ' Enter About your major',
                              controller: context.read<AuthCubit>().majorController,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return InkWell(
                              onTap: () {
                                context.read<AuthCubit>().pickPdf();
                              },
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                height: 55,
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]!, width: 1),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          context.read<AuthCubit>().selectedPdf?.path.split('/').last ?? 'Put your Cv here....',
                                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.picture_as_pdf_outlined,
                                      color: Colors.grey[600],
                                    ),
                                  ],
                                ),
                              ),
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
                              isVisible: context.read<AuthCubit>().isVisible,
                              controller: context.read<AuthCubit>().passwordController,
                              onTap: () {
                                context.read<AuthCubit>().togglePasswordVisibility();
                              },
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
                              isVisible: context.read<AuthCubit>().isVisible,
                              onTap: () {
                                context.read<AuthCubit>().togglePasswordVisibility();
                              },
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
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ))
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
                                      await context.read<AuthCubit>().createConsultantProfile();
                                      Navigator.popUntil(
                                        context,
                                        (route) => route.isFirst,
                                      );
                                      showCupertinoDialog(
                                        context: context,
                                        builder: (context) => CupertinoAlertDialog(
                                            title: const Text(
                                              'Success',
                                              style: TextStyle(color: Colors.greenAccent, fontSize: 20),
                                            ),
                                            content: const Text('Account created successfully\nPlease wait for the Admin to verify it..', style: TextStyle(color: Colors.black, fontSize: 18)),
                                            actions: [
                                              CupertinoButton(
                                                child: const Text('Ok'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ]),
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
                        const SizedBox(
                          height: 10,
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
