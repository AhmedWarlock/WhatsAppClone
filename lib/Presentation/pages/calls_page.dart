import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Presentation/widgets/theme/style.dart';

class CallsPage extends StatelessWidget {
  const CallsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {},
          child: Icon(
            Icons.add_call,
            color: Colors.white,
            size: 30,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return SingleCallItem();
                },
              ),
            ),
          ],
        ));
  }
}

class SingleCallItem extends StatelessWidget {
  const SingleCallItem({Key? key}) : super(key: key);

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
                          'User Name',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.call_missed_outlined,
                              color: Colors.red,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('yesterday')
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.call,
                color: primaryColor,
              )
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
