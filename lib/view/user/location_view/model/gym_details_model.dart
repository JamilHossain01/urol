class GymDetailsModel {
  GymDetailsModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory GymDetailsModel.fromJson(Map<String, dynamic> json){
    return GymDetailsModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.location,
    required this.id,
    required this.images,
    required this.name,
    required this.description,
    required this.street,
    required this.state,
    required this.city,
    required this.zipCode,
    required this.phone,
    required this.email,
    required this.website,
    required this.facebook,
    required this.instagram,
    required this.matSchedules,
    required this.classSchedules,
    required this.disciplines,
    required this.isClaimed,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final Location? location;
  final String? id;
  final List<Image> images;
  final String? name;
  final String? description;
  final String? street;
  final String? state;
  final String? city;
  final String? zipCode;
  final String? phone;
  final String? email;
  final String? website;
  final String? facebook;
  final String? instagram;
  final List<MatSchedule> matSchedules;
  final List<dynamic> classSchedules;
  final List<String> disciplines;
  final bool? isClaimed;
  final String? user;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      location: json["location"] == null ? null : Location.fromJson(json["location"]),
      id: json["_id"],
      images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
      name: json["name"],
      description: json["description"],
      street: json["street"],
      state: json["state"],
      city: json["city"],
      zipCode: json["zip_code"],
      phone: json["phone"],
      email: json["email"],
      website: json["website"],
      facebook: json["facebook"],
      instagram: json["instagram"],
      matSchedules: json["mat_schedules"] == null ? [] : List<MatSchedule>.from(json["mat_schedules"]!.map((x) => MatSchedule.fromJson(x))),
      classSchedules: json["class_schedules"] == null ? [] : List<dynamic>.from(json["class_schedules"]!.map((x) => x)),
      disciplines: json["disciplines"] == null ? [] : List<String>.from(json["disciplines"]!.map((x) => x)),
      isClaimed: json["isClaimed"],
      user: json["user"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
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

  factory Image.fromJson(Map<String, dynamic> json){
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

  factory Location.fromJson(Map<String, dynamic> json){
    return Location(
      type: json["type"],
      coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x)),
    );
  }

}

class MatSchedule {
  MatSchedule({
    required this.day,
    required this.from,
    required this.fromView,
    required this.to,
    required this.toView,
    required this.id,
  });

  final String? day;
  final int? from;
  final String? fromView;
  final int? to;
  final String? toView;
  final String? id;

  factory MatSchedule.fromJson(Map<String, dynamic> json){
    return MatSchedule(
      day: json["day"],
      from: json["from"],
      fromView: json["from_view"],
      to: json["to"],
      toView: json["to_view"],
      id: json["_id"],
    );
  }

}
