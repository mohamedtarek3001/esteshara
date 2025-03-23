import 'package:esteshara/business_logic/auth_cubit.dart';
import 'package:esteshara/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/chat_cubit.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthCubit>(context).getUsers('consultant',true);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff2DACC9)),),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if(context.read<AuthCubit>().isLoading){
            return const Center(child: CircularProgressIndicator(),);
          }
          return Container(
            height: ScreenSizing.height,
            width: ScreenSizing.width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.separated(itemBuilder: (context, index) {
              return Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    child: Center(child: Icon(Icons.account_circle,size: 60,),),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(context.read<AuthCubit>().filteredUsers?[index].name??''),
                      subtitle: Text(context.read<AuthCubit>().filteredUsers?[index].email??''),
                    ),
                  ),
                ],
              );
            }, separatorBuilder: (context, index) => SizedBox(height: 10,), itemCount: context.read<AuthCubit>().filteredUsers?.length??0),
          );
        },
      ),
    );
  }
}
