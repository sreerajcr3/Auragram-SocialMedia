import 'package:aura/bloc/chat/bloc/chat_bloc.dart';
import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/core/constants/user_demo_pic.dart';
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
        if (state[0] is CurrentUserSuccessState) {
          if (state[1] is ChatLoadingState) {
            return loading();
          }
          if (state[1] is GetChatSuccefullState) {
            // print("conversations from bloc = ${state[1].chat.sender.id}");
            // conversations = state[1].chat;
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(widget.user.profilePic != ""
                          ? widget.user.profilePic!
                          : demoProPic),
                    ),
                    kwidth20,
                    Text(widget.user.fullname!),
                  ],
                ),
              ),
              body: SizedBox(
                height: height,
                width: width,
                child: Stack(
                  children: [
                    SizedBox(
                      height: height / 1.26,
                      child: ListView.builder(
                          itemCount: state[1].chat.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            
                            final chat = state[1].chat[index];
                            if (chat.sender.id ==
                                state[0].currentUser.user.id) {
                              return OwnMessage(
                                chat: chat,
                              );
                            } else {
                              return UserMessage(
                                chat: chat,
                              );
                            }
                          }),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
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
                    )
                  ],
                ),
              ),
            );
          } else {
            return loading2();
          }
        } else {
          return loading2();
        }
      },
    );
  }

  // updateMessages(
  //     {required String senderId,
  //     required String senderUsername,
  //     required String recieverId,
  //     required String recieverUsername}) {
  //   final chat = Chat(
  //       id: '',
  //       sender: User(id: senderId, username: senderUsername),
  //       receiver: User(id: recieverId, username: recieverUsername),
  //       message: messagecontroller.text,
  //       createdAt: '',
  //       updatedAt: '');

  // setState(() {
  //   conversations.add(chat);
  // });
  // }
}
