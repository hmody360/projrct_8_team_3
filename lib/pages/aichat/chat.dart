import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/widgets/custom_widget.dart';
import '../../helper/colors.dart';
import 'bloc/chat_bloc.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<ChatBloc>();
        return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: const CustomAppBar()),
          backgroundColor: Colors.white,
          body: BlocConsumer<ChatBloc, ChatState>(
            listener: (context, state) {
              if (state is ErrorState) {
                context.showErrorSnackBar(context, "there is something wrong.");
              }
            },
            builder: (context, state) {
              return DashChat(
                inputOptions: InputOptions(
                    //                  sendButtonBuilder: (send) {
                    //               //  return Icon(Icons.send, color: teal);

                    //   return Transform.rotate(
                    //     angle: 180 * 3.1415926535 / 180,
                    //     child: Icon(Icons.send, color: teal),
                    //   );
                    // },
                    textController: TextEditingController(),
                    inputTextStyle: const TextStyle(),
                    inputTextDirection: TextDirection.rtl,
                    inputToolbarPadding: const EdgeInsets.only(right: 0),
                    inputToolbarStyle: const BoxDecoration(color: Colors.white),
                    inputDecoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: teal),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
                      hintTextDirection: TextDirection.rtl,
                      hintText: " اكتب هنا",
                      alignLabelWithHint: true,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),
                    )),
                typingUsers: bloc.typingList,
                messageOptions: MessageOptions(
                  currentUserContainerColor: Colors.grey,
                  containerColor: Colors.white,
                  showCurrentUserAvatar: true,
                  avatarBuilder: (p0, onPressAvatar, onLongPressAvatar) {
                    return Image.asset(
                      p0.profileImage!,
                      height: 60,
                      width: 60,
                    );
                  },
                  currentUserTextColor: Colors.black,
                  textColor: Colors.black,
                  messageDecorationBuilder:
                      (message, previousMessage, nextMessage) {
                    if (message.user == bloc.user) {
                      return BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(1),
                          ),
                          color: greyColor);
                    } else {
                      return BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(12),
                            bottomLeft: Radius.circular(1),
                            bottomRight: Radius.circular(12),
                          ),
                          color: greyColor);
                    }
                  },
                  showTime: true,
                ),
                currentUser: bloc.user,
                onSend: (ChatMessage chatMessage) async {
                  bloc.add(SendMassageEvent(chatMessage: chatMessage));
                },
                messages: bloc.userMasseges,
              );
            },
          ),
        );
      }),
    );
  }
}
