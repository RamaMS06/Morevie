// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Genres welcomeFromJson(String str) => Genres.fromJson(json.decode(str));

String welcomeToJson(Genres data) => json.encode(data.toJson());

class Genres {
  Genres({
    this.genres,
  });

  List<ContentGenres>? genres;

  factory Genres.fromJson(Map<String, dynamic> json) => Genres(
        genres: List<ContentGenres>.from(
            json["genres"].map((x) => ContentGenres.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres!.map((x) => x.toJson())),
      };
}

class ContentGenres {
  ContentGenres({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory ContentGenres.fromJson(Map<String, dynamic> json) => ContentGenres(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
