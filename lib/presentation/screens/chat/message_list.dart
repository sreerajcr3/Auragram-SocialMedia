import 'package:aura/bloc/message_list.dart/bloc/message_list_bloc.dart';
import 'package:aura/core/constants/user_demo_pic.dart';
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
    context.read<MessageListBloc>().add(GetUsersFromChat());
    // context.read<CurrentUserBloc>().add(CurrentUserFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(text: "Message", context: context, onPressed: () {}),
      body: MultiBlocConsumer(
        buildWhen: null,
        blocs: [context.watch<MessageListBloc>(),],
        builder: (p0, state) {
          if (state[0] is UsersListFromChatSuccefullState) {
            return ListView.builder(
                itemCount: state[0].usersList.length,
                itemBuilder: (ctx, index) {
                  return InkWell(
                      onTap: () => navigatorPush(
                          ChatScreen(user: state[0].usersList[index]), context),
                      child: ListTile(
                        leading: CircleAvatar(backgroundImage: NetworkImage(state[0].usersList[index].profilePic!=''?state[0].usersList[index].profilePic:demoProPic),),
                        title: Text(state[0].usersList[index].username),
                      ));
                });
          } else {
            return loading();
          }
        },
      ),
    );
  }
}
