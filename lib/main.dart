import 'package:aura/bloc/Posts/bloc/posts_bloc.dart';
import 'package:aura/bloc/create_post/bloc/create_post_bloc.dart';
import 'package:aura/bloc/cubit/cubit/explore_page_cubit.dart';
import 'package:aura/bloc/logIn_bloc/bloc/log_in_bloc.dart';
import 'package:aura/bloc/otpBloc/bloc/otp_bloc.dart';
import 'package:aura/bloc/searchBloc/bloc/search_bloc.dart';
import 'package:aura/bloc/signUpbloc/bloc/sign_up_bloc.dart';
import 'package:aura/presentation/screens/splash_screen.dart';
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

        //cubit
        BlocProvider(create: (context) => ExplorePageCubit())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: "Poppins",
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen()),
    );
  }
}
