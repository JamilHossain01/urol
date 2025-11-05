class DiscoverFriendsModel {
  DiscoverFriendsModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory DiscoverFriendsModel.fromJson(Map<String, dynamic> json){
    return DiscoverFriendsModel(
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

  final List<DisCoverFriend> data;
  final Meta? meta;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      data: json["data"] == null ? [] : List<DisCoverFriend>.from(json["data"]!.map((x) => DisCoverFriend.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

}

class DisCoverFriend {
  DisCoverFriend({
    required this.id,
    required this.email,
    required this.v,
    required this.beltRank,
    required this.competition,
    required this.contact,
    required this.createdAt,
    required this.disciplines,
    required this.favouriteQuote,
    required this.firstName,
    required this.height,
    required this.homeGym,
    required this.image,
    required this.isverified,
    required this.lastName,
    required this.location,
    required this.notification,
    required this.role,
    required this.status,
    required this.updatedAt,
    required this.weight,
    required this.friendship,
  });

  final String? id;
  final String? email;
  final int? v;
  final String? beltRank;
  final Competition? competition;
  final String? contact;
  final DateTime? createdAt;
  final List<String> disciplines;
  final String? favouriteQuote;
  final String? firstName;
  final Height? height;
  final String? homeGym;
  final String? image;
  final bool? isverified;
  final String? lastName;
  final Location? location;
  final bool? notification;
  final String? role;
  final int? status;
  final DateTime? updatedAt;
  final dynamic? weight;
  final List<dynamic> friendship;

  factory DisCoverFriend.fromJson(Map<String, dynamic> json){
    return DisCoverFriend(
      id: json["_id"],
      email: json["email"],
      v: json["__v"],
      beltRank: json["belt_rank"],
      competition: json["competition"] == null ? null : Competition.fromJson(json["competition"]),
      contact: json["contact"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      disciplines: json["disciplines"] == null ? [] : List<String>.from(json["disciplines"]!.map((x) => x)),
      favouriteQuote: json["favourite_quote"],
      firstName: json["first_name"],
      height: json["height"] == null ? null : Height.fromJson(json["height"]),
      homeGym: json["home_gym"],
      image: json["image"],
      isverified: json["isverified"],
      lastName: json["last_name"],
      location: json["location"] == null ? null : Location.fromJson(json["location"]),
      notification: json["notification"],
      role: json["role"],
      status: json["status"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      weight: json["weight"],
      friendship: json["friendship"] == null ? [] : List<dynamic>.from(json["friendship"]!.map((x) => x)),
    );
  }

}

class Competition {
  Competition({
    required this.eventName,
    required this.eventDate,
    required this.division,
    required this.city,
    required this.state,
    required this.result,
    required this.id,
  });

  final String? eventName;
  final DateTime? eventDate;
  final String? division;
  final String? city;
  final String? state;
  final String? result;
  final String? id;

  factory Competition.fromJson(Map<String, dynamic> json){
    return Competition(
      eventName: json["event_name"],
      eventDate: DateTime.tryParse(json["event_date"] ?? ""),
      division: json["division"],
      city: json["city"],
      state: json["state"],
      result: json["result"],
      id: json["_id"],
    );
  }

}

class Height {
  Height({
    required this.category,
    required this.amount,
    required this.id,
  });

  final String? category;
  final int? amount;
  final String? id;

  factory Height.fromJson(Map<String, dynamic> json){
    return Height(
      category: json["category"],
      amount: json["amount"],
      id: json["_id"],
    );
  }

}

class Location {
  Location({
    required this.coordinates,
    required this.type,
  });

  final List<dynamic> coordinates;
  final String? type;

  factory Location.fromJson(Map<String, dynamic> json){
    return Location(
      coordinates: json["coordinates"] == null ? [] : List<dynamic>.from(json["coordinates"]!.map((x) => x)),
      type: json["type"],
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

  factory Meta.fromJson(Map<String, dynamic> json){
    return Meta(
      page: json["page"],
      limit: json["limit"],
      total: json["total"],
      totalPage: json["totalPage"],
    );
  }

}
