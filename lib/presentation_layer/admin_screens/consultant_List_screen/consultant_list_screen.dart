import 'package:esteshara/business_logic/auth_cubit.dart';
import 'package:esteshara/core/constants/constants.dart';
import 'package:esteshara/generated/assets.dart';
import 'package:esteshara/presentation_layer/admin_screens/consultant_List_screen/consultant_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConsultantListScreen extends StatefulWidget {
  const ConsultantListScreen({super.key,this.isVerified});
  final bool? isVerified;

  @override
  State<ConsultantListScreen> createState() => _ConsultantListScreenState();
}

class _ConsultantListScreenState extends State<ConsultantListScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthCubit>(context).getUsers('user',widget.isVerified??true);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultants List', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff2DACC9)),),
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
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ConsultantDetailsScreen(consultant: context.read<AuthCubit>().filteredUsers?[index],),));
                },
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(Assets.imagesConsultantAvatar),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ConsultantDetailsScreen(consultant: context.read<AuthCubit>().filteredUsers?[index],),));
                        },
                        title: Text(context.read<AuthCubit>().filteredUsers?[index].name??''),
                        subtitle: Text(context.read<AuthCubit>().filteredUsers?[index].email??''),
                      ),
                    ),
                  ],
                ),
              );
            }, separatorBuilder: (context, index) => const SizedBox(height: 10,), itemCount: context.read<AuthCubit>().filteredUsers?.length??0),
          );
        },
      ),
    );
  }
}
