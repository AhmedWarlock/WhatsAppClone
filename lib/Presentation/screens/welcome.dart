import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Presentation/screens/registeration.dart';
import 'package:whatsapp_clone/Presentation/widgets/theme/style.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome to WhatsApp Clone',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Container(
              width: 300,
              height: 300,
              child: Image(
                image: AssetImage('assets/brand.png'),
              ),
            ),
            Column(
              children: [
                Text(
                  "Read our privacy policy, tab 'Agree and Continue' to accept the terms of service",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => RegisterationScreen()));
                  },
                  child: Text(
                    'AGREE AND CONTINUE',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  color: greenColor,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
