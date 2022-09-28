// To parse this JSON data, do
//
//     final queryAuthors = queryAuthorsFromJson(jsonString);

import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    this.data,
  });

  List<Gifs>? data;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        data: json["data"] == null
            ? null
            : List<Gifs>.from(json["data"].map((x) => Gifs.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data":
            data == null ? null : List<Gifs>.from(data!.map((x) => x.toJson())),
      };
}

class Gifs {
  Gifs({
    this.type,
    this.id,
    this.url,
    this.username,
    this.title,
    this.images,
  });

  String? type;
  String? id;
  String? url;
  String? username;
  String? title;
  Images? images;

  factory Gifs.fromJson(Map<String, dynamic> json) => Gifs(
        type: json["type"] ?? null,
        id: json["id"] ?? null,
        url: json["url"] ?? null,
        username: json["username"] ?? null,
        title: json["title"],
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type ?? null,
        "id": id ?? null,
        "url": url ?? null,
        "username": username ?? null,
        "title": title ?? null,
        "images": images == null ? null : images!.toJson(),
      };
}

class Images {
  Images({
    this.original,
  });

  FixedHeight? original;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        original: json["original"] == null
            ? null
            : FixedHeight.fromJson(json["original"]),
      );

  Map<String, dynamic> toJson() => {
        "original": original == null ? null : original!.toJson(),
      };
}

class FixedHeight {
  FixedHeight({
    this.height,
    this.width,
    this.size,
    this.url,
    this.mp4Size,
    this.mp4,
    this.webpSize,
    this.webp,
    this.frames,
    this.hash,
  });

  String? height;
  String? width;
  String? size;
  String? url;
  String? mp4Size;
  String? mp4;
  String? webpSize;
  String? webp;
  String? frames;
  String? hash;

  factory FixedHeight.fromJson(Map<String, dynamic> json) => FixedHeight(
        height: json["height"] == null ? null : json["height"],
        width: json["width"] == null ? null : json["width"],
        size: json["size"] == null ? null : json["size"],
        url: json["url"] == null ? null : json["url"],
        mp4Size: json["mp4_size"] == null ? null : json["mp4_size"],
        mp4: json["mp4"] == null ? null : json["mp4"],
        webpSize: json["webp_size"] == null ? null : json["webp_size"],
        webp: json["webp"] == null ? null : json["webp"],
        frames: json["frames"] == null ? null : json["frames"],
        hash: json["hash"] == null ? null : json["hash"],
      );

  Map<String, dynamic> toJson() => {
        "height": height == null ? null : height,
        "width": width == null ? null : width,
        "size": size == null ? null : size,
        "url": url == null ? null : url,
        "mp4_size": mp4Size == null ? null : mp4Size,
        "mp4": mp4 == null ? null : mp4,
        "webp_size": webpSize == null ? null : webpSize,
        "webp": webp == null ? null : webp,
        "frames": frames == null ? null : frames,
        "hash": hash == null ? null : hash,
      };
}
