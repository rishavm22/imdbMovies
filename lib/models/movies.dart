class Movies {

  final List<Item> items;
  final String errorMessage;

  Movies({
    required this.items,
    required this.errorMessage,
  });

  factory Movies.fromJson(Map<String, dynamic> json) => Movies(
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    errorMessage: json["errorMessage"],
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "errorMessage": errorMessage,
  };

  Movies getMovie(String title){
    Movies selectedMovies;
    List<int> num=[];
    for(var i=0; i<items.length;i++){
      if(items[i].title.toLowerCase().contains(title)) {
        num.add(i);
      }
    }
    selectedMovies = Movies(items: [ for(var j=0;j<num.length;j++)items[j]], errorMessage: '');
    return selectedMovies;
  }
}

class Item {

  final String id;
  final String rank;
  final String title;
  final String fullTitle;
  final String year;
  final String image;
  final String crew;
  final String imDbRating;
  final String imDbRatingCount;

  Item({
    required this.id,
    required this.rank,
    required this.title,
    required this.fullTitle,
    required this.year,
    required this.image,
    required this.crew,
    required this.imDbRating,
    required this.imDbRatingCount,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    rank: json["rank"],
    title: json["title"],
    fullTitle: json["fullTitle"],
    year: json["year"],
    image: json["image"],
    crew: json["crew"],
    imDbRating: json["imDbRating"],
    imDbRatingCount: json["imDbRatingCount"],
  );

  Map<String, dynamic> toJson() => {
  "id": id,
  "rank": rank,
  "title": title,
  "fullTitle": fullTitle,
  "year": year,
  "image": image,
  "crew": crew,
  "imDbRating": imDbRating,
  "imDbRatingCount": imDbRatingCount,
  };

}
