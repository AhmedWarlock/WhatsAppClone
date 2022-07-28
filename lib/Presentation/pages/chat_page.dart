import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:whatsapp_clone/Presentation/bloc/mychat/cubit/mychat_cubit.dart';
import 'package:whatsapp_clone/Presentation/pages/subpages/select_contact_subpage.dart';
import 'package:whatsapp_clone/Presentation/pages/subpages/single_communication_page.dart';
import 'package:whatsapp_clone/Presentation/widgets/theme/style.dart';
import 'package:whatsapp_clone/domain/entities/user_entity.dart';

class ChatPage extends StatefulWidget {
  final UserEntity userInfo;
  const ChatPage({
    Key? key,
    required this.userInfo,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    BlocProvider.of<MychatCubit>(context).getMyChats(uid: widget.userInfo.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      SelectContactPage(userInfo: widget.userInfo)));
        },
        child: Icon(Icons.chat_outlined),
      ),
      body: BlocBuilder<MychatCubit, MychatState>(
        builder: (context, chatState) {
          if (chatState is MychatLoadedState) {
            return Column(
              children: [
                _myChatList(chatState),
              ],
            );
          } else if (chatState is MychatLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text('Failed'),
            );
          }
        },
      ),
    );
  }
}

class SingleChatBox extends StatelessWidget {
  final String time;
  final String recentMessage;
  final String name;
  const SingleChatBox({
    Key? key,
    required this.time,
    required this.recentMessage,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      child: Image.asset('assets/profile_default.png'),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 260,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          recentMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                time,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 60, right: 10),
            child: Divider(
              thickness: 1.5,
            ),
          )
        ],
      ),
    );
  }
}

Widget _myChatList(MychatLoadedState myChatData) {
  return Expanded(
      child: myChatData.myChats.isEmpty
          ? _emptychatWidget()
          : ListView.builder(
              itemCount: myChatData.myChats.length,
              itemBuilder: (context, index) {
                final myChat = myChatData.myChats[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return SingleCommunicationPage(
                          senderId: myChat.senderUID,
                          senderName: myChat.senderName,
                          recipientId: myChat.recipientUID,
                          recipientName: myChat.recipientName,
                          senderNumber: myChat.senderPhoneNumber,
                          recipientNumber: myChat.recipientPhoneNumber);
                    }));
                  },
                  child: SingleChatBox(
                      time: DateFormat('hh:mm a').format(myChat.time.toDate()),
                      recentMessage: myChat.recentTextMessage,
                      name: myChat.recipientName),
                );
              }));
}

Widget _emptychatWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 150,
        width: 150,
        child: Icon(
          Icons.message,
          color: Colors.white.withOpacity(0.6),
          size: 40,
        ),
        decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.5),
            borderRadius: BorderRadius.all(Radius.circular(100))),
      ),
      Align(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            'Start Chat with friends and family,\n on WhatsApp Clone',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(.6)),
          ),
        ),
      )
    ],
  );
}
