import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Presentation/widgets/theme/style.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomFAB(),
          SingleChildScrollView(
            child: Column(
              children: [
                _storyWidget(),
                SizedBox(
                  height: 0.8,
                ),
                _recentUpdatesText(),
                SizedBox(
                  height: 0.8,
                ),
                _Stories(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomFAB extends StatelessWidget {
  const CustomFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 15,
      bottom: 20,
      child: Column(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0.1,
                      blurRadius: 1,
                      offset: Offset(0, 4))
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
                color: Colors.grey[200]),
            child: Icon(
              Icons.edit,
              color: Colors.blueGrey,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0.1,
                      blurRadius: 1,
                      offset: Offset(0, 4))
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
                color: primaryColor),
            child: Icon(
              Icons.camera_alt_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _storyWidget() {
  return Container(
    child: Row(
      children: [
        Container(
          height: 55,
          width: 55,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(2),
                child: Image.asset('assets/profile_default.png'),
              ),
              Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 20,
                    width: 20,
                    child: Icon(Icons.add, size: 15, color: Colors.white),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: primaryColor),
                  ))
            ],
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Status',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            Text('Tab to add status update')
          ],
        ),
      ],
    ),
  );
}

Widget _recentUpdatesText() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
    width: double.infinity,
    child: Text('Recent updates'),
    decoration: BoxDecoration(color: Colors.grey[200]),
  );
}

Widget _Stories() {
  return ListView.builder(
    shrinkWrap: true,
    physics: ScrollPhysics(),
    itemCount: 10,
    itemBuilder: (BuildContext context, int index) {
      return SingleStoryItem();
    },
  );
}

class SingleStoryItem extends StatelessWidget {
  const SingleStoryItem({Key? key}) : super(key: key);

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
                  Column(
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
                      Text(
                        '12:57 AM',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
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
