import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Presentation/pages/calls_page.dart';
import 'package:whatsapp_clone/Presentation/pages/camera_page.dart';
import 'package:whatsapp_clone/Presentation/pages/chat_page.dart';
import 'package:whatsapp_clone/Presentation/pages/status_page.dart';
import 'package:whatsapp_clone/Presentation/widgets/custom_tabbar.dart';
import 'package:whatsapp_clone/Presentation/widgets/theme/style.dart';
import 'package:whatsapp_clone/domain/entities/user_entity.dart';
import 'package:whatsapp_clone/injection_container.dart';

class HomeScreen extends StatefulWidget {
  final CameraDescription camera;
  final CameraController cameraController;
  final UserEntity userInfo;
  HomeScreen(
      {Key? key,
      required this.userInfo,
      required this.camera,
      required this.cameraController})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  int _currentPageIndex = 1;
  PageController _pageController = PageController(initialPage: 1);
  List<Widget> get _pages => [
        CameraPage(
          cameraController: widget.cameraController,
        ),
        ChatPage(
          userInfo: widget.userInfo,
        ),
        StatusPage(),
        CallsPage()
      ];

  bool _isSearch = false;
  Widget _buildSearch() {
    return Container(
      height: 45,
      margin: EdgeInsets.only(top: 25),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          spreadRadius: 1,
          offset: Offset(0.0, 0.5),
        )
      ]),
      child: TextField(
        decoration: InputDecoration(
            hintText: "Search..",
            prefixIcon: InkWell(
              child: Icon(Icons.arrow_back_outlined),
              onTap: () {
                setState(() {
                  _isSearch = false;
                });
              },
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentPageIndex == 0
          ? null
          : AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              flexibleSpace: _isSearch ? _buildSearch() : Container(),
              backgroundColor: _isSearch ? Colors.transparent : primaryColor,
              title: _isSearch ? Container() : Text('WhatsApp Clone'),
              actions: [
                InkWell(
                    onTap: () {
                      setState(() {
                        _isSearch = true;
                      });
                    },
                    child: Icon(Icons.search_outlined)),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.more_vert),
              ],
            ),
      body: Column(
        children: [
          _isSearch == false
              ? _currentPageIndex != 0
                  ? TabBarWidget(
                      index: _currentPageIndex,
                    )
                  : Container(
                      height: 0,
                      width: 0,
                    )
              : Container(
                  height: 0,
                  width: 0,
                ),
          Expanded(
            child: PageView.builder(
                itemCount: _pages.length,
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _pages[index];
                }),
          )
        ],
      ),
    );
  }
}
