import 'package:bloc/bloc.dart';
import 'package:esteshara/presentation_layer/admin_screens/consultant_List_screen/consultant_list_screen.dart';
import 'package:esteshara/presentation_layer/admin_screens/home_screen/admin_home_screen.dart';
import 'package:esteshara/presentation_layer/admin_screens/profile_screens/profile_screen.dart';
import 'package:esteshara/presentation_layer/admin_screens/users_list_screen/users_list_screen.dart';
import 'package:esteshara/presentation_layer/consultant_screens/main_home_screens/consultant_main_home.dart';
import 'package:esteshara/presentation_layer/consultant_screens/profile_consultant/profile_consultant.dart';
import 'package:esteshara/presentation_layer/main_app/chatting_screens/ai_chat_screen.dart';
import 'package:esteshara/presentation_layer/main_app/home_screens/main_home.dart';
import 'package:esteshara/presentation_layer/profile_screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../presentation_layer/consultant_screens/chat_requests_screens/chat_requests_screen.dart';
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
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  List<Widget> consultantScreens = [
    ConsultantChatRequestsScreen(isActive: true,isApproved: true,),
    const ConsultantMainHome(),
    const ProfileConsultant(),
  ];

  List<Widget> adminScreens = [
    const AdminHomeScreen(),
    const UsersListScreen(),
    const ConsultantListScreen(),
    const AdminProfileScreen(),

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
