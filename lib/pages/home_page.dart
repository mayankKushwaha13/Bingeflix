import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/material.dart";
import "package:flutter_application_2/pages/movie_description.dart";
import "package:flutter_application_2/provider/watchlist_provider.dart";
import "package:google_fonts/google_fonts.dart";
import "package:provider/provider.dart";
import "package:tmdb_api/tmdb_api.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List trendingMovies=[];
  List topRatedMovies=[];
  List playedNow =[];
  final apikey = 'e442295810207612330670acbee959d1';
  final accessToken ='eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNDQyMjk1ODEwMjA3NjEyMzMwNjcwYWNiZWU5NTlkMSIsInN1YiI6IjY1OTdhMzRlNWNjMTFkNzdkODdkN2ZmZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.j3-vDivZdsWxopb95CjVo9gMm0k5PjGrwJInErNSbjQ';

  @override
  void initState(){
    loadMovies();
    super.initState();
  }
  loadMovies()async{
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apikey, accessToken),
   logConfig: const ConfigLogger(
    showLogs: true,
    showErrorLogs: true,
   ) );

   Map trendingResults = await tmdbWithCustomLogs.v3.trending.getTrending();
   Map topRatedResults = await tmdbWithCustomLogs.v3.movies.getTopRated();
   Map playedNowResults = await tmdbWithCustomLogs.v3.movies.getNowPlaying();
   setState(() {
     trendingMovies=trendingResults['results'];
     topRatedMovies=topRatedResults['results'];
     playedNow=playedNowResults['results'];
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Trending Movies",
                style: GoogleFonts.acme(
                  fontSize: 25,
                ),
                ),
                const SizedBox(height: 30,),
                SizedBox(
                  width: double.infinity,
                  child: CarouselSlider.builder(
                    itemCount: trendingMovies.length, 
                    options: CarouselOptions(
                      height: 440,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.6,
                      autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                    ),
                    itemBuilder: (context,itemIndex,pageViewIndex){
                      return trendingMovies[itemIndex]['original_title']!=null?InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDescription(
                            name: trendingMovies[itemIndex]['original_title'], 
                            description: trendingMovies[itemIndex]['overview'], 
                            bannerUrl: 'https://image.tmdb.org/t/p/w500'+trendingMovies[itemIndex]['backdrop_path'], 
                            posterUrl: 'https://image.tmdb.org/t/p/w500'+trendingMovies[itemIndex]['poster_path'], 
                            vote: trendingMovies[itemIndex]['vote_average'].toString(),
                            onPressed: () =>Provider.of<WatchListProvider>(context, listen: false).addToWatchlist(trendingMovies,trendingMovies[itemIndex]['original_title']),
                            releaseDate: trendingMovies[itemIndex]['release_date']),));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 300,
                                width: 200,
                                child: Image.network(
                                  'http://image.tmdb.org/t/p/w500'+trendingMovies[itemIndex]['poster_path'],
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover,
                              
                                ),
                              ),
                              Container(
                                child: Text(trendingMovies[itemIndex]['original_title']!=null?trendingMovies[itemIndex]['title']:" ",
                                style: GoogleFonts.acme(
                                  fontSize: 20
                                ),),
                              )
                            ],
                          ),
                        ),
                      ):InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDescription(
                            name: playedNow[itemIndex]['original_title'], 
                            description: playedNow[itemIndex]['overview'], 
                            bannerUrl: 'https://image.tmdb.org/t/p/w500'+playedNow[itemIndex]['backdrop_path'], 
                            posterUrl: 'https://image.tmdb.org/t/p/w500'+playedNow[itemIndex]['poster_path'], 
                            vote: playedNow[itemIndex]['vote_average'].toString(),
                            onPressed: () => Provider.of<WatchListProvider>(context, listen: false).addToWatchlist(playedNow,playedNow[itemIndex]['original_title']),
                            releaseDate: playedNow[itemIndex]['release_date']),));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 300,
                                width: 200,
                                child: Image.network(
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                    'http://image.tmdb.org/t/p/w500'+playedNow[itemIndex]['poster_path'],
                                  ),
                              ),
                              Container(
                                child: Text(playedNow[itemIndex]['original_title'] ?? "",
                                style: GoogleFonts.acme(
                                  fontSize: 20,
                                ),),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    ),
                ),

                
                Text(
                  "Top Rated Movies",
                  style: GoogleFonts.acme(
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 440,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: topRatedMovies.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDescription(
                            name: topRatedMovies[index]['original_title'], 
                            description: topRatedMovies[index]['overview'], 
                            bannerUrl: 'https://image.tmdb.org/t/p/w500'+topRatedMovies[index]['backdrop_path'], 
                            posterUrl: 'https://image.tmdb.org/t/p/w500'+topRatedMovies[index]['poster_path'], 
                            vote: topRatedMovies[index]['vote_average'].toString(), 
                            onPressed: () =>Provider.of<WatchListProvider>(context, listen: false).addToWatchlist(topRatedMovies,topRatedMovies[index]['original_title']),
                            releaseDate: topRatedMovies[index]['release_date']),));
                        },
                                child: SizedBox(
                                  height: 300,
                                  width: 200,
                                  child: Image.network(
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                    'http://image.tmdb.org/t/p/w500'+topRatedMovies[index]['poster_path'],
                                  ),
                                ),
                              ),
                              Container(
                                
                                child: Text(topRatedMovies[index]['original_title'] ?? "",
                                style: GoogleFonts.acme(
                                  fontSize: 20,
                                ),),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    ),
                ),

                Text(
                "Movies Being Played Now",
                style: GoogleFonts.acme(
                  fontSize: 25,
                ),
                ),
                const SizedBox(height: 15,),
                SizedBox(
                  width: double.infinity,
                  child: CarouselSlider.builder(
                    itemCount: playedNow.length, 
                    options: CarouselOptions(
                      height: 500,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.55,
                      autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                    ),
                    itemBuilder: (context,itemIndex,pageViewIndex){
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDescription(
                            name: playedNow[itemIndex]['original_title'], 
                            description: playedNow[itemIndex]['overview'], 
                            bannerUrl: 'https://image.tmdb.org/t/p/w500'+playedNow[itemIndex]['backdrop_path'], 
                            posterUrl: 'https://image.tmdb.org/t/p/w500'+playedNow[itemIndex]['poster_path'], 
                            vote: playedNow[itemIndex]['vote_average'].toString(), 
                            onPressed: () =>Provider.of<WatchListProvider>(context, listen: false).addToWatchlist(playedNow, playedNow[itemIndex]['original_title']),
                            releaseDate: playedNow[itemIndex]['release_date']),));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 300,
                                width: 200,
                                child: Image.network(
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                    'http://image.tmdb.org/t/p/w500'+playedNow[itemIndex]['poster_path'],
                                  ),
                              ),
                              Container(
                                child: Text(playedNow[itemIndex]['original_title'] ?? "",
                                style: GoogleFonts.acme(
                                  fontSize: 20,
                                ),),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}