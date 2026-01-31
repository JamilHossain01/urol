class NearByOpenMatsModel {
  NearByOpenMatsModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final List<NearByOpenMatsData>? data;

  factory NearByOpenMatsModel.fromJson(Map<String, dynamic> json) {
    return NearByOpenMatsModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<NearByOpenMatsData>.from(
              json["data"]!.map((x) => NearByOpenMatsData.fromJson(x))),
    );
  }
}

class NearByOpenMatsData {
  NearByOpenMatsData({
    required this.id,
    required this.images,
    required this.name,
    required this.location,
    required this.distance,
    required this.day,
    required this.from,
    required this.to,
    required this.fromView,
    required this.toView,
  });

  final String? id;
  final List<Image> images;
  final String? name;
  final Location? location;
  final double? distance;
  final String? day;
  final int? from;
  final int? to;
  final String? fromView;
  final String? toView;

  factory NearByOpenMatsData.fromJson(Map<String, dynamic> json) {
    return NearByOpenMatsData(
      id: json["_id"],
      images: json["images"] == null
          ? []
          : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
      name: json["name"],
      location:
          json["location"] == null ? null : Location.fromJson(json["location"]),
      distance: json["distance"],
      day: json["day"],
      from: json["from"],
      to: json["to"],
      fromView: json["from_view"],
      toView: json["to_view"],
    );
  }
}

class Image {
  Image({
    required this.key,
    required this.url,
    required this.id,
  });

  final String? key;
  final String? url;
  final String? id;

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      key: json["key"],
      url: json["url"],
      id: json["_id"],
    );
  }
}

class Location {
  Location({
    required this.type,
    required this.coordinates,
  });

  final String? type;
  final List<double> coordinates;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json["type"],
      coordinates: json["coordinates"] == null
          ? []
          : List<double>.from(json["coordinates"]!.map((x) => x)),
    );
  }
}
