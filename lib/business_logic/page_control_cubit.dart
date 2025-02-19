import 'package:bloc/bloc.dart';
import 'package:esteshara/presentation_layer/main_app/chatting_screens/ai_chat_screen.dart';
import 'package:esteshara/presentation_layer/main_app/home_screens/main_home.dart';
import 'package:esteshara/presentation_layer/profile_screens/profile_screen.dart';
import 'package:flutter/material.dart';

import '../presentation_layer/main_app/consultant_screens/consultant_main.dart';

part 'page_control_state.dart';

class PageControlCubit extends Cubit<PageControlState> {
  PageControlCubit() : super(PageControlInitial());

  int selectedPage = 0;

  List<Widget> screens = [
    const MainHome(),
    const ConsultantMain(),
    AIChatScreen(),
    const ProfileScreen(),
  ];

  void setSelectedPage(int index){
    selectedPage = index;
    emit(PageControlInitial());
  }

  void reset(){
    selectedPage = 0;
    emit(PageControlInitial());
  }

  void nextPage(){
    selectedPage += 1;
    emit(PageControlInitial());
  }


}
