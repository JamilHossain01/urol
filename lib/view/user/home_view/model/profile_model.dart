class MyProfileModel {
  MyProfileModel({
    this.success,
    this.message,
    this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory MyProfileModel.fromJson(Map<String, dynamic> json) {
    return MyProfileModel(
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
    required this.lastName,
    required this.role,
    required this.updatedAt,
    required this.weight,
  });

  final Location? location;
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
  final String? lastName;
  final String? role;
  final DateTime? updatedAt;
  final String? weight;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      location:
          json["location"] == null ? null : Location.fromJson(json["location"]),
      id: json["_id"],
      email: json["email"],
      v: json["__v"],
      beltRank: json["belt_rank"],
      competition: json["competition"] == null
          ? null
          : Competition.fromJson(json["competition"]),
      contact: json["contact"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      disciplines: json["disciplines"] == null
          ? []
          : List<String>.from(json["disciplines"]!.map((x) => x)),
      favouriteQuote: json["favourite_quote"],
      firstName: json["first_name"],
      height: json["height"] == null ? null : Height.fromJson(json["height"]),
      homeGym: json["home_gym"],
      image: json["image"],
      lastName: json["last_name"],
      role: json["role"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      weight: json["weight"],
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

  factory Competition.fromJson(Map<String, dynamic> json) {
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

  factory Height.fromJson(Map<String, dynamic> json) {
    return Height(
      category: json["category"],
      amount: json["amount"],
      id: json["_id"],
    );
  }
}

class Location {
  Location({
    required this.type,
  });

  final String? type;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json["type"],
    );
  }
}
