import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/pages/main_page.dart';

class HomePage extends StatefulWidget {
  static final String id = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController? _pageController;
  int currentTap = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (int index){
              setState(() {
                currentTap = index;
              });
            },
            children: [
                MainPage(),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 55,
                  margin: EdgeInsets.only(right: 65, left: 65, bottom: 35),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: CupertinoTabBar(

                      onTap: (int index){
                        setState(() {
                          currentTap = index;
                          _pageController?.jumpToPage(index);
                        });
                      },
                      currentIndex: currentTap,
                      activeColor: Colors.black,
                      items: [
                        BottomNavigationBarItem(icon: Icon(Icons.home, size: 32,)),
                        BottomNavigationBarItem(icon: Icon(Icons.search, size: 32,)),
                        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_rounded, size: 32,)),
                        BottomNavigationBarItem(icon: Icon(Icons.person, size: 32,)),
                      ],
                    ),
                  )
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
