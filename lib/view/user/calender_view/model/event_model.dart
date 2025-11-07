class AllEventModel {
  AllEventModel({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory AllEventModel.fromJson(Map<String, dynamic> json) {
    return AllEventModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.data,
    required this.meta,
  });

  final List<AllEvent> data;
  final Meta? meta;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      data: json["data"] == null
          ? []
          : List<AllEvent>.from(json["data"]!.map((x) => AllEvent.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }
}

class AllEvent {
  AllEvent({
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
  final Image? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory AllEvent.fromJson(Map<String, dynamic> json) {
    return AllEvent(
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

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      key: json["key"],
      url: json["url"],
      id: json["_id"],
    );
  }
}

class Meta {
  Meta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json["page"],
      limit: json["limit"],
      total: json["total"],
      totalPage: json["totalPage"],
    );
  }
}
