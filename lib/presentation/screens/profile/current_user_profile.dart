// ignore_for_file: use_build_context_synchronously

import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/bloc/saved_post/bloc/save_post_bloc.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/profile/settings.dart';
import 'package:aura/presentation/screens/profile/widgets/widgets.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _ProfileState();
}

class _ProfileState extends State<MyProfile> {
  @override
  void initState() {
    context.read<CurrentUserBloc>().add(CurrentUserFetchEvent());
    context.read<SavePostBloc>().add(FetchsavedPostEvent());

    super.initState();
  }
  Future<void> refreshProfile() async {
    await Future.delayed(const Duration(seconds: 2));
    context.read<CurrentUserBloc>().add(CurrentUserFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: customAppbar(
            icon: const Icon(Icons.menu),
            text: "Profile",
            context: context,
            onPressed: () {
              navigatorPush(const SettingsPage(), context);
            },
            leadingIcon: true),
        body: RefreshIndicator(
          onRefresh: refreshProfile,
          child: BlocConsumer<CurrentUserBloc, CurrentUserState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is CurrentUserSuccessState) {
                return SingleChildScrollView(
                  child: entireProfileContent(context, state, screenHeight, screenWidth),
                );
              } else {
                return loading();
              }
            },
          ),
        ),
      ),
    );
  }

  
}
