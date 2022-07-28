import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Presentation/widgets/theme/style.dart';

class TabBarWidget extends StatelessWidget {
  final int index;
  const TabBarWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: primaryColor),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: 40,
            child: Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
          ),
          Expanded(
              child: CustomTabBarButton(
                  text: 'CHAT',
                  borderColor: index == 1 ? textIconColor : Colors.transparent,
                  textColor: index == 1 ? textIconColor : textIconColorGray,
                  borderWidth: index == 1 ? 3 : 0)),
          Expanded(
              child: CustomTabBarButton(
                  text: 'STATUS',
                  borderColor: index == 2 ? textIconColor : Colors.transparent,
                  textColor: index == 2 ? textIconColor : textIconColorGray,
                  borderWidth: index == 2 ? 3 : 0)),
          Expanded(
              child: CustomTabBarButton(
                  text: 'CALLS',
                  borderColor: index == 3 ? textIconColor : Colors.transparent,
                  textColor: index == 3 ? textIconColor : textIconColorGray,
                  borderWidth: index == 3 ? 3 : 0)),
        ],
      ),
    );
  }
}

class CustomTabBarButton extends StatelessWidget {
  final String text;
  final Color borderColor;
  final Color textColor;
  final double borderWidth;
  const CustomTabBarButton(
      {Key? key,
      required this.text,
      required this.borderColor,
      required this.textColor,
      required this.borderWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: borderColor, width: borderWidth)),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, color: textColor),
      ),
    );
  }
}
