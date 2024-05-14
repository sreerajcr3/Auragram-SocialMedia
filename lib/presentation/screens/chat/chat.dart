import 'package:aura/bloc/chat/bloc/chat_bloc.dart';
import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/domain/model/chat_model.dart';
import 'package:aura/domain/model/user_model.dart';
import 'package:aura/domain/socket/socket.dart';
import 'package:aura/presentation/screens/chat/widgets/widgets.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_consumer.dart';

class ChatScreen extends StatefulWidget {
  final User user;

  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // late IO.Socket socket;
  TextEditingController messagecontroller = TextEditingController();

  @override
  void initState() {
    context.read<CurrentUserBloc>().add(CurrentUserFetchEvent());
    context.read<ChatBloc>().add(ChatWithUserEvent(userId: widget.user.id!));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return MultiBlocConsumer(
      blocs: [context.watch<CurrentUserBloc>(), context.watch<ChatBloc>()],
      buildWhen: null,
      listener: (context, state) {},
      builder: (context, state) {
        var state1 = state[1];
        if (state[0] is CurrentUserSuccessState) {
          if (state1 is ChatLoadingState) {
            return loading();
          }
          if (state1 is GetChatSuccefullState) {
            List<DateTime> dates = [];
            List<List<Chat>> messgeByDate = [];
            for (Chat message in state1.chat) {
              DateTime createdAt = DateTime.parse(message.createdAt);
              DateTime date =
                  DateTime(createdAt.year, createdAt.month, createdAt.day);
              if (!dates.contains(date)) {
                dates.add(date);
                messgeByDate.add([message]);
              } else {
                messgeByDate.last.add(message);
              }
            }
            // dates =dates.reversed.toList();
            // messgeByDate = messgeByDate.reversed.toList();
            return Scaffold(
              appBar: customAppbarChatPage(fullname: widget.user.fullname!, context: context, profilePic: widget.user.profilePic!),
              body: SizedBox(
                height: height,
                width: width,
                child: Column(
                  children: [
                    Expanded(
                      // height: height / 1.26,
                      child: ListView.builder(
                          itemCount: dates.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            final reversedIndex = dates.length - 1 - index;
                            return Column(
                              children: [
                                DateDivider(date: dates[reversedIndex]),
                                ...messgeByDate[reversedIndex].map((e) {
                                  if (e.sender.id ==
                                      state[0].currentUser.user.id) {
                                    return OwnMessage(
                                      chat: e,
                                    );
                                  } else {
                                    return UserMessage(
                                      chat: e,
                                    );
                                  }
                                })
                              ],
                            );
                            // final chat = state[1].chat[index];
                            // if (chat.sender.id ==
                            //     state[0].currentUser.user.id) {
                            //   return OwnMessage(
                            //     chat: chat,
                            //   );
                            // } else {
                            //   return UserMessage(
                            //     chat: chat,
                            //   );
                            // }
                          }),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: width - 55,
                                  child: Card(
                                    margin: const EdgeInsets.only(
                                        left: 2, right: 2, bottom: 8),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25)),
                                    child: TextFormField(
                                      controller: messagecontroller,
                                      textAlignVertical: TextAlignVertical.center,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 5,
                                      minLines: 1,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Type a message",
                                          contentPadding: const EdgeInsets.all(5),
                                          prefixIcon: IconButton(
                                              onPressed: () {},
                                              icon:
                                                  const Icon(Icons.emoji_emotions))),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: CircleAvatar(
                                    radius: 25,
                                    child: IconButton(
                                        onPressed: () {
                                          SocketService().sendMessage(
                                              loginUsername:
                                                  state[0].currentUser.user.username,
                                              logineduserid:
                                                  state[0].currentUser.user.id,
                                              recieverid: widget.user.id!,
                                              recievername: widget.user.username!,
                                              message: messagecontroller.text);
                                          messagecontroller.clear();
                                        },
                                        icon: const Icon(Icons.send)),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return loading2(context);
          }
        } else {
          return loading2(context);
        }
      },
    );
  }
}
