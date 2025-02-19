import 'package:esteshara/core/constants/constants.dart';
import 'package:esteshara/generated/assets.dart';
import 'package:esteshara/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2DACC9),
        automaticallyImplyLeading: false,
        leadingWidth: ScreenSizing.width * 0.5,
        toolbarHeight: kToolbarHeight * 1.2,
        leading: Row(children: [
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(Assets.imagesConsultantAvatar),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Khaled',
            style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
          )
        ]),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 25,
            ),
          )
        ],
      ),
      body: Container(
        height: ScreenSizing.height,
        width: ScreenSizing.width,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.imagesChatBackground,
                        width: ScreenSizing.width * 0.40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          'This space is for messaging your therapist.Here you can inquire directly about the sessions and everything related to them.Everything that happens between you and your therapist is completely confidential.',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[300]),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField3(
                    title: 'Write a message',
                    hint: 'Enter your message here....',
                  ),
                ),
                IconButton(
                  style: IconButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)), backgroundColor: Color(0xff2DACC9)),
                  onPressed: () {},
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
