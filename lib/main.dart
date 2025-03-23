import 'package:esteshara/business_logic/auth_cubit.dart';
import 'package:esteshara/business_logic/chat_cubit.dart';
import 'package:esteshara/business_logic/page_control_cubit.dart';
import 'package:esteshara/core/constants/constants.dart';
import 'package:esteshara/presentation_layer/auth_screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/ai_cubit.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => AiCubit(),
        ),
        BlocProvider(
          create: (context) => PageControlCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenSizing.initScreenSizing(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Estshrni',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue[900]!),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
