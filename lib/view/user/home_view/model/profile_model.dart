class MyProfileModel {
  MyProfileModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory MyProfileModel.fromJson(Map<String, dynamic> json){
    return MyProfileModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
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

  final String? id;
  final String? email;
  final int? v;
  final String? beltRank;
  final dynamic competition;
  final String? contact;
  final DateTime? createdAt;
  final List<String> disciplines;
  final String? favouriteQuote;
  final String? firstName;
  final Height? height;
  final String? homeGym;
  final dynamic image;
  final String? lastName;
  final String? role;
  final DateTime? updatedAt;
  final String? weight;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["_id"],
      email: json["email"],
      v: json["__v"],
      beltRank: json["belt_rank"],
      competition: json["competition"],
      contact: json["contact"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      disciplines: json["disciplines"] == null ? [] : List<String>.from(json["disciplines"]!.map((x) => x)),
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
