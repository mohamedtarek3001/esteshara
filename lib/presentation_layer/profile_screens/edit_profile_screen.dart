import 'package:esteshara/business_logic/auth_cubit.dart';
import 'package:esteshara/core/constants/constants.dart';
import 'package:esteshara/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key,required this.userType});

  final String userType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2DACC9),
        centerTitle: true,
        title: const Text('Edit Profile'),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Container(
            height: ScreenSizing.height,
            width: ScreenSizing.width,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,),
                  CustomTextFormField(title: 'Name', hint: context.read<AuthCubit>().userData?.name??'Edit your Name', radius: 5,controller: context.read<AuthCubit>().nameController,),
                  userType != 'user'?
                  Column(
                    children: [
                      const SizedBox(height: 10,),
                      CustomTextFormField(title: 'Phone', hint: context.read<AuthCubit>().userData?.phone??'Edit your Phone', radius: 5,controller: context.read<AuthCubit>().phoneController,),
                      const SizedBox(height: 10,),
                      CustomTextFormField(title: 'Major', hint: context.read<AuthCubit>().userData?.major??'Edit your Major', radius: 5,controller: context.read<AuthCubit>().majorController,),
                      const SizedBox(height: 10,),
                      CustomTextFormField(title: 'About Me', hint: context.read<AuthCubit>().userData?.aboutMe??'Edit your About Me', radius: 5,controller: context.read<AuthCubit>().aboutMeController,),
                      const SizedBox(height: 10,),
                    ],
                  ):
                  Container(),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            bool isLoading = context.read<AuthCubit>().isLoading;
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2DACC9),
                  minimumSize: Size(ScreenSizing.width * 0.8, 50),
                  maximumSize: Size(ScreenSizing.width * 0.8, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)
                  )
              ),
              onPressed: () async {
                context.read<AuthCubit>().updateUserData();
                await context.read<AuthCubit>().editProfile();
                context.read<AuthCubit>().resetControllers();
                Navigator.pop(context);
              },
              child: isLoading
                  ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ))
                  : const Text(
                'Edit Profile',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      ),
    );
  }
}
