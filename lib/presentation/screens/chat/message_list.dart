import 'package:aura/bloc/all_mesages/bloc/all_messages_bloc.dart';
import 'package:aura/bloc/message_list.dart/bloc/message_list_bloc.dart';
import 'package:aura/core/constants/user_demo_pic.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/chat/chat.dart';
import 'package:aura/presentation/screens/chat/functions/functions.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/multi_bloc_builder.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  void initState() {
    context.read<MessageListBloc>().add(GetUsersFromChat());
    context.read<AllMessagesBloc>().add(GetAllChatWithMeEvent());
    // context.read<CurrentUserBloc>().add(CurrentUserFetchEvent());
    super.initState();
  }

  Future<void> refreshmessageList() async {
    await Future.delayed(const Duration(seconds: 2));
    context.read<MessageListBloc>().add(GetUsersFromChat());
    context.read<AllMessagesBloc>().add(GetAllChatWithMeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshmessageList,
      child: Scaffold(
        appBar:
            customAppbar(text: "Message", context: context, onPressed: () {}),
        body: MultiBlocConsumer(
          buildWhen: null,
          blocs: [
            context.watch<MessageListBloc>(),
            context.watch<AllMessagesBloc>()
          ],
          builder: (p0, state) {
            if (state[0] is UsersListFromChatSuccefullState) {
              return ListView.builder(
                itemCount: state[0].usersList.length,
                itemBuilder: (ctx, index) {
                  if (state[1] is GetAllChatWithMeSuccessState) {
                    final user = state[0].usersList[index];
                    final lastMessage = getLastMessage(user.id, state[1].chat);
                   final DateTime finalDate = DateTime.parse(lastMessage.lastmessageTime);
                    return InkWell(
                      onTap: () => navigatorPush(
                          ChatScreen(user: state[0].usersList[index]), context),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              state[0].usersList[index].profilePic != ''
                                  ? state[0].usersList[index].profilePic
                                  : demoProPic),
                        ),
                        title: Text(
                          state[0].usersList[index].username,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          lastMessage.lastMessage,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(timeago
                            .format(finalDate, locale: 'en')),
                      ),
                    );
                  } else {
                    return loading2();
                  }
                },
              );
            } else {
              return loading();
            }
          },
        ),
      ),
    );
  }
}
