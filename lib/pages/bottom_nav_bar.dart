import "package:flutter/material.dart";
import "package:flutter_application_2/pages/home_page.dart";
import "package:flutter_application_2/pages/watchlist_page.dart";
class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex=0;
  List<Widget> pages=[const HomePage(),const WatchListPage()];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Image.asset(
          'assets/bingeflixC.png',
        fit: BoxFit.cover,
        height: 36,
        filterQuality: FilterQuality.high,
        ),
        centerTitle: true,
      ),

      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey.shade600,
        backgroundColor: Colors.black,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState(() {
            selectedIndex=index;
          });
        },
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_add_outlined),
              label: "Watchlist",
            ),
        ]
        ),
    );
  }
}