import 'package:esteshara/business_logic/chat_cubit.dart';
import 'package:esteshara/core/constants/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/auth_cubit.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home (Admin Dashboard)',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff2DACC9)),),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Container(
            height: ScreenSizing.height,
            width: ScreenSizing.width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: BlocBuilder<ChatCubit, ChatState>(
                      builder: (chatContext, state) {
                        return PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                value: (chatContext.read<ChatCubit>().activeRooms?.size ?? 0).toDouble() + 1,
                                showTitle: true,
                                radius: 50,
                                badgeWidget: Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.grey[700]!, spreadRadius: 1, blurRadius: 1, offset: const Offset(1, 2))]),
                                  child: Text(
                                    '${chatContext.read<ChatCubit>().activeRooms?.size ?? 0} Active rooms',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                gradient: const LinearGradient(
                                  colors: [Colors.purple, Colors.blue],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              PieChartSectionData(
                                showTitle: true,
                                value: (chatContext.read<ChatCubit>().inActiveRooms?.size ?? 0).toDouble() + 1,
                                radius: 50,
                                badgeWidget: Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.grey[700]!, spreadRadius: 1, blurRadius: 1, offset: const Offset(1, 2))]),
                                  child: Text(
                                    '${chatContext.read<ChatCubit>().inActiveRooms?.size.toString()} Inactive rooms',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                gradient: const LinearGradient(
                                  colors: [Colors.deepPurple, Colors.pink],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              PieChartSectionData(
                                value: (chatContext.read<ChatCubit>().notApprovedRooms?.size ?? 0).toDouble() + 1,
                                showTitle: true,
                                radius: 50,
                                badgeWidget: Container(
                                  height: 30,
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.grey[700]!, spreadRadius: 1, blurRadius: 1, offset: const Offset(1, 2))]),
                                  child: Text(
                                    '${chatContext.read<ChatCubit>().notApprovedRooms?.size ?? 0} Not Approved rooms',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                gradient: const LinearGradient(
                                  colors: [Colors.indigo, Colors.tealAccent],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BlocBuilder<ChatCubit, ChatState>(
                        builder: (chatContext, state) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.circle, color: Color(0xff2DACC9), size: 10),
                              Expanded(
                                  child: Text(
                                ' Number of Active users: ${context.read<AuthCubit>().users?.length ?? 0}',
                                style: const TextStyle(color: Color(0xff2DACC9), fontSize: 20),
                              )),
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<ChatCubit, ChatState>(
                        builder: (context, state) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.circle, color: Color(0xff2DACC9), size: 10),
                              Expanded(
                                  child: Text(
                                ' Number of consultants: ${context.read<AuthCubit>().filteredUsers?.length ?? 0}',
                                style: const TextStyle(color: Color(0xff2DACC9), fontSize: 20),
                              )),
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<ChatCubit, ChatState>(
                        builder: (context, state) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.circle, color: Color(0xff2DACC9), size: 10),
                              Expanded(
                                  child: Text(
                                ' Number of chats: ${(context.read<ChatCubit>().notApprovedRooms?.size ?? 0) + (context.read<ChatCubit>().inActiveRooms?.size ?? 0) + (context.read<ChatCubit>().activeRooms?.size ?? 0)}',
                                style: const TextStyle(color: Color(0xff2DACC9), fontSize: 20),
                              )),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
