import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/home/widgets.dart';
import 'package:aura/presentation/screens/settings/about_us.dart';
import 'package:aura/presentation/screens/settings/privacy_policies.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: BlocConsumer<CurrentUserBloc, CurrentUserState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CurrentUserSuccessState) {
            return Stack(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height,
                ),
                Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(state.currentUser.user.profilePic!),
                      ),
                      title: Text(state.currentUser.user.fullname!),
                      trailing: const Icon(CupertinoIcons.arrow_right),
                    ),
                    InkWell(
                      onTap: () => navigatorPush(
                          const PrivacyTermsAndCondition(value: true), context),
                      child: const ListTile(
                        title: Text("Privacy Policy"),
                      ),
                    ),
                    InkWell(
                      onTap: () => navigatorPush(
                          const PrivacyTermsAndCondition(value: false),
                          context),
                      child: const ListTile(
                        title: Text("Terms and condition"),
                      ),
                    ),
                    InkWell(
                      onTap: () => navigatorPush(const AboutUs(), context),
                      child: const ListTile(
                        title: Text("About Us"),
                      ),
                    ),
                  ],
                ),
                Positioned(
                    bottom: 50,
                    right: 18,
                    child: CustomButton(
                        text: "Log Out",
                        onPressed: () {
                          logoutFunction(context);
                        })),
                const Positioned(
                    bottom: 15, right: 160, child: Text("version 1.0"))
              ],
            );
          } else {
            return loading();
          }
        },
      ),
    );
  }
}
