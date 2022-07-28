import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:whatsapp_clone/Presentation/bloc/phone_auth/phone_auth_cubit.dart';
import 'package:whatsapp_clone/Presentation/pages/set_initial_profile_page.dart';
import 'package:whatsapp_clone/Presentation/widgets/theme/style.dart';

class PhoneVerificationPage extends StatefulWidget {
  final String phoneNumber;
  const PhoneVerificationPage({Key? key, required this.phoneNumber})
      : super(key: key);

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  String get _phoneNumber => widget.phoneNumber;
  TextEditingController _pinCodeController = TextEditingController();
  @override
  // void dispose() {
  //   _pinCodeController.dispose();
  //   super.dispose();
  // }

  void _submitPinCode() {
    if (_pinCodeController.text.isNotEmpty) {
      print('PinCode From Controller' + _pinCodeController.text);

      BlocProvider.of<PhoneAuthCubit>(context)
          .submitSMSCode(_pinCodeController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget PinCodeWidget() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            PinCodeTextField(
              appContext: context,
              length: 6,
              onChanged: (pinCode) {},
              obscureText: true,
              backgroundColor: Colors.transparent,
              controller: _pinCodeController,
            ),
            Text('Enter your 6 digit code '),
          ],
        ),
      );
    }

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(''),
                Text(
                  'Verify your phone number',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: greenColor,
                    fontSize: 18,
                  ),
                ),
                Icon(Icons.more_vert_sharp),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'WhatsApp will send SMS message to verify your phone number.Enter your country code and phone number:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 30,
            ),
            PinCodeWidget(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  onPressed: _submitPinCode,
                  color: greenColor,
                  child: Text(
                    'Next',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
