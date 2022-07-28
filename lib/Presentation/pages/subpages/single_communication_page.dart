import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone/Presentation/bloc/comms/cubit/comms_cubit.dart';
import 'package:whatsapp_clone/Presentation/widgets/theme/style.dart';
import 'package:whatsapp_clone/domain/entities/text_message_entity.dart';

class SingleCommunicationPage extends StatefulWidget {
  final String senderId;
  final String senderName;
  final String recipientId;
  final String recipientName;
  final String senderNumber;
  final String recipientNumber;

  const SingleCommunicationPage({
    Key? key,
    required this.senderId,
    required this.senderName,
    required this.recipientId,
    required this.recipientName,
    required this.senderNumber,
    required this.recipientNumber,
  }) : super(key: key);

  @override
  State<SingleCommunicationPage> createState() =>
      _SingleCommunicationPageState();
}

class _SingleCommunicationPageState extends State<SingleCommunicationPage> {
  final TextEditingController _textMessageController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  void _sendMessage() {
    if (_textMessageController.text.isNotEmpty) {
      BlocProvider.of<CommsCubit>(context).sendTextMessage(
          message: _textMessageController.text,
          senderName: widget.senderName,
          senderId: widget.senderId,
          senderPhoneNumber: widget.senderNumber,
          recipientName: widget.recipientName,
          recipientId: widget.recipientId,
          recipientPhoneNumber: widget.recipientNumber);
      _textMessageController.clear();
    }
  }

  @override
  void initState() {
    BlocProvider.of<CommsCubit>(context).getMessages(
        senderID: widget.senderId, recipientID: widget.recipientId);
    super.initState();
  }

  @override
  void dispose() {
    _textMessageController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(''),
        automaticallyImplyLeading: false,
        actions: [
          Icon(
            Icons.video_call_sharp,
            size: 35,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.call,
            size: 35,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.more_vert,
            size: 35,
          )
        ],
        flexibleSpace: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 45,
                      width: 45,
                      child: Image.asset('assets/profile_default.png'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.recipientName,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 22),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<CommsCubit, CommsState>(
        builder: (context, commsState) {
          if (commsState is CommsEstablishedState) {
            return _bodyWidget(commsState);
          } else if (commsState is CommsFailedState) {
            return Center(
              child: Text('CommsFailedState'),
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              color: primaryColor,
            ));
          }
        },
      ),
    );
  }

  Widget _bodyWidget(CommsEstablishedState commsEtablishesdState) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: Image.asset(
            'assets/background_wallpaper.png',
            fit: BoxFit.cover,
          ),
        ),
        Column(
          children: [
            _messagesListWidget(commsEtablishesdState.messages),
            _sendMessageField(),
          ],
        )
      ],
    );
  }

  Widget _messagesListWidget(List<TextMessageEntity> messages) {
    Timer(Duration(milliseconds: 100), () {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.easeInQuad);
    });
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          if (message.senderUID == widget.senderId) {
            return _messageLayout(
                axisAlignment: CrossAxisAlignment.end,
                boxAlign: CrossAxisAlignment.end,
                nip: BubbleNip.rightTop,
                color: Colors.lightGreen[400],
                time: DateFormat('hh:mm a').format(message.time.toDate()),
                text: message.message,
                textAlign: TextAlign.left);
          } else {
            return _messageLayout(
                axisAlignment: CrossAxisAlignment.start,
                boxAlign: CrossAxisAlignment.start,
                nip: BubbleNip.leftTop,
                color: Colors.white,
                time: DateFormat('hh:mm a').format(message.time.toDate()),
                text: message.message,
                textAlign: TextAlign.left);
          }
        },
      ),
    );
  }

  Widget _messageLayout(
      {required CrossAxisAlignment axisAlignment,
      required boxAlign,
      required BubbleNip? nip,
      required Color? color,
      required String time,
      required String text,
      required TextAlign textAlign}) {
    return Column(
      crossAxisAlignment: axisAlignment,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.90),
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(3),
            child: Bubble(
              nip: nip,
              color: color,
              child: Column(
                crossAxisAlignment: axisAlignment,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text,
                    textAlign: textAlign,
                    style: TextStyle(fontSize: 19),
                  ),
                  Text(
                    time,
                    textAlign: textAlign,
                    style: TextStyle(
                        fontSize: 12, color: Colors.black.withOpacity(.4)),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _sendMessageField() {
    return Container(
      child: Row(
        children: [
          Expanded(
              child: Container(
            margin: EdgeInsets.only(left: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.insert_emoticon,
                  color: Colors.grey[500],
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 80),
                    child: Scrollbar(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        maxLines: null,
                        style: TextStyle(fontSize: 14),
                        controller: _textMessageController,
                        decoration: InputDecoration(
                            hintText: 'Type a message',
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
                _textMessageController.text.isEmpty
                    ? Row(
                        children: [
                          Icon(Icons.link),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.camera_alt),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      )
                    : Container()
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(80)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 1,
                      spreadRadius: 1,
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(0, 0.5))
                ]),
          )),
          InkWell(
            onTap: () {
              if (_textMessageController.text.isNotEmpty) {
                _sendMessage();
              }
            },
            child: Container(
              margin: EdgeInsets.all(8),
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: _textMessageController.text.isEmpty
                  ? Icon(
                      Icons.mic,
                      color: textIconColor,
                    )
                  : Icon(
                      Icons.send,
                      color: textIconColor,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
