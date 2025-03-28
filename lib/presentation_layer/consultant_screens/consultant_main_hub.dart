import 'package:esteshara/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/page_control_cubit.dart';

class ConsultantMainHub extends StatelessWidget {
  const ConsultantMainHub({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: ScreenSizing.height,
        width: ScreenSizing.width,
        child: BlocBuilder<PageControlCubit, PageControlState>(
          builder: (context, state) {
            int selectedPage = context.read<PageControlCubit>().selectedPage;
            return context.read<PageControlCubit>().consultantScreens[selectedPage];
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<PageControlCubit, PageControlState>(
        builder: (context, state) {
          return BottomNavigationBar(
            onTap: (index) {
              context.read<PageControlCubit>().setSelectedPage(index);
            },
            type: BottomNavigationBarType.fixed,
            currentIndex: context.read<PageControlCubit>().selectedPage,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.people_alt_outlined),
                label: 'Consultant',
                activeIcon: Icon(
                  Icons.people,
                  color: Color(0xff2DACC9),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                tooltip: 'Home',
                label: 'Home',
                activeIcon: Icon(
                  Icons.home,
                  color: Color(0xff2DACC9),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: 'Profile',
                activeIcon: Icon(
                  Icons.settings,
                  color: Color(0xff2DACC9),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
