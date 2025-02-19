import 'package:esteshara/core/constants/constants.dart';
import 'package:esteshara/generated/assets.dart';
import 'package:esteshara/presentation_layer/main_app/chatting_screens/consultant_chat_screen.dart';
import 'package:esteshara/widgets/custom_main_buttons.dart';
import 'package:flutter/material.dart';

class ConsultantDetails extends StatelessWidget {
  const ConsultantDetails({super.key});

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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 19,
                              color: Color(0xff2DACC9),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Text(
                              'khaled',
                              style: TextStyle(
                                fontSize: 19,
                                color: Color(0xffA8A8A8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text(
                            'Specialization',
                            style: TextStyle(
                              fontSize: 19,
                              color: Color(0xff2DACC9),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Text(
                              'Hardware specialty',
                              style: TextStyle(
                                fontSize: 19,
                                color: Color(0xffA8A8A8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bio',
                            style: TextStyle(
                              fontSize: 19,
                              color: Color(0xff2DACC9),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                            child: Text(
                              'Nearly 5 years of experience.Technical Director and Co-Founder at Aaram Group in  Istanbul. Developer andManager of Aaram CRM and Link  CRM systems forcustomer relationship management.',
                              style: TextStyle(
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
                const SizedBox(height: 20,),
                Center(
                  child: CustomSignIn_UpOne(title: 'Go To Chat',ontap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(),),);
                  },color: const Color(0xff2DACC9),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
