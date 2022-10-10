import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ox21/constants/colors.dart';
import 'package:ox21/constants/image_urls.dart';
import 'package:ox21/home.dart';
import 'package:ox21/pages/content_creator_page.dart';
import 'package:ox21/pages/new_home_page.dart';
import 'package:ox21/pages/newest_home_page.dart';
import 'package:ox21/select_language.dart';
import 'package:ox21/settings.dart';
import 'package:ox21/walletpage.dart';
// import 'package:0x21/pages/'

const themecolor = Color(0xFF0177FB);

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  static const String id="tab";
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
  TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold
  );
  static const List<Widget> _widgetOptions = <Widget>[

    WalletPage(),
    // NewHomePage(),
    // Select_language(),
    NewestHomePage(),
    // Home_Page(),
    SettingsPage()
    // ContentCreatorPage()

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int backCount = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(

        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,

          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(MyImages.dollar),
                color: Color(0xFFA5AAAA),
                size: 24,
              ),
              activeIcon:ImageIcon(
                AssetImage(MyImages.dollar),
                 color: MyColors.primaryColor,
                size: 30,
              ),
              // activeIcon: Icon(Icons.home, size: 30,color: themecolor,),
              // icon: Icon(Icons.home, size: 30,color: Colors.black,),
              label: '',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
                label: '',
                // activeIcon: Icon(Icons.home, size: 30,color: themecolor,),
              icon: Stack(
                children: [
                  ImageIcon(
                    AssetImage(MyImages.post),
                    color: Color(0xFFA5AAAA),
                    size: 25,
                  ),
                ],
              ),
              activeIcon: Stack(
                  children: <Widget>[
                    // Icon(Icons.shopping_cart, size: 30, color: themecolor,),
                    ImageIcon(
                      AssetImage(MyImages.post),
                      color: MyColors.primaryColor,
                      size: 28,
                    ),
                  ],
                ),
            ),

            BottomNavigationBarItem(
              // icon: Icon(Icons.school, size: 30, color: Colors.black,),
              icon: ImageIcon(
                AssetImage(MyImages.settings),
                color: Color(0xFFA5AAAA),
                size: 18,
              ),
              activeIcon: ImageIcon(
                AssetImage(MyImages.settings),
                color: MyColors.primaryColor,
                size: 25,
              ),
              label: '',
              backgroundColor: Colors.white,
            ),

          ],
          currentIndex: _selectedIndex,
          selectedItemColor: MyColors.primaryColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
