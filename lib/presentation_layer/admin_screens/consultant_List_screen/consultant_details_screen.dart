import 'package:esteshara/business_logic/auth_cubit.dart';
import 'package:esteshara/core/constants/constants.dart';
import 'package:esteshara/generated/assets.dart';
import 'package:esteshara/models/user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/custom_main_buttons.dart';

class ConsultantDetailsScreen extends StatelessWidget {
  const ConsultantDetailsScreen({super.key, required this.consultant});

  final UserDataModel? consultant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: ScreenSizing.height,
          width: ScreenSizing.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 230,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(
                            Assets.imagesDetailsCover,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                          const Spacer()
                        ],
                      ),
                    ),
                    const Positioned(
                        bottom: 0,
                        left: 10,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage(Assets.imagesConsultantAvatar),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 19,
                              color: Color(0xff2DACC9),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              '${consultant?.name}',
                              style: const TextStyle(
                                fontSize: 19,
                                color: Color(0xffA8A8A8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Specialization',
                            style: TextStyle(
                              fontSize: 19,
                              color: Color(0xff2DACC9),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              '${consultant?.major}',
                              style: const TextStyle(
                                fontSize: 19,
                                color: Color(0xffA8A8A8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Bio',
                            style: TextStyle(
                              fontSize: 19,
                              color: Color(0xff2DACC9),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              '${consultant?.aboutMe}',
                              style: const TextStyle(
                                fontSize: 19,
                                color: Color(0xffA8A8A8),
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Rate',
                            style: TextStyle(
                              fontSize: 19,
                              color: Color(0xff2DACC9),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              '${consultant?.rate ?? 0}',
                              style: const TextStyle(
                                fontSize: 19,
                                color: Color(0xffA8A8A8),
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                consultant?.verified == false
                    ? Center(
                        child: BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            bool isLoading = context.read<AuthCubit>().isLoading;
                            return CustomSignIn_UpOne(
                              title: 'Verify Consultant',
                              customizeChild: isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'Verify Consultant',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                              ontap: () async {

                                await context.read<AuthCubit>().verifyConsultant(consultant!);
                               await context.read<AuthCubit>().getUsers('user',true);
                               Navigator.canPop(context)?Navigator.pop(context):null;
                              },
                              color: const Color(0xff2DACC9),
                            );
                          },
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
