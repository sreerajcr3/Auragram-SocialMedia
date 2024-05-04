import 'package:aura/bloc/get_user/get_user_bloc.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/chat/chat.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/multi_bloc_builder.dart';

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  void initState() {
    context.read<GetUserBloc>().add(GetAllUsersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(text: "Message", context: context, onPressed: () {}),
      body: MultiBlocConsumer(
        buildWhen: null,
        blocs: [context.watch<GetUserBloc>()],
        builder: (p0, state) {
          if (state[0] is GetAllUsersSuccessState) {
            
          return ListView.builder(
            itemCount: state[0].allUsers.length,
            itemBuilder: (ctx, index) {
            return InkWell(
              onTap: () => navigatorPush(ChatScreen(user: state[0].allUsers[index]), context),
              child: ListTile(title: Text(state[0].allUsers[index].username),));
          });
          }else{
            return loading();
          }
        },
      ),
    );
  }
}
