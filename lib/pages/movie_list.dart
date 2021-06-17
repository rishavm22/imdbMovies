import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:imd_assignment/models/movies.dart';
import 'package:imd_assignment/provider/homePageProvider.dart';
import 'package:provider/provider.dart';

Widget moviesList(BuildContext context, Future<Movies> _movies) {
  return Consumer<HomePageProvider>(builder: (context, data, child) {
    if (_movies != null) {
      return Container(
        height: MediaQuery.of(context).size.height / 1.5,
        child: FutureBuilder<Movies>(
          future: _movies,
          builder: (context, AsyncSnapshot<Movies> snapshot) {
            if (snapshot.hasData && snapshot.data!.errorMessage == '') {
              return ListView.builder(
                itemCount: snapshot.data!.items.length,
                itemBuilder: (context, index) {
                  var movie = snapshot.data!.items[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: kElevationToShadow[4],
                          color: Colors.white),
                      child: listItemMovie(movie),
                    ),
                  );
                },
              );
            }
            return Center(
              child: Container(
                child: errorBox(
                    errorMessage: (snapshot.data!=null)?
                    snapshot.data!.errorMessage:null,
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Container(
        height: MediaQuery.of(context).size.height - 200,
        child: errorBox(),
      );
    }
  });
}

Column errorBox({String? errorMessage}) {
  return Column(
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 100,
          ),
          Text(
            (errorMessage!=null)?errorMessage:'API Limit Crossed Wait Till Tomorrow',
            maxLines: 3,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 3,
                wordSpacing: 5,
                color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ],
      );
}

Row listItemMovie(Item movie) {
  return Row(
    children: [
      Container(
        width: 100,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            movie.image,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150,
              child: Text(
                movie.title,
                style: TextStyle(
                  color: Color(0xff727272),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              movie.year,
              style: TextStyle(
                color: Color(0xff959595),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              decoration: BoxDecoration(
                  color: (double.parse(movie.imDbRating) > 9.0)
                      ? Colors.green
                      : Colors.blue,
                  borderRadius: BorderRadius.circular(25.0)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                child: Text(
                  movie.imDbRating + ' IMDB',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            )
          ],
        ),
      )
    ],
  );
}

void showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.yellow);
}
