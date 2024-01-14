import "package:flutter/material.dart";
import "package:flutter_application_2/pages/bottom_nav_bar.dart";
class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(120)
            ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Image.asset(
              'assets/bingeflixC.png'
            ),
          ),
          Text(
            "Your personal movies listing app",
            textAlign: TextAlign.center,
            
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 20,
            ),
          ),
          const Padding(padding: EdgeInsets.all(20)),
          GestureDetector(
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return const NavBar();
            },)),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage("assets/red.jpg"),
                  ),
                  borderRadius: BorderRadius.circular(12),
              ),
              child: const Text("Get Started",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
          )
        ],
      )
    );
  }
}