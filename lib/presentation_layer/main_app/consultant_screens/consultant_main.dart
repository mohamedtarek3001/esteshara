import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:esteshara/business_logic/auth_cubit.dart';
import 'package:esteshara/core/constants/constants.dart';
import 'package:esteshara/presentation_layer/main_app/consultant_screens/consultant_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/assets.dart';

class ConsultantMain extends StatefulWidget {
  const ConsultantMain({super.key});

  @override
  State<ConsultantMain> createState() => _ConsultantMainState();
}

class _ConsultantMainState extends State<ConsultantMain> {

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<AuthCubit>(context).getUsers('user',true);
    super.initState();
  }

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
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          if(context.read<AuthCubit>().isLoading){
                            return const Center(child: CircularProgressIndicator(),);
                          }
                          var users = context.read<AuthCubit>().filteredUsers;
                          print(users);
                          return AutoHeightGridView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            builder: (context, index) {
                              return users?[index].userType != "user"? InkWell(
                                  onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ConsultantDetails(consultant: users?[index],),));
                              }, child: ConsultantTile(name: users?[index].name.toString()??'',major: users?[index].major.toString()??'',rate: users?[index].rate ?? 0,)):
                              Container();
                            },
                            itemCount: users?.length??0,
                          );
                        },
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
  const ConsultantTile({super.key,required this.name,required this.major,required this.rate});
  final String name;
  final String major;
  final double rate;

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
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 35,
              ),
              Text(
                '${name}',
                style: const TextStyle(
                  color: Color(0xff2DACC9),
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Major:',
                      style: TextStyle(
                        color: Color(0xff2DACC9),
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      ' ${major}',
                      style: const TextStyle(
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
                child:  Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        size: 20,
                        color: Color(0xff2DACC9),
                      ),
                      Text(
                        rate.toString(),
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
