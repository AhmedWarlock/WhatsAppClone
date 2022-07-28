import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/Presentation/bloc/auth/auth_cubit.dart';
import 'package:whatsapp_clone/Presentation/bloc/camera/cubit/camera_cubit.dart';
import 'package:whatsapp_clone/Presentation/bloc/phone_auth/phone_auth_cubit.dart';
import 'package:whatsapp_clone/Presentation/bloc/user/cubit/user_cubit.dart';
import 'package:whatsapp_clone/Presentation/pages/phone_verification.dart';
import 'package:whatsapp_clone/Presentation/pages/set_initial_profile_page.dart';
import 'package:whatsapp_clone/Presentation/screens/home_screen.dart';
import 'package:whatsapp_clone/Presentation/widgets/theme/style.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:whatsapp_clone/data/model/user_moder.dart';

class RegisterationScreen extends StatefulWidget {
  RegisterationScreen({Key? key}) : super(key: key);

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  final SnackBar snackBar = SnackBar(
    backgroundColor: Colors.red,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Something is wrong'),
        SizedBox(
          width: 20,
        ),
        Icon(Icons.error_outline_rounded)
      ],
    ),
  );
  void showMySnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Country selectedDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode('249');
  String _countryCode = selectedDialogCountry.phoneCode;
  String _phoneNumber = '';

  TextEditingController _phoneAuthController = TextEditingController();
  @override
  void dispose() {
    _phoneAuthController.dispose();
    super.dispose();
  }

  Widget buildDialogItem(Country country) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: greenColor, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(
            width: 8.0,
          ),
          Text("+${country.phoneCode}"),
          SizedBox(
            width: 8.0,
          ),
          Text("${country.name}"),
          Spacer(),
          Icon(Icons.arrow_drop_down)
        ],
      ),
    );
  }

  void _submitPhoneNumber() {
    if (_phoneAuthController.text.isNotEmpty) {
      _phoneNumber = '+' + _countryCode + _phoneAuthController.text;
      print(_phoneNumber);

      BlocProvider.of<PhoneAuthCubit>(context).submitPhoneNumber(_phoneNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    void openCountryPickerDialog() {
      showDialog(
          context: context,
          builder: (_) => Theme(
                data: Theme.of(context).copyWith(primaryColor: primaryColor),
                child: CountryPickerDialog(
                  title: Text('Select your country code'),
                  isSearchable: true,
                  itemBuilder: buildDialogItem,
                  titlePadding: EdgeInsets.all(8),
                  searchCursorColor: Colors.black,
                  searchInputDecoration: InputDecoration(hintText: 'Search'),
                  onValuePicked: (Country country) {
                    setState(() {
                      selectedDialogCountry = country;
                      _countryCode = country.phoneCode;
                    });
                  },
                ),
              ));
    }

    return Scaffold(
      body: BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
        builder: (context, phoneAuthState) {
          if (phoneAuthState is PhoneAuthSMSCodeReceived) {
            print('Phone code recieved stage 1');
            return PhoneVerificationPage(
              phoneNumber: _phoneNumber,
            );
          } else if (phoneAuthState is PhoneAuthProfileInfo) {
            print('PhoneprofileInfo stage 1');

            return SetInitialProfilePage(
              phoneNumber: _phoneNumber,
            );
          } else if (phoneAuthState is PhoneAuthLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),
            );
          } else if (phoneAuthState is PhoneAuthSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
              if (authState is AuthenticatedState) {
                return BlocBuilder<UserCubit, UserState>(
                  builder: (context, userState) {
                    if (userState is UserLoadedState) {
                      return BlocBuilder<CameraCubit, CameraState>(
                          builder: (context, cameraState) {
                        if (cameraState is CameraInitializedState) {
                          final currentUserInfo = userState.usersList
                              .firstWhere((user) => user.uid == authState.uID,
                                  orElse: () => UserModel(
                                      name: 'name',
                                      email: 'email',
                                      phoneNumber: 'phoneNumber',
                                      isOnline: false,
                                      uid: 'uid',
                                      status: 'status',
                                      profileURL: 'profileURL'));
                          return HomeScreen(
                            userInfo: currentUserInfo,
                            camera: cameraState.camera,
                            cameraController: cameraState.cameraController,
                          );
                        } else {
                          return Scaffold(
                            body: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    color: primaryColor,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text('Loading Camera'),
                                ],
                              ),
                            ),
                          );
                        }
                      });
                    } else {
                      return Scaffold(
                        body: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: primaryColor,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Loading',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                );
              } else {
                print('Returning a container');

                return Container();
              }
            });
          } else if (phoneAuthState is PhoneAuthFailure) {
            print('Authentication Failed this stage');
            return _bodyWidget(openCountryPickerDialog, context);
          } else {
            return _bodyWidget(openCountryPickerDialog, context);
          }
        },
        listener: (context, phoneAuthState) {
          if (phoneAuthState is PhoneAuthSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
        },
      ),
    );
  }

  Scaffold _bodyWidget(void openCountryPickerDialog(), BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
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
            ListTile(
              title: buildDialogItem(selectedDialogCountry),
              onTap: openCountryPickerDialog,
            ),
            Row(
              children: [
                Container(
                  width: 80,
                  height: 42,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1.5, color: greenColor))),
                  child: Text(
                    '+${selectedDialogCountry.phoneCode}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: Container(
                  height: 42,
                  child: TextField(
                    controller: _phoneAuthController,
                    onChanged: (value) {},
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Enter Phone Number',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: greenColor)),
                    ),
                  ),
                )),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  onPressed: _submitPhoneNumber,
                  color: greenColor,
                  child: Text(
                    'Next',
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
