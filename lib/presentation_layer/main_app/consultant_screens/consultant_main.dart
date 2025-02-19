import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:esteshara/core/constants/constants.dart';
import 'package:esteshara/presentation_layer/main_app/consultant_screens/consultant_details.dart';
import 'package:flutter/material.dart';

import '../../../generated/assets.dart';

class ConsultantMain extends StatelessWidget {
  const ConsultantMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: ScreenSizing.height,
          width: ScreenSizing.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 200,
                      width: ScreenSizing.width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            Assets.imagesConsultantCover,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Text(
                      "Book a consultation with our experts to get personalized"
                      " guidance to achieve your digital goals efficiently.",
                      style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff2DACC9), fontSize: 12),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Our best consultants',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xff2DACC9),
                          fontSize: 17,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xff2DACC9),
                          decorationThickness: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AutoHeightGridView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        builder: (context, index) {
                          return InkWell(onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ConsultantDetails(),));
                          },child: const ConsultantTile());
                        },
                        itemCount: 10,
                      ),
                    ],
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

class ConsultantTile extends StatelessWidget {
  const ConsultantTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 175,
          width: ScreenSizing.width,
        ),
        Container(
          height: 150,
          width: ScreenSizing.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xff2DACC9),
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 35,
              ),
              const Text(
                'khaled',
                style: TextStyle(
                  color: Color(0xff2DACC9),
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Major:',
                      style: TextStyle(
                        color: Color(0xff2DACC9),
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      ' Hardware',
                      style: TextStyle(
                        color: Color(0xff2DACC9),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Text(
                'available',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(Assets.imagesConsultantAvatar),
              ),
              Container(
                height: 20,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xff2DACC9),
                    )),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        size: 20,
                        color: Color(0xff2DACC9),
                      ),
                      Text(
                        '4.5',
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
