import 'package:aura/bloc/chat/bloc/chat_bloc.dart';
import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/commonData/common_data.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/core/constants/user_demo_pic.dart';
import 'package:aura/domain/model/chat_model.dart';
import 'package:aura/domain/model/user_model.dart';
import 'package:aura/domain/socket/socket.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_consumer.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatScreen extends StatefulWidget {
  final User user;
  // final String loggedinUserName;
  // final String loggedinUserId;
  // final String recieverusername;
  // final String recieveruserid;

  // final User user;
  const ChatScreen({super.key, required this.user
      // required this.loggedinUserName,
      // required this.loggedinUserId,
      // required this.recieverusername,
      // required this.recieveruserid,
      //  required this.user, required this.loggedinUser
      });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // late IO.Socket socket;
  TextEditingController messagecontroller = TextEditingController();

  @override
  void initState() {
    // context.read<ChatBloc>().add(ChatUpdateEvent());
    context.read<CurrentUserBloc>().add(CurrentUserFetchEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return MultiBlocConsumer(
      blocs: [context.watch<CurrentUserBloc>(), context.watch<ChatBloc>()],
      buildWhen: null,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state[0] is CurrentUserSuccessState) {
          if (state[1] is GetChatSuccefullState) {
            // print("conversations from bloc = ${state[1].chat.sender.id}");
           conversations= state[1].chat;
          }
          return Scaffold(
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.user.profilePic != ""
                          ? widget.user.profilePic!
                          : demoProPic),
                    ),
                    kwidth10,
                    Text(widget.user.username!),
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
                          itemCount: conversations.length,
                          itemBuilder: (context, index) {
                            final chat = conversations[index];
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
                                    hintText: "Type a messagew",
                                    contentPadding: const EdgeInsets.all(5),
                                    prefixIcon: IconButton(
                                        onPressed: () {
                                          print(
                                              "conversation = $conversations");
                                          print(
                                              "list length::${conversations.length}");
                                        },
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

                                    // final time = DateTime.now();

                                    // conversations.add(Chat(
                                    //     id: '',
                                    //     sender: User(
                                    //         id: state[0].currentUser.user.id,
                                    //         username: state[0]
                                    //             .currentUser
                                    //             .user
                                    //             .username),
                                    //     receiver: User(
                                    //         id: widget.user.id,
                                    //         username: widget.user.username),
                                    //     message: messagecontroller.text,
                                    //     createdAt: time.toString(),
                                    //     updatedAt: ''));
                                    // context
                                    //     .read<ChatBloc>()
                                    //     .add(ChatUpdateEvent());
                                    // updateMessages(senderId: state[0].currentUser.user.id, senderUsername: state[0].currentUser.username,recieverId: widget.user.id!,recieverUsername: widget.user.username!);
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

          // else {
          //   return loading();
          // }
        } else {
          return loading();
        }
      },
    );
  }

  updateMessages(
      {required String senderId,
      required String senderUsername,
      required String recieverId,
      required String recieverUsername}) {
    final chat = Chat(
        id: '',
        sender: User(id: senderId, username: senderUsername),
        receiver: User(id: recieverId, username: recieverUsername),
        message: messagecontroller.text,
        createdAt: '',
        updatedAt: '');

    setState(() {
      conversations.add(chat);
    });
  }
}

class OwnMessage extends StatefulWidget {
  final Chat chat;
  const OwnMessage({super.key, required this.chat});

  @override
  State<OwnMessage> createState() => _OwnMessageState();
}

class _OwnMessageState extends State<OwnMessage> {
  @override
  void initState() {
    print("chat time =${widget.chat.createdAt}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: Colors.blueAccent,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 60, top: 10, bottom: 20),
                child: Text(
                  widget.chat.message,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [Text(widget.chat.createdAt), Icon(Icons.done)],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserMessage extends StatelessWidget {
  final Chat chat;

  const UserMessage({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final formattedTime = DateFormat('hh:mm a');
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: kGrey,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 60, top: 10, bottom: 20),
                child: Text(
                  chat.message,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Text(formattedTime
                    .format(DateTime.parse(chat.createdAt).toLocal())),
              )
            ],
          ),
        ),
      ),
    );
  }
}
