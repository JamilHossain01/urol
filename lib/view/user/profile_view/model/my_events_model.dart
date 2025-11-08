class MyEventsModel {
  MyEventsModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final List<MyEvent>? data;

  factory MyEventsModel.fromJson(Map<String, dynamic> json){
    return MyEventsModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<MyEvent>.from(json["data"]!.map((x) => MyEvent.fromJson(x))),
    );
  }

}

class MyEvent {
  MyEvent({
    required this.id,
    required this.type,
    required this.name,
    required this.venue,
    required this.state,
    required this.city,
    required this.date,
    required this.duration,
    required this.registrationFee,
    required this.eventWebsite,
    required this.user,
    required this.gym,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? type;
  final String? name;
  final String? venue;
  final String? state;
  final String? city;
  final DateTime? date;
  final String? duration;
  final int? registrationFee;
  final String? eventWebsite;
  final String? user;
  final String? gym;
  final Image? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory MyEvent.fromJson(Map<String, dynamic> json){
    return MyEvent(
      id: json["_id"],
      type: json["type"],
      name: json["name"],
      venue: json["venue"],
      state: json["state"],
      city: json["city"],
      date: DateTime.tryParse(json["date"] ?? ""),
      duration: json["duration"],
      registrationFee: json["registration_fee"],
      eventWebsite: json["event_website"],
      user: json["user"],
      gym: json["gym"],
      image: json["image"] == null ? null : Image.fromJson(json["image"]),
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
