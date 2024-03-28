import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_8_team3/helper/extintion.dart';
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
          //add resizeToAvoidBottomInset
          resizeToAvoidBottomInset: true,
          //delete the appBar and change it to floatingActionButton
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              backgroundColor: greyColor,
              child: Icon(
                Icons.arrow_back,
                color: darkGreyColor,
              )),
          backgroundColor: Colors.white,
          body: BlocConsumer<ChatBloc, ChatState>(
            listener: (context, state) {
              if (state is ErrorState) {
                context.showErrorSnackBar(context, "there is something wrong.");
              }
            },
            builder: (context, state) {
              return SafeArea(
                child: DashChat(
                  inputOptions: InputOptions(
                
                      //modify the button shape
                      sendButtonBuilder: (Function onSend) {
                        return InkWell(
                          onTap: () {
                            onSend();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xffFEBD5B), //goldColor
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                
                      //delete duplicate  Textfield decoratiion
                
                      inputTextDirection: TextDirection.rtl,
                      inputDecoration: const InputDecoration(
                        hintText: " اكتب هنا",
                
                        //add hint style
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                
                        //change borderRadius from 1 to 25
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                      )),
                  typingUsers: bloc.typingList,
                  messageOptions: MessageOptions(
                    //add max width to massege
                    maxWidth: context.getWidth() *.42,
                    currentUserContainerColor: Colors.grey,
                    containerColor: Colors.white,
                    showCurrentUserAvatar: true,
                    avatarBuilder: (p0, onPressAvatar, onLongPressAvatar) {
                      //add padding to avatar
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(
                          p0.profileImage!,
                          height: 60,
                          width: 60,
                        ),
                      );
                    },
                    currentUserTextColor: Colors.black,
                    textColor: Colors.black,
                    messageDecorationBuilder:
                        (nextMessage, previousMessage, message) {
                      if (message?.user == bloc.user) {
                        return BoxDecoration(
                            //change borderRadius frome only to circular
                            borderRadius: BorderRadius.circular(18),
                            color: greyColor);
                      } else {
                        return BoxDecoration(
                          //change borderRadius frome only to circular
                          borderRadius: BorderRadius.circular(18),
                          color: greyColor,
                        );
                      }
                    },
                    showTime: true,
                    //add onLongPressMessage remove the message
                    onLongPressMessage: (message) {
                      context.read<ChatBloc>().add(RemoveChatEvent(
                          messageToRemove: message,
                          oldMessageList: bloc.userMasseges));
                    },
                  ),
                  currentUser: bloc.user,
                  onSend: (ChatMessage chatMessage) async {
                    bloc.add(SendMassageEvent(chatMessage: chatMessage));
                  },
                  messages: bloc.userMasseges,
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
