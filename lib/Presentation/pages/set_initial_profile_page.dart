import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/Presentation/bloc/phone_auth/phone_auth_cubit.dart';

import 'package:whatsapp_clone/Presentation/screens/home_screen.dart';
import 'package:whatsapp_clone/Presentation/widgets/theme/style.dart';

class SetInitialProfilePage extends StatefulWidget {
  final String phoneNumber;
  const SetInitialProfilePage({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<SetInitialProfilePage> createState() => _SetInitialProfilePageState();
}

class _SetInitialProfilePageState extends State<SetInitialProfilePage> {
  String get _phoneNumber => widget.phoneNumber;
  TextEditingController _nameController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Widget _rowWidget() {
    return Container(
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: textIconColorGray),
            child: Icon(
              Icons.camera_alt,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Enter your name'),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: textIconColorGray),
            child: Icon(
              Icons.insert_emoticon_sharp,
            ),
          ),
        ],
      ),
    );
  }

  void _submitProfileInfo() {
    if (_nameController.text.isNotEmpty) {
      print(_nameController.text);

      BlocProvider.of<PhoneAuthCubit>(context)
          .submitProfileInfo(_nameController.text, '', _phoneNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              Text(
                'Profile Info',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Please provide your name and an optional profile photo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              _rowWidget(),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: MaterialButton(
                    onPressed: _submitProfileInfo,
                    color: greenColor,
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
