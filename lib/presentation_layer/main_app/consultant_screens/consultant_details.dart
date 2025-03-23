import 'package:esteshara/business_logic/auth_cubit.dart';
import 'package:esteshara/business_logic/chat_cubit.dart';
import 'package:esteshara/core/constants/constants.dart';
import 'package:esteshara/generated/assets.dart';
import 'package:esteshara/models/user_data_model.dart';
import 'package:esteshara/presentation_layer/main_app/chatting_screens/consultant_chat_screen.dart';
import 'package:esteshara/widgets/custom_main_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';

class ConsultantDetails extends StatelessWidget {
  const ConsultantDetails({super.key, required this.consultant});

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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: BlocBuilder<ChatCubit, ChatState>(
                    builder: (context, state) {
                      return CustomSignIn_UpOne(
                        title: 'Go To Chat',
                        ontap: () async {
                          var userId = context.read<ChatCubit>().firebaseAuth.currentUser?.uid;
                          Map<String,Map<bool,bool>> room = await context.read<ChatCubit>().getOrCreateChatRoom(consultantUid: consultant?.uid ?? '', userUid: userId ?? '', userName: BlocProvider.of<AuthCubit>(context).userData?.name ?? '', consultantName: consultant?.name ?? '');
                          if (room.entries.first.value.entries.first.key){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                  chatId: room.entries.first.key,
                                  userType: 'user',
                                  userName: consultant?.name ?? '',
                                  currentUserId: userId ?? '',
                                  isActive: room.entries.first.value.entries.first.value,
                                ),
                              ),
                            );
                          }else{
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              text: 'your room has been created successfully, and the request has been sent',
                              confirmBtnColor: Colors.amber[900]!,

                            );
                          }


                        },
                        color: const Color(0xff2DACC9),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
