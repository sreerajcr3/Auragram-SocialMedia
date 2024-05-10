import 'package:aura/bloc/Posts/bloc/posts_bloc.dart';
import 'package:aura/bloc/all_mesages/bloc/all_messages_bloc.dart';
import 'package:aura/bloc/bool_update/bloc/bool_bloc.dart';
import 'package:aura/bloc/chat/bloc/chat_bloc.dart';
import 'package:aura/bloc/comment_bloc/bloc/comment_bloc.dart';
import 'package:aura/bloc/create_post/bloc/create_post_bloc.dart';
import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/bloc/delete_post/bloc/delete_post_bloc.dart';
import 'package:aura/bloc/edit_post/bloc/edit_post_bloc.dart';
import 'package:aura/bloc/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:aura/bloc/follow_unfollow/bloc/follow_unfollow_bloc.dart';
import 'package:aura/bloc/get_user/get_user_bloc.dart';
import 'package:aura/bloc/image_picker/bloc/image_picker_bloc.dart';
import 'package:aura/bloc/like_unlike_bloc/bloc/like_unlike_bloc.dart';
import 'package:aura/bloc/logIn_bloc/bloc/log_in_bloc.dart';
import 'package:aura/bloc/message_list.dart/bloc/message_list_bloc.dart';
import 'package:aura/bloc/otpBloc/bloc/otp_bloc.dart';
import 'package:aura/bloc/saved_post/bloc/save_post_bloc.dart';
import 'package:aura/bloc/searchBloc/bloc/search_bloc.dart';
import 'package:aura/bloc/signUpbloc/bloc/sign_up_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/cubit/duration_cubit/cubit/duration_cubit.dart';
import 'package:aura/cubit/explorePage_cubit/explore_page_cubit.dart';
import 'package:aura/cubit/password_cubit/password_cubit.dart';
import 'package:aura/presentation/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OtpBloc()),
        BlocProvider(create: (context) => SignUpBloc()),
        BlocProvider(create: (context) => LogInBloc()),
        BlocProvider(create: (context) => CreatePostBloc()),
        BlocProvider(create: (context) => PostsBloc()),
        BlocProvider(create: (context) => SearchBloc()),
        BlocProvider(create: (context) => CurrentUserBloc()),
        BlocProvider(create: (context) => DeletePostBloc()),
        BlocProvider(create: (context) => LikeUnlikeBloc()),
        BlocProvider(create: (context) => CommentBloc()),
        BlocProvider(create: (context) => SavePostBloc()),
        BlocProvider(create: (context) => FollowUnfollowBloc()),
        BlocProvider(create: (context) => BoolBloc()),
        BlocProvider(create: (context) => ImagePickerBloc()),
        BlocProvider(create: (context) => EditProfileBloc()),
        BlocProvider(create: (context) => EditPostBloc()),
        BlocProvider(create: (context) => GetUserBloc()),
        BlocProvider(create: (context) => ChatBloc()),
        BlocProvider(create: (context) => MessageListBloc()),
        BlocProvider(create: (context) => AllMessagesBloc()),

        //cubit
        BlocProvider(create: (context) => ExplorePageCubit()),
        BlocProvider(create: (context) => DurationCubit()),
        BlocProvider(create: (context) => PasswordCubit()),
      ],
      child: MaterialApp(
        // themeMode: ThemeMode.light,

        darkTheme: darkMode,
        theme: ThemeData(
          primaryColorDark: kBlack,
          primaryColor: kBlack,
          primaryColorLight: kWhite,
          fontFamily: "JosefinSans",
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 255, 255, 255,),
              secondary: kBlack,
              primary: kBlack
              ),
          // scaffoldBackgroundColor: kGrey,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
