
import 'package:flutter/material.dart';
import 'package:flutter_application_2/provider/watchlist_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
class MovieDescription extends StatelessWidget {
  final String name;
  final String description, bannerUrl, posterUrl, vote, releaseDate;
  void Function()? onPressed;
  MovieDescription({super.key, required this.name, required this.description, required this.bannerUrl, required this.posterUrl, required this.vote, required this.releaseDate, required this.onPressed});

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
      body: Container(
        child: ListView(
          children: [
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  Positioned(child: SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(bannerUrl, fit: BoxFit.cover,),
                  )),
                  Positioned.fill(child: DecoratedBox(decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.transparent, Color.fromARGB(255, 12, 1, 1)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.4,0.85],
                    ),
                    
                  ),)),
                  Positioned(
                    bottom: 10,
                    child: Text(" Average rating: $vote",
                    style: GoogleFonts.actor(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                      backgroundColor: const Color.fromARGB(255, 231, 200, 109),
                    ),))
                ],
              ),
            ),
            
            Container(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(name!=null?name:"Not loaded",
                style: GoogleFonts.limelight(
                  fontSize: 30,
                  color: Colors.orange.shade800,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text("Releasing on: $releaseDate",
              style: GoogleFonts.actor(
                fontSize: 20,
              ),),
            ),
            const SizedBox(height: 40,),
            Container(
              
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(description,
              style: GoogleFonts.actor(
                fontSize: 18,
              ),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:50,vertical: 30),
              child: InkWell(
                child: MaterialButton(
                  onPressed: (){
                    onPressed;
                  },
                  height: 50,
                  color: const Color.fromARGB(255, 183, 12, 3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Text("Add to watchlist",
                  style: GoogleFonts.actor(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  ),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}