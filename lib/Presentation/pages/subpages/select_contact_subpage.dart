import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/Presentation/bloc/device_number/cubit/device_number_cubit.dart';
import 'package:whatsapp_clone/Presentation/bloc/user/cubit/user_cubit.dart';
import 'package:whatsapp_clone/Presentation/pages/subpages/single_communication_page.dart';
import 'package:whatsapp_clone/Presentation/widgets/theme/style.dart';
import 'package:whatsapp_clone/domain/entities/contact_entity.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:whatsapp_clone/domain/entities/user_entity.dart';

class SelectContactPage extends StatefulWidget {
  final UserEntity userInfo;
  SelectContactPage({
    Key? key,
    required this.userInfo,
  }) : super(key: key);

  @override
  State<SelectContactPage> createState() => _SelectContactPageState();
}

class _SelectContactPageState extends State<SelectContactPage> {
  @override
  void initState() {
    BlocProvider.of<DeviceNumberCubit>(context).getDeviceNumbers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceNumberCubit, DeviceNumberState>(
      builder: (context, deviceNumbersState) {
        if (deviceNumbersState is DeviceNumberLoadedState) {
          return BlocBuilder<UserCubit, UserState>(
            builder: (context, userState) {
              if (userState is UserLoadedState) {
                final List<ContactEntity> contacts = [];
                final dbUsers = userState.usersList
                    .where((user) => user.uid != widget.userInfo.uid)
                    .toList();
                // Comparing Database Users to phone contacts
                deviceNumbersState.contacts.forEach((deviceContact) {
                  // Nested
                  dbUsers.forEach((dbUser) {
                    if (dbUser.phoneNumber ==
                        deviceContact.phoneNumber!.replaceAll(' ', '')) {
                      contacts.add(ContactEntity(
                          phoneNumber: dbUser.phoneNumber,
                          status: dbUser.status,
                          label: dbUser.name,
                          uId: dbUser.uid));
                    }
                  });
                  // Nested
                });
                // Body
                //OF
                // THE
                //PAGE
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: primaryColor,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Search Contacts'),
                        Text(
                          '${contacts.length}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    actions: [
                      Icon(Icons.search),
                      Icon(Icons.more_vert),
                    ],
                  ),
                  body: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        _newGroupButton(),
                        SizedBox(
                          height: 10,
                        ),
                        _newContactButton(),
                        SizedBox(
                          height: 10,
                        ),
                        _contactListWidget(contacts),
                      ],
                    ),
                  ),
                );
              } else {
                return Scaffold(
                  body: Center(
                    child: Text('UserStateNotLoaded'),
                  ),
                );
              }
            },
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Search Contacts'),
                ],
              ),
              actions: [
                Icon(Icons.search),
                Icon(Icons.more_vert),
              ],
            ),
            body: Center(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: primaryColor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Loading Contacts',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.8)),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _newGroupButton() {
    return Container(
      child: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(40))),
            child: Icon(
              Icons.people,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            'New Group',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _newContactButton() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: Icon(
                  Icons.person_add,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'New Contact',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Icon(
            FontAwesomeIcons.qrcode,
            color: Colors.green,
          )
        ],
      ),
    );
  }

  Widget _contactListWidget(List<ContactEntity> contacts) {
    return Expanded(
        child: ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            BlocProvider.of<UserCubit>(context)
                .create121ChatChannel(widget.userInfo.uid, contacts[index].uId);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => SingleCommunicationPage(
                        senderId: widget.userInfo.uid,
                        senderName: widget.userInfo.name,
                        recipientId: contacts[index].uId,
                        recipientName: contacts[index].label.toString(),
                        senderNumber: widget.userInfo.phoneNumber,
                        recipientNumber:
                            contacts[index].phoneNumber.toString())));
          },
          child: Container(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Image.asset('assets/profile_default.png'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contacts[index].label.toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'hi there im using this app',
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
