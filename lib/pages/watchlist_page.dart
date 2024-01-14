import "dart:async";
import "package:flutter_application_2/provider/watchlist_provider.dart";
import "package:google_fonts/google_fonts.dart";
import "package:provider/provider.dart";
import "package:flutter/material.dart";

class WatchListPage extends StatelessWidget {
  const WatchListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => WatchListProvider(),
        child: Consumer<WatchListProvider>(
          builder: (context, value, child){
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: value.watchlistMovies.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        title: Text(value.watchlistMovies[index][0],
                        style: GoogleFonts.acme(
                          color: Colors.amber,
                        ),),
                      );
                    })
                    )
                )
              ],
            );
          }
        ),
      )
    );
  }
}