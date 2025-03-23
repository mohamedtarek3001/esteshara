import 'package:esteshara/business_logic/auth_cubit.dart';
import 'package:esteshara/business_logic/page_control_cubit.dart';
import 'package:esteshara/core/constants/constants.dart';
import 'package:esteshara/generated/assets.dart';
import 'package:esteshara/presentation_layer/main_app/chatting_screens/ai_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainHome extends StatelessWidget {
  const MainHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: ScreenSizing.height,
          width: ScreenSizing.width,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 27,
                    backgroundImage: AssetImage(Assets.imagesProfilePlaceholder),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return Text(
                        context.read<AuthCubit>().userData?.name ?? '',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff9147BA),
                        ),
                      );
                    },
                  ),

                  // Spacer(),
                  // Icon(
                  //   Icons.notifications_none_outlined,
                  //   color: Color(0xff9147BA),
                  //   size: 30,
                  // )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              FractionallySizedBox(
                widthFactor: 1.07,
                child: Image.asset(Assets.imagesBanner),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'IT infrastructure Consulting',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xff9147BA)),
                              ),
                              Text(
                                'To ensure the security and efficiency of your solutions, we assess your existing infrastructure and consult on how to effectively modify and maintain your current solutions.',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffB4B3B3),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          Assets.imagesFirstItem,
                          width: 90,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Accurate analysis',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xff9147BA)),
                              ),
                              Text(
                                'We conduct a deep and accurate analysis of your local and global market needs to design technology solutions that are compatible with your goals.',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffB4B3B3),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          Assets.imagesSecondItem,
                          width: 90,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Solutions for technical consulting',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xff9147BA)),
                              ),
                              Text(
                                'Keeping your business goals in mind, we help you choose IT solutions and technologies that will meet your needs with maximum efficiency.',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffB4B3B3),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          Assets.imagesThirdItem,
                          width: 90,
                        )
                      ],
                    ),
                  ]),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: BlocBuilder<PageControlCubit, PageControlState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            context.read<PageControlCubit>().setSelectedPage(1);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: Color(0xff9147BA),
                              ),
                            ),
                            backgroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Human Consultation',
                            style: TextStyle(color: Color(0xff9147BA), fontSize: 14),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AIChatScreen(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Color(0xff9147BA),
                          ),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'AI Consultation',
                        style: TextStyle(color: Color(0xff9147BA), fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
