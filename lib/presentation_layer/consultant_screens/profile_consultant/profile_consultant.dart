import 'package:esteshara/business_logic/auth_cubit.dart';
import 'package:esteshara/business_logic/page_control_cubit.dart';
import 'package:esteshara/core/constants/constants.dart';
import 'package:esteshara/generated/assets.dart';
import 'package:esteshara/presentation_layer/auth_screens/login_screen.dart';
import 'package:esteshara/presentation_layer/profile_screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../chat_requests_screens/chat_requests_screen.dart';

class ProfileConsultant extends StatelessWidget {
  const ProfileConsultant({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: ScreenSizing.height,
          width: ScreenSizing.width,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            children: [
              SizedBox(
                height: ScreenSizing.height * 0.07,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 160,
                  ),
                  CircleAvatar(
                    radius: 70,
                    child: Image.asset(Assets.imagesProfilePlaceholder),
                  ),
                  // Positioned(
                  //   bottom: 5,
                  //   right: 7,
                  //   child: IconButton(
                  //       style: IconButton.styleFrom(backgroundColor: const Color(0xff2DACC9)),
                  //       onPressed: () {},
                  //       icon: SvgPicture.asset(
                  //         Assets.imagesEditingIcon,
                  //         height: 25,
                  //         fit: BoxFit.contain,
                  //       )),
                  // ),
                ],
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return Text(
                    '${context.read<AuthCubit>().userData?.name}',
                    style: const TextStyle(color: Color(0xff2DACC9), fontWeight: FontWeight.bold, fontSize: 20),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ProfileTile(
                title: 'Previous Consultants',
                image: Assets.imagesPrevConsultants,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConsultantChatRequestsScreen(
                        isActive: false,
                        isApproved: true,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ProfileTile(
                title: 'Current Consultant',
                image: Assets.imagesCurrentConsultant,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConsultantChatRequestsScreen(
                        isActive: true,
                        isApproved: true,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ProfileTile(
                title: 'Review',
                image: Assets.imagesReviews,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Current Review'),
                      content: SizedBox(
                        height: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Your rating',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xff2DACC9)),
                            ),
                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                print((context.read<AuthCubit>().userData?.rate??0).toStringAsFixed(1));
                                return RatingBar.builder(
                                  initialRating: double.tryParse((context.read<AuthCubit>().userData?.rate??0).toStringAsFixed(1))??0,
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  ignoreGestures: true,
                                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {},
                                );
                              },
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: ScreenSizing.height * 0.1,
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  bool isLoading = context.read<AuthCubit>().isLoading;
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff2DACC9), minimumSize: Size(ScreenSizing.width * 0.8, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                    onPressed: () async {
                      context.read<AuthCubit>().initControllers();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(
                            userType: context.read<AuthCubit>().userData?.userType ?? '',
                          ),
                        ),
                      );
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
              const Spacer(),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  bool isLoading = context.read<AuthCubit>().isLoading;
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff2DACC9),
                      minimumSize: Size(ScreenSizing.width * 0.8, 50),
                    ),
                    onPressed: () async {
                      await context.read<AuthCubit>().signOut();
                      BlocProvider.of<PageControlCubit>(context).reset();
                      Navigator.popUntil(
                        context,
                        (route) => route.isFirst,
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                        : const Text(
                            'Logout',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                  );
                },
              ),
              const SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.image,
    required this.title,
    this.onTap,
  });

  final String image;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: ScreenSizing.width,
        child: Row(
          children: [
            Container(
                height: 30,
                width: 30,
                child: SvgPicture.asset(
                  image,
                  height: 30,
                  width: 20,
                  fit: BoxFit.contain,
                )),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: const TextStyle(color: Color(0xff2DACC9), fontWeight: FontWeight.bold, fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
